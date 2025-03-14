#include "memoria.h"

void* espacio_usuario;
t_list* marcos;
pthread_mutex_t mutex_PROCESOS_EN_MEMORIA;
pthread_mutex_t mutex_paginas_proceso;
pthread_mutex_t mutex_MARCOS;

static bool esta_libre(t_marco* marco);

//============================================ ESPACIO DE USUARIO ===========================================================
void creacion_espacio_usuario(){
	espacio_usuario = malloc(config_valores_memoria.tam_memoria);

	if (espacio_usuario == NULL) {
        perror ("No se pudo alocar memoria al espacio de usuario.");
        abort();
    } 

	//Se inicializa con 0
	memset(espacio_usuario,0,config_valores_memoria.tam_memoria); 

	marcos = list_create();

	crear_marcos_memoria();
}

void acceso_a_espacio_usuario(int pid, char* accion, uint32_t dir_fisica, uint32_t tamanio)
{
	sleep(config_valores_memoria.retardo_respuesta / 1000);
	
	log_info(memoria_logger, "ACCESO A ESPACIO USUARIO - PID %d - ACCION: %s - DIRECCION FISICA: %d - TAMAÑO: %d", pid, accion, dir_fisica, tamanio); 
}

//============================================ CREACION DE PROCESOS && MARCOS DE MEMORIA ====================================================

void crear_estructuras_memoria(int pid, FILE* archivo){

	t_proceso_en_memoria* proceso = malloc(sizeof(t_proceso_en_memoria));
	proceso->pid = pid;
	proceso->instrucciones = list_create();
    proceso->paginas_en_memoria = list_create();

	leer_instrucciones_desde_archivo(proceso, archivo);

	pthread_mutex_lock(&mutex_PROCESOS_EN_MEMORIA);
	list_add(procesos_en_memoria, proceso);
	pthread_mutex_unlock(&mutex_PROCESOS_EN_MEMORIA);

}

void crear_marcos_memoria() {

	for(int i = 0; i < cantidad_marcos; i++) {
		t_marco* marco = malloc(sizeof(t_marco)); 

		marco->nro_pagina = -1;
		marco->nro_marco = i;
		marco->pid_proceso = -1;
		marco->libre = true;
        
		pthread_mutex_lock(&mutex_MARCOS);
		list_add(marcos, marco);
		pthread_mutex_unlock(&mutex_MARCOS);
	}
}

//TODO Revisae
void finalizar_en_memoria(int pid)
{
	//Obtengo el proceso por el pid
	t_proceso_en_memoria *proceso = obtener_proceso_en_memoria(pid);

	if(proceso != NULL){
		//Libero las paginas
		if(proceso->paginas_en_memoria != NULL) {
		int cantidad_paginas_de_proceso = list_size(proceso->paginas_en_memoria);
		quitar_marcos_a_proceso(proceso, cantidad_paginas_de_proceso);
		}

		//Elimino el proceso de la lista
		pthread_mutex_lock(&mutex_PROCESOS_EN_MEMORIA);
		list_remove_element(procesos_en_memoria, proceso);
		pthread_mutex_unlock(&mutex_PROCESOS_EN_MEMORIA);

		//Limpio su lista de instrucciones
		list_destroy_and_destroy_elements(proceso->instrucciones, free);
		list_destroy_and_destroy_elements(proceso->paginas_en_memoria,free);

		//Libero su memoria
		free(proceso);
	}
}

//============================================ FUNCIONES DE ASIGNACION DE MARCOS/PAGINAS =============================================

int cantidad_de_marcos_necesarios(int tamanio_contenido_bytes){

	double division = ceil((double)tamanio_contenido_bytes/(double)tam_pagina);
	int cantidad_marcos = (int) division;

	return cantidad_marcos; 
}

static bool esta_libre(t_marco* marco) {
	return marco->libre;
}

int cantidad_de_marcos_libres_en_memoria(){

	//filtro solo los marcos libres
	t_list* marcos_libres = list_filter(marcos, (void*)esta_libre);
	int cantidad_marcos_libres = list_size(marcos_libres);
	list_destroy(marcos_libres);

	return cantidad_marcos_libres; 
}

void quitar_marcos_a_proceso(t_proceso_en_memoria* proceso, uint32_t cantidad_marcos_a_liberar){

	log_info(memoria_logger, "Liberando paginas - PID: %d - Tamaño: %d", proceso->pid, cantidad_marcos_a_liberar); 
	
	//TODO preguntar si borramos las paginas cuando se hace resize menor o en que cambia si las dejamos con un bit no cargadas

	for(int i = 0; i < cantidad_marcos_a_liberar; i++){
		int tamanio_tabla_paginas = list_size(proceso->paginas_en_memoria) - 1;
		//Saca desde el final las paginas
		t_pagina* pagina_removida = list_remove(proceso->paginas_en_memoria, tamanio_tabla_paginas); 
		liberar_marco(pagina_removida->nro_marco);
		free(pagina_removida);
	}
}

void liberar_marco(int marco){
	
	t_marco *marco_a_liberar = buscar_marco_por_numero(marco);  

	t_marco* marco_liberado = malloc(sizeof(t_marco));
	marco_liberado->nro_marco = marco; 
	marco_liberado->pid_proceso = -1;
	marco_liberado->nro_pagina = -1;
	marco_liberado->libre = true;

	pthread_mutex_lock(&mutex_MARCOS);
	list_remove_and_destroy_element(marcos, marco_a_liberar->nro_marco, free);
	list_add_in_index(marcos, marco, marco_liberado);
	pthread_mutex_unlock(&mutex_MARCOS);
}

t_marco* buscar_marco_por_numero(int numero_de_marco) {
    
	pthread_mutex_lock(&mutex_MARCOS);
    for (int i = 0; i < list_size(marcos); i++) {
        t_marco* marco_actual = (t_marco*) list_get(marcos, i);
        pthread_mutex_unlock(&mutex_MARCOS);
		if (marco_actual->nro_marco == numero_de_marco) {
            
            return marco_actual;
        }
    }
    return NULL;
}

void asignar_marcos_a_proceso(t_proceso_en_memoria* proceso, int cantidad_de_marcos_necesarios) {
	
	//PRIMERO DEBERIA BUSCAR MARCOS LIBRES
	//SEGUNDO AL MARCO LIBRE ASIGNARLE EL PID DEL PROCESO Y MARCARLO COMO OCUPADO 
	//AL PROCESO AGREGARLE UNA PAGINA Y A ESA PAGINA ASIGNARLE EL MARCO Y EL PID
	//SEGUIR RECORRIENDO LA LISTA DE MARCOS LIBRES MIENTRAS CONTADOR SEA MENOR A CANT_MARCOS_NECESARIOS
	
	t_marco* marco_obtenido = NULL;
	int contador = 0;

	pthread_mutex_lock(&mutex_MARCOS);
	int cantidad_marcos = list_size(marcos);
	pthread_mutex_unlock(&mutex_MARCOS);

	log_info(memoria_logger, "Agregando paginas - PID: %d - Tamaño: %d marcos", proceso->pid, cantidad_de_marcos_necesarios); 

	for(int i = 0; i< cantidad_marcos; i++){
		if(contador < cantidad_de_marcos_necesarios){
			pthread_mutex_lock(&mutex_MARCOS);
			marco_obtenido = (t_marco*) list_get(marcos,i);
			pthread_mutex_unlock(&mutex_MARCOS);

			if(marco_obtenido->libre) {
				asignar_proceso_a_marco(proceso, marco_obtenido); //TAMBIEN AGREGA PAGINA A PROCESO
				contador++;
			}			
		} else {
			break;
		}
	}
}

void asignar_proceso_a_marco(t_proceso_en_memoria* proceso, t_marco* marco){
	
	t_marco* marco_modificado = malloc(sizeof(t_marco)); 
	marco_modificado->nro_pagina = list_size(proceso->paginas_en_memoria)-1;
	marco_modificado->nro_marco = marco->nro_marco;
	marco_modificado->pid_proceso = proceso->pid;
	marco_modificado->libre = false;

	pthread_mutex_unlock(&mutex_MARCOS);
	list_remove_and_destroy_element(marcos, marco->nro_marco,free);
	list_add_in_index(marcos, marco_modificado->nro_marco, marco_modificado);
	pthread_mutex_unlock(&mutex_MARCOS);

	agregar_pagina_a_proceso(proceso, marco_modificado);
}

//Busca en los procesos cuyas instrucciones ya fueron cargadas
t_proceso_en_memoria* obtener_proceso_en_memoria(int pid) { 
    
	pthread_mutex_lock(&mutex_PROCESOS_EN_MEMORIA);
	int cantidad_procesos = list_size(procesos_en_memoria);
	pthread_mutex_unlock(&mutex_PROCESOS_EN_MEMORIA);

	for (int i = 0; i < cantidad_procesos; i++) {
		pthread_mutex_lock(&mutex_PROCESOS_EN_MEMORIA);
        t_proceso_en_memoria* proceso = (t_proceso_en_memoria*) list_get(procesos_en_memoria, i);
		pthread_mutex_unlock(&mutex_PROCESOS_EN_MEMORIA);
        if (proceso->pid == pid) {
            return proceso; 
        }
    }
	return NULL;
}

void agregar_pagina_a_proceso(t_proceso_en_memoria* proceso, t_marco* marco){
	
	t_pagina *pagina_nueva = malloc(sizeof(t_pagina));

	pagina_nueva->pid_proceso = proceso->pid;
	pagina_nueva->nro_marco = marco->nro_marco;
	pagina_nueva->nro_pagina = list_size(proceso->paginas_en_memoria);

	list_add(proceso->paginas_en_memoria, pagina_nueva);
}

uint32_t buscar_marco(uint32_t numero_pagina, int pid){
    
	//Obtengo el proceso por el pid
    t_proceso_en_memoria *proceso = obtener_proceso_en_memoria(pid);

    // Busco la página correspondiente al número de página
    t_pagina *pagina = NULL;

	pthread_mutex_lock(&mutex_paginas_proceso);
	int cant_paginas_en_memoria = list_size(proceso->paginas_en_memoria);
	pthread_mutex_unlock(&mutex_paginas_proceso);

    for (int i = 0; i < cant_paginas_en_memoria; i++) {
		pthread_mutex_lock(&mutex_paginas_proceso);
        t_pagina *pagina_actual = (t_pagina*) list_get(proceso->paginas_en_memoria, i);
		pthread_mutex_unlock(&mutex_paginas_proceso);
       
	    if (pagina_actual->nro_pagina == numero_pagina) {
            pagina = pagina_actual;
			break;
        }
    }

    if (pagina == NULL) {
        log_error(memoria_logger, "No se encontró la página %d en el proceso con PID: %d\n", numero_pagina, pid);
		log_info(memoria_logger, "PID: %d - Paginas en Memoria: %d\n", pid, cant_paginas_en_memoria);
		abort();
    }

    // Obtengo el número de marco asignado a la página
    int marco = pagina->nro_marco;
    if (marco == -1) {
        log_info(memoria_logger, "No hay marco asignado para la página %d en el proceso con PID: %d\n", numero_pagina, pid);
    } else {
        log_info(memoria_logger, "Acceso a tabla de páginas: PID: %d - Página: %d - Marco: %d\n", pid, numero_pagina, marco);
    }

    return marco;
}

int numero_marco(uint32_t direccion_fisica){
	int num_marco = floor((double)direccion_fisica / (double)tam_pagina);
	return num_marco;
}



/* // MUESTREA PARA TESTEAR MEMORIA -> NO USAR EN EL TP 
static void mostrar_procesos_en_memoria() {
    printf("=== Procesos en memoria ===\n");
    for (int i = 0; i < list_size(procesos_en_memoria); i++) {
        t_proceso_en_memoria* proceso = (t_proceso_en_memoria*)list_get(procesos_en_memoria, i);
        mostrar_proceso_en_memoria(proceso);
    }
    printf("\n");
}

static void mostrar_marcos() {
    printf("=== Marcos ===\n");
    for (int i = 0; i < list_size(marcos); i++) {
        t_marco* marco = (t_marco*)list_get(marcos, i);
        mostrar_marco(marco);
    }
    printf("\n");
}
*
static void mostrar_contenido() {
    uint8_t *ptr = (uint8_t*)espacio_usuario;

    for (size_t i = 0; i < config_valores_memoria.tam_memoria; i++) {
        if (ptr[i] >= 32 && ptr[i] <= 126) {
            printf("%c", ptr[i]); // Carácter imprimible
        } else {
            printf("%u", ptr[i]); // Valor numérico
        }
    }
    printf("\n");
}
*/

