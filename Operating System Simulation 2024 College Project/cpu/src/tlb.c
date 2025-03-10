#include "cpu.h"

int tiempo = 0;
int tiempo_carga = 0;
pthread_mutex_t mutex_tiempo;
pthread_mutex_t mutex_tiempo_carga;
pthread_mutex_t mutex_tlb;

static int obtener_tiempo();
static int obtener_tiempo_carga();
static int buscar_indice_entrada_menor_uso(t_list* lista);
static int buscar_indice_entrada_mas_vieja(t_list* lista);
static bool menor_uso(t_entrada* siguiente_entrada, t_entrada* menor_entrada);
static bool mas_vieja(t_entrada* siguiente_entrada, t_entrada* menor_entrada);
static void reemplazo_por_LRU(t_entrada* nueva_entrada);
static void reemplazo_por_FIFO(t_entrada* nueva_entrada);
//====================================================================================================================

uint32_t consultar_tlb(int pid, uint32_t pagina){

    if(cantidad_entradas_tlb == 0){
        //tlb deshabilitada
        return -2;
    }else {
        pthread_mutex_lock(&mutex_tlb);
        int tamanio_actual_tlb = list_size(tlb);
        pthread_mutex_unlock(&mutex_tlb);

        //HIT: MARCO
        for (int i = 0; i < tamanio_actual_tlb; i++) {
            
            pthread_mutex_lock(&mutex_tlb);
            t_entrada* entrada_actual = (t_entrada*) list_get(tlb, i);
            pthread_mutex_unlock(&mutex_tlb);


            if (entrada_actual->pid == pid && entrada_actual->pagina == pagina) {
                t_config* config_algoritmo = config_create(path_config);

                if(strcmp(config_get_string_value(config_algoritmo, "ALGORITMO_TLB"), "LRU") == 0){
                    config_destroy(config_algoritmo);
                    config_algoritmo = NULL;
                    entrada_actual->ultimo_uso = obtener_tiempo();
                }
                if (config_algoritmo != NULL) config_destroy(config_algoritmo);
                
                return entrada_actual->marco;
            }
        }

        //MISS: -1
        return -1;
    }
} 

static int obtener_tiempo(){
	pthread_mutex_lock(&mutex_tiempo);
	tiempo++;
	pthread_mutex_unlock(&mutex_tiempo);
	return tiempo;
}

static int obtener_tiempo_carga(){
	pthread_mutex_lock(&mutex_tiempo);
	tiempo_carga++;
	pthread_mutex_unlock(&mutex_tiempo);
    return tiempo_carga;
}
	
void agregar_entrada_tlb(int pid, uint32_t pagina, uint32_t marco){

    int tamanio_actual_tlb = list_size(tlb);

    t_entrada* nueva_entrada = (t_entrada*) malloc(sizeof(t_entrada));
    nueva_entrada->pid = pid;
    nueva_entrada->pagina = pagina;
    nueva_entrada->marco = marco;
    nueva_entrada->ultimo_uso = obtener_tiempo(); //se va modificando cada vez que la referencio
    nueva_entrada->tiempo_carga = obtener_tiempo_carga(); //me da el tiempo y no se modifica una vez que se asigna

    if( (tamanio_actual_tlb < cantidad_entradas_tlb) ){
        //No importa el algoritmo siempre encolo
        pthread_mutex_lock(&mutex_tlb);
        list_add(tlb, nueva_entrada);
        pthread_mutex_unlock(&mutex_tlb);
        imprimir_tlb(tlb);

    }else{ 
        //porque puede estar deshabilitada la tlb
        if( (cantidad_entradas_tlb != 0) ){

            t_config* config_algoritmo = config_create(path_config);

            //REEMPLAZO DE ENTRADA 
            if(strcmp(config_get_string_value(config_algoritmo, "ALGORITMO_TLB"),"LRU") == 0){
                config_destroy(config_algoritmo);
                reemplazo_por_LRU(nueva_entrada);
            } else {
                config_destroy(config_algoritmo);
                reemplazo_por_FIFO(nueva_entrada);
            } 
            imprimir_tlb(tlb);
        }
    }
}

//las entradas con numero mas alta se referenciaron hace poco (u=1 se uso hace mas tiempo que u=8)
static bool menor_uso(t_entrada* siguiente_entrada, t_entrada* menor_entrada) {
    return siguiente_entrada->ultimo_uso < menor_entrada->ultimo_uso;
}

//las paginas con numero mas chico van primero (t=1 se cargo antes que t=8)
static bool mas_vieja(t_entrada* siguiente_entrada, t_entrada* mas_vieja){
    return (siguiente_entrada->tiempo_carga < mas_vieja->tiempo_carga); 
}

static int buscar_indice_entrada_menor_uso(t_list* lista) {

    //agarro la primera y voy comparando con el resto
    pthread_mutex_lock(&mutex_tlb);
    t_entrada* menor = list_get(lista, 0);
    pthread_mutex_unlock(&mutex_tlb);

    int indice_menor_uso = 0;

    for (int i = 1; i < list_size(lista); i++) {
        pthread_mutex_lock(&mutex_tlb);
        t_entrada* siguiente_entrada = list_get(lista, i);
        pthread_mutex_unlock(&mutex_tlb);
        if (menor_uso(siguiente_entrada, menor)) {
            menor = siguiente_entrada;
            indice_menor_uso = i;
        }
    }
    return indice_menor_uso;
}

static int buscar_indice_entrada_mas_vieja(t_list* lista) {

    //agarro la primera y voy comparando con el resto
    pthread_mutex_lock(&mutex_tlb);
    t_entrada* entrada_mas_vieja = list_get(lista, 0);
    pthread_mutex_unlock(&mutex_tlb);

    int indice_mas_vieja = 0;

    for (int i = 1; i < list_size(lista); i++) {
        pthread_mutex_lock(&mutex_tlb);
        t_entrada* siguiente_entrada = list_get(lista, i);
        pthread_mutex_unlock(&mutex_tlb);

        if (mas_vieja(siguiente_entrada, entrada_mas_vieja)) {
            entrada_mas_vieja = siguiente_entrada;
            indice_mas_vieja = i;
        }
    }
    printf("reemplazo FIFO indice %d\n", indice_mas_vieja);
    return indice_mas_vieja;
}

static void reemplazo_por_LRU(t_entrada* nueva_entrada){

    //saco la entrada menos usada
    int indice_menos_usada = buscar_indice_entrada_menor_uso(tlb);

    pthread_mutex_lock(&mutex_tlb);
    list_remove_and_destroy_element(tlb, indice_menos_usada, free);
    list_add_in_index(tlb, indice_menos_usada, nueva_entrada);
    pthread_mutex_unlock(&mutex_tlb);

    printf("reemplazo LRU indice %d\n", indice_menos_usada);
}

static void reemplazo_por_FIFO(t_entrada* nueva_entrada){
    
    int indice_mas_vieja = buscar_indice_entrada_mas_vieja(tlb);

    pthread_mutex_lock(&mutex_tlb);
    list_remove_and_destroy_element(tlb, indice_mas_vieja, free);
    list_add_in_index(tlb, indice_mas_vieja, nueva_entrada);
    pthread_mutex_unlock(&mutex_tlb);
}

void imprimir_tlb(t_list* tlb) { //SOLO PARA TESTING
    
    if (tlb == NULL) {
        printf("TLB vacía\n");
        return;
    }

    t_list_iterator *iterator = list_iterator_create(tlb);
    
    int index = 0;

    while (list_iterator_has_next(iterator)) {
        
        t_entrada *entrada = list_iterator_next(iterator);
        printf("Posicion TLB: %d - PID: %d - Pagina: %d - Marco: %d\n", index, entrada->pid, entrada->pagina, entrada->marco);
        index++;
    }
    printf("\n");
    list_iterator_destroy(iterator);
}