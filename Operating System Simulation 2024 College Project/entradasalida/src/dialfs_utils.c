#include "io.h"

void* bitmap;
t_bitarray* bitmap_bitarray;
FILE* archivo_de_bloques;
int tamanio_bitmap;

static void limpiar_posiciones(uint32_t posicion_inicial, int tamanio_proceso);
static bool pertenece_a_bloque_inicial(uint32_t indice_bloque);
static void limpiar_un_bloque(uint32_t indice_bloque);
static void marcar_bloque_ocupado(int index);
static bool esta_libre(int index);
static uint32_t buscar_bloque_libre(uint32_t bloque_inicial);
//================================ ARCHIVOS DE BLOQUES ======================================================
void crear_archivo_de_bloque()
{
	uint32_t fd;
    char* path_archivo_bloques = string_from_format ("%s/bloques.dat", path_dial_fs);

    fd = open(path_archivo_bloques, O_RDWR | O_CREAT, S_IRUSR | S_IWUSR);
    
    free(path_archivo_bloques);

    if (fd == -1) {
        log_error(dialfs_logger,"Error al abrir el Archivo de Bloques");
    }
  
    if (ftruncate(fd, tamanio_archivo_bloques) == -1) {
        log_error(dialfs_logger,"Error al truncar el Archivo de Bloques");
    }

    close (fd);
}

FILE* levantar_archivo_bloque() {
	
    char* path_archivo_bloques = string_from_format ("%s/bloques.dat", path_dial_fs);

    archivo_de_bloques = fopen(path_archivo_bloques, "r+b");

    if (path_archivo_bloques == NULL) {
        log_error(dialfs_logger, "No se pudo abrir el archivo.");
    }
    free(path_archivo_bloques);

	return archivo_de_bloques;
}

//================================ BITMAP ======================================================
void cargar_bitmap()
{
    char* path_bitmap = string_from_format ("%s/bitmap.dat", path_dial_fs);
    int bytes =  cantidad_bloques / 8;  // Dividis cantidad de bloques por 8 para obtener los bytes
    bool existe_bitmap = true;   // Para chequear si el bitmap existe de una ejecución previa del sistema

    int fd_bitmap = open(path_bitmap, O_CREAT | O_RDWR, S_IRWXU); // SI NO EXISTE EL ARCHIVO LO CREA
    free(path_bitmap);

    if (fd_bitmap == -1){
        log_info(dialfs_logger, "No se pudo abrir el archivo Bitmap");
    }

    ftruncate(fd_bitmap, bytes);  // SI EL ARCHIVO ES DE MENOS TAMAÑO QUE "bytes" ENTONCES LO EXTIENDE LLENANDOLO CON '\0'

    bitmap = mmap(NULL, bytes, PROT_READ | PROT_WRITE, MAP_SHARED, fd_bitmap, 0);

    if(bitmap == MAP_FAILED){
        log_error(dialfs_logger, "Error al usar mmap");
    }

    bitmap_bitarray = bitarray_create_with_mode((char*) bitmap, bytes , LSB_FIRST);
    
    // Si el bitmap no existe o no tiene bloques marco libres todos las posiciones del array
    if (existe_bitmap == false){
        limpiar_posiciones(0, bytes);  // Si es la primera ejecución del sistema, se carga el bitmap con ceros, todos bloques libres
    }
    
    int sincronizacion_completada = msync(bitmap, bytes, MS_SYNC);
    if (sincronizacion_completada == -1){
        log_error(dialfs_logger, "Error al sincronizar el bitmap de memoria");
        abort();
    }

    //Guardar el tamanio del bitmap
    tamanio_bitmap = (int) bitarray_get_max_bit(bitmap_bitarray);

    //Leer contenido del bitmap

    close(fd_bitmap);
}

static void limpiar_posiciones(uint32_t posicion_inicial, int tamanio_proceso) {
	
    for (int i = posicion_inicial; i < posicion_inicial + tamanio_proceso; i++) {
		bitarray_clean_bit(bitmap_bitarray, i);
        msync(bitmap, tamanio_bitmap, MS_SYNC);
	}
}

void leer_bitmap(int desde, int hasta)
{
    printf("LECTURA DE BITMAP DESDE: %d HASTA: %d\n\n", desde, hasta);
    for (int i = desde; i <= hasta; i++) {
        if (bitarray_test_bit(bitmap_bitarray, i)) {
            printf("Bit at index %d is 1\n", i);
        } else {
            printf("Bit at index %d is 0\n", i);
        }
    }
}

static void marcar_bloque_ocupado(int index) {
    bitarray_set_bit(bitmap_bitarray, index);
    msync(bitmap, tamanio_bitmap, MS_SYNC);
}

static bool esta_libre(int index) {
    return bitarray_test_bit(bitmap_bitarray, index) == false;
}

//================================ BLOQUES ======================================================
void agregar_bloques(uint32_t cantidad_bloques_a_agregar, uint32_t bloque_inicial)
{
    //char* bloque_ocupado = calloc(tamanio_bloque, sizeof(char));
    char* bloque_ocupado = malloc(tamanio_bloque); 
    memset(bloque_ocupado, '\0', tamanio_bloque);

    /*
    //creo un bloque con todos sus elementos en '\0'
    for(int i = 0; i < tamanio_bloque; i++){ 
    bloque_ocupado[i] = 'a';
    }*/

    //Levanto el archivo de bloques
    archivo_de_bloques = levantar_archivo_bloque();
    
    for(int i = 0; i < cantidad_bloques_a_agregar; i++) {

        uint32_t bloque_libre = buscar_bloque_libre(bloque_inicial);

        marcar_bloque_ocupado(bloque_libre);

        // Nos poscionamos en el archivo de bloques
        fseek(archivo_de_bloques, (tamanio_bloque * bloque_libre), SEEK_SET);

        //Escribimos el bloque en el archivo
        fwrite(bloque_ocupado, sizeof(char), tamanio_bloque, archivo_de_bloques);

        //fwrite(&bloque_ocupado[0], sizeof(char), 1, archivo_de_bloques);
    }

    free(bloque_ocupado);
    fclose(archivo_de_bloques);

}

void eliminar_bloques(uint32_t cantidad_bloques_a_eliminar, uint32_t bloque_inicial) {
    
    char* bloque_vacio = calloc(tamanio_bloque, sizeof(char));
    memset(bloque_vacio, '\0', tamanio_bloque);

    // Levanto el archivo de bloques
    archivo_de_bloques = levantar_archivo_bloque();

    // Limpio el archivo de bloques con bloques vacios
    for (int i = 0; i < cantidad_bloques_a_eliminar; i++) {
        fseek(archivo_de_bloques, tamanio_bloque * (bloque_inicial + i), SEEK_SET);
        fwrite(bloque_vacio, sizeof(char), tamanio_bloque, archivo_de_bloques);

        limpiar_posiciones(bloque_inicial, cantidad_bloques_a_eliminar);
    }

    fclose(archivo_de_bloques);
    free(bloque_vacio);
}

void compactar(uint32_t cantidad_bloques_a_compactar, uint32_t bloque_final_archivo)
{    
    t_list *lista_indices_bloques_libres = list_create();
    uint32_t aux_recorrer_bitmap = bloque_final_archivo;
    uint32_t indice_bloque_libre = 0;
    uint32_t cantidad_bloques_libres_encontrados = 0;
    uint32_t bloques_libres_contiguos = 0;

    // Recorro el bitmap desde el bloque final del archivo
    while(aux_recorrer_bitmap < tamanio_bitmap) { 
        
        // Si aun necesito bloques libres para compactar
        if(cantidad_bloques_libres_encontrados < cantidad_bloques_a_compactar) {
        
        // Busco el primer bloque libre en todo el bitmap
        //Luego de la primera iteracion, indice bloque libre > bloque final archivo
        if(aux_recorrer_bitmap == bloque_final_archivo)
            indice_bloque_libre = buscar_bloque_libre(bloque_final_archivo); 
        else
            indice_bloque_libre = buscar_bloque_libre(indice_bloque_libre + 1); 

        //Guardo los indices de los bloques libres
        //TODO revisar este if
        if(indice_bloque_libre < tamanio_bitmap) //Para evitar errores con indices cuando no encuentra uno libre
            list_add(lista_indices_bloques_libres, (void*)(intptr_t)indice_bloque_libre); 

        } else break; // Si ya no necesito bloques libres, salgo del while

        aux_recorrer_bitmap++;
        cantidad_bloques_libres_encontrados++;
    
        if(indice_bloque_libre > tamanio_bitmap) 
            break;
    }

    // Si no hay suficientes bloques libres, hay que compactar con el otro algoritmo
    /*if(cantidad_bloques_libres_encontrados < cantidad_bloques_a_compactar) {
        compactar_desde_comienzo = true;
        list_destroy(lista_indices_bloques_libres);
        return;
    }*/

    // Ahora reviso cuantos de los bloques libres son contiguos
    for (int i = bloque_final_archivo + 1; i < tamanio_bitmap; i++) {

        // Si el bloque no es libre, no es contiguo
        if (esta_libre(i)) {
            bloques_libres_contiguos++;
            list_remove_element(lista_indices_bloques_libres, (void*)(intptr_t)i);
        }else{
            break;
        }
    }

    // Obtengo la cantidad de bloques libres no contiguos
    uint32_t bloques_a_mover = list_size(lista_indices_bloques_libres);

    // Levanto el archivo de bloques
    archivo_de_bloques = levantar_archivo_bloque();

    //junto los bloques libres
    while (bloques_a_mover > 0)
    {
        // Creo un bloque de buffer 
        char* bloque_ocupado = malloc(tamanio_bloque); 

        // Obtengo el indice del primer bloque libre
        uint32_t bloque_libre = (uint32_t)(intptr_t)list_get(lista_indices_bloques_libres, 0);
     
        // Cantidad de bloques ocupados hasta llegar al bloque libre
        uint32_t bloques_ocupados = bloque_libre - bloque_final_archivo - bloques_libres_contiguos - 1;

        for(int i = 0; i < bloques_ocupados; i++) {
            
        // Me posiciono en el ultimo bloque ocupado por un archivo 
        fseek(archivo_de_bloques, tamanio_bloque * (bloque_libre - 1 - i), SEEK_SET);
        fread(bloque_ocupado, sizeof(char), tamanio_bloque, archivo_de_bloques);

        // Me posiciono en el bloque libre
        fseek(archivo_de_bloques, tamanio_bloque * (bloque_libre - i), SEEK_SET);
        fwrite(bloque_ocupado, sizeof(char), tamanio_bloque, archivo_de_bloques);

        // Actualizo el bloque inicial
        if(pertenece_a_bloque_inicial(bloque_libre - 1- i)) {
            modificar_metadata_bloque_inicial(bloque_libre - i, bloque_libre - 1 - i);    
        }
        } 
        free(bloque_ocupado);
        // Actualizo bitmap y archivo_de_bloques
        bloques_libres_contiguos++;
        limpiar_un_bloque(bloques_libres_contiguos + bloque_final_archivo);
        marcar_bloque_ocupado(bloque_libre);

        //Elimino el primer bloque libre de la lista
        list_remove_element(lista_indices_bloques_libres, (void*)(intptr_t)bloque_libre);
        bloques_a_mover--;
    }

    list_destroy(lista_indices_bloques_libres);
    fclose(archivo_de_bloques);
}

int compactar_desde_el_comienzo(uint32_t bloque_final_archivo)
{
    int cant_bloques_a_mover = 0;
    
    archivo_de_bloques = levantar_archivo_bloque();

    for(int i = 0; i <= bloque_final_archivo; i++){
        if(esta_libre(i)){
            cant_bloques_a_mover++;       
        }else{ //Mover el bloque x posiciones para atras
             
             //Para evitar que en bloque 0 multiplique por -1
             if(cant_bloques_a_mover > 0){

                // Creo un bloque de buffer 
                char* bloque_ocupado = malloc(tamanio_bloque); 

                // Me posiciono en bloque que quiero mover 
                fseek(archivo_de_bloques, tamanio_bloque * (i - 1), SEEK_SET);
                fread(bloque_ocupado, sizeof(char), tamanio_bloque, archivo_de_bloques);

                // Me posiciono en el primer bloque libre = la pos de este bloque menos la cant de bloques a moverlo
                fseek(archivo_de_bloques, tamanio_bloque * (i - cant_bloques_a_mover), SEEK_SET);
                fwrite(bloque_ocupado, sizeof(char), tamanio_bloque, archivo_de_bloques);

                // Actualizo el bloque inicial
                if(pertenece_a_bloque_inicial(i)) {
                    modificar_metadata_bloque_inicial(i - cant_bloques_a_mover, i);    
                }

                limpiar_un_bloque(i);
                marcar_bloque_ocupado(i - cant_bloques_a_mover);

                free(bloque_ocupado);
            }
        }
    }
    fclose(archivo_de_bloques);
    return bloque_final_archivo - cant_bloques_a_mover;
}

static void limpiar_un_bloque(uint32_t indice_bloque)
{
    char* bloque_vacio = calloc(tamanio_bloque, sizeof(char));
    memset(bloque_vacio, '\0', tamanio_bloque);

    fseek(archivo_de_bloques, (tamanio_bloque * indice_bloque), SEEK_SET);
    fwrite(bloque_vacio, sizeof(char), tamanio_bloque, archivo_de_bloques);

    free(bloque_vacio);
    bitarray_clean_bit(bitmap_bitarray, indice_bloque);
}

static bool pertenece_a_bloque_inicial(uint32_t indice_bloque)
{
    int i = 1;
    t_config *archivo_general = config_create(path_archivo_general);
    while(i <= (config_keys_amount(archivo_general) / 2)){
        char* bloque_inicial_string = string_from_format("%s:%d", "BLOQUE_INICIAL",i);
        if(config_has_property(archivo_general, bloque_inicial_string)){
            if(config_get_int_value(archivo_general,bloque_inicial_string) == indice_bloque){
                free(bloque_inicial_string);
                config_destroy(archivo_general);
                return true;
            }  
        }
        i++;
        free(bloque_inicial_string);
    }

    config_destroy(archivo_general);
    return false;
}    

char* obtener_nombre_de_archivo(uint32_t bloque_inicial, uint32_t nuevo_bloque_inicial)
{
    int i = 1;
    t_config *archivo_general = config_create(path_archivo_general);

    while(true){
        char* bloque_inicial_string = string_from_format("%s:%d", "BLOQUE_INICIAL",i);
        if(config_has_property(archivo_general, bloque_inicial_string)){
            if(config_get_int_value(archivo_general,bloque_inicial_string) == bloque_inicial){
                char* nombre_archivo_string = string_from_format("%s:%d", "NOMBRE_ARCHIVO",i);
                char* nombre_archivo = string_duplicate(config_get_string_value(archivo_general, nombre_archivo_string));
                free(nombre_archivo_string);
                char* puntero_auxiliar = string_from_format("%d", nuevo_bloque_inicial);
                config_set_value(archivo_general, bloque_inicial_string, puntero_auxiliar);
                free(puntero_auxiliar);
                free(bloque_inicial_string);
                config_save_in_file(archivo_general, path_archivo_general);
                config_destroy(archivo_general);
                return nombre_archivo;
            }  
        }
        free(bloque_inicial_string);
        i++;
    }
}

void eliminar_archivo_metadata_general(char *nombre_archivo){
    int i = 1;
    t_config *archivo_general = config_create(path_archivo_general);

    while(true){
        char* nombre_archivo_string = string_from_format("%s:%d", "NOMBRE_ARCHIVO",i);
        char* nombre_archivo2;
        if(config_has_property(archivo_general, nombre_archivo_string)){
            nombre_archivo2 = string_duplicate(config_get_string_value(archivo_general,nombre_archivo_string)); 
            if(!strcmp(nombre_archivo2,nombre_archivo)){
                free(nombre_archivo2);
                config_set_value(archivo_general, nombre_archivo_string, "");
                char* bloque_inicial_string = string_from_format("%s:%d", "BLOQUE_INICIAL",i);
                config_set_value(archivo_general, bloque_inicial_string, "");
                free(bloque_inicial_string);
                free(nombre_archivo_string);
                config_save_in_file(archivo_general, path_archivo_general);
                config_destroy(archivo_general);
                return;
            }  
        }
        free(nombre_archivo2);
        free(nombre_archivo_string);
        i++;
    }
}

// Busco el primer bloque libre para el bloque inicial 
uint32_t buscar_bloque_inicial_libre()
{
    for (int i = 0; i < tamanio_bitmap; i++){
        if (esta_libre(i)){
            return i;
        }
    }
    return -1;
}

// Busco desde X bloque
static uint32_t buscar_bloque_libre(uint32_t bloque_inicial) 
{
    for (int i = bloque_inicial; i < tamanio_bitmap; i++){
        if (esta_libre(i)){
            return i;
        }
    }
    
    return tamanio_bitmap + 1; //Para saber que no se encontro nada y evitar errores de conversion de negativos a uint32_t
}

bool bloques_contiguos(uint32_t cantidad_bloques_a_buscar, uint32_t bloque_final_archivo) 
{
    uint32_t bloques_encontrados = 0;

    //Busco en el bitmap si hay suficientes bloques libres contiguos
    for (int i = bloque_final_archivo + 1; i < tamanio_bitmap; i++) {
        if (esta_libre(i)) {

            //cantidad de bloques disponibles contiguos que encuentro
            bloques_encontrados++;

            // Hay suficientes bloques contiguos 
            if (bloques_encontrados == cantidad_bloques_a_buscar) {
                return true;
            }
        } else{
            return false; //Quiere decir que no encontre la cantidad de bloques libres contiguos que necesitaba
        }
    }

    return false;
}