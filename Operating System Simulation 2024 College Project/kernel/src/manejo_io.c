#include "kernel.h"

pthread_mutex_t mutex_INTERFAZ_GENERICA;
pthread_mutex_t mutex_INTERFAZ_STDIN;
pthread_mutex_t mutex_INTERFAZ_STDOUT;
pthread_mutex_t mutex_INTERFAZ_DIALFS;

static void esperar_io(t_interfaz* interfaz);
static void eliminar_interfaz(t_interfaz* interfaz);
static void liberar_memoria(t_interfaz* interfaz);

void servidor_kernel_io(){
    
    servidor_kernel = iniciar_servidor(config_valores_kernel.ip_escucha, config_valores_kernel.puerto_escucha);
  
  while(1){
          //Es necesario pasarle un puntero (int *) al hilo no un int
          int* socket_cliente_io = malloc(sizeof(int));
          *socket_cliente_io = esperar_cliente(servidor_kernel);
          
          if(*socket_cliente_io != -1)
          {
               pthread_t hilo_io;
               pthread_create(&hilo_io, NULL, (void* ) atender_io, socket_cliente_io);
               pthread_detach(hilo_io);
          }
     }
}


void atender_io(int* socket_io) 
{
        int socket_cliente_io = *(int*)socket_io;
        free(socket_io);
        t_paquete* paquete = recibir_paquete(socket_cliente_io);
        void* stream = paquete->buffer->stream;

        t_interfaz* interfaz_nueva = malloc(sizeof(t_interfaz));
        interfaz_nueva->nombre = sacar_cadena_de_paquete(&stream);
        interfaz_nueva->tipo_interfaz = sacar_cadena_de_paquete(&stream);
        interfaz_nueva->socket_conectado = socket_cliente_io;
        sem_init(&interfaz_nueva->sem_comunicacion_interfaz, 0, 1);
        pthread_mutex_init(&interfaz_nueva->cola_bloqueado_mutex, NULL);
        interfaz_nueva->cola_bloqueados = list_create();

        pthread_t hilo_recepcion_io;
        pthread_create(&hilo_recepcion_io, NULL, (void* ) esperar_io, interfaz_nueva);
        pthread_detach(hilo_recepcion_io);

        switch(paquete->codigo_operacion) {
            case INTERFAZ_GENERICA:
                pthread_mutex_lock(&mutex_INTERFAZ_GENERICA);
                list_add(interfaces_genericas, interfaz_nueva);
                pthread_mutex_unlock(&mutex_INTERFAZ_GENERICA);
                log_info(kernel_logger, "Se agrego interfaz GENERICA: %s \n", interfaz_nueva->nombre);
                break;
            case INTERFAZ_STDIN:
                pthread_mutex_lock(&mutex_INTERFAZ_STDIN);
                list_add(interfaces_stdin, interfaz_nueva);
                pthread_mutex_unlock(&mutex_INTERFAZ_STDIN);
                log_info(kernel_logger, "Se agrego interfaz STDIN: %s \n", interfaz_nueva->nombre);
                break;
            case INTERFAZ_STDOUT:
                pthread_mutex_lock(&mutex_INTERFAZ_STDOUT);
                list_add(interfaces_stdout, interfaz_nueva);
                pthread_mutex_unlock(&mutex_INTERFAZ_STDOUT);
                log_info(kernel_logger, "Se agrego interfaz STDOUT: %s \n", interfaz_nueva->nombre);
                break;
            case INTERFAZ_DIALFS:
                pthread_mutex_lock(&mutex_INTERFAZ_DIALFS);
                list_add(interfaces_dialfs, interfaz_nueva);
                pthread_mutex_unlock(&mutex_INTERFAZ_DIALFS);
                log_info(kernel_logger, "Se agrego interfaz DIALFS: %s \n", interfaz_nueva->nombre);
                break;
            default:
                break;
        }
    eliminar_paquete(paquete);
}

bool peticiones_de_io(t_pcb *proceso, t_interfaz* interfaz) 
{
    //Si existe la interfaz y esta conectada
    if (interfaz == NULL) {
        log_error(kernel_logger, "Interfaz inexistente");
        mandar_a_EXIT(proceso, "INVALID INTERFACE");
        return false;
    }

    //Si admite el comando de instruccion
    if(!admite_operacion_interfaz(interfaz, contexto_ejecucion->motivo_desalojo->comando))
    {
        log_error(kernel_logger, "Interfaz incorrecta");
        mandar_a_EXIT(proceso, "INVALID INTERFACE");
        return false;
    }

    return true;
}

t_interfaz* obtener_interfaz_por_nombre(char* nombre_interfaz) {

    pthread_mutex_lock(&mutex_INTERFAZ_GENERICA);
    int tamanio_lista_generica = list_size(interfaces_genericas);
    pthread_mutex_unlock(&mutex_INTERFAZ_GENERICA);

    // INTERFACES GENERICAS
    for (int i = 0; i < tamanio_lista_generica; i++) {
    pthread_mutex_lock(&mutex_INTERFAZ_GENERICA);
    t_interfaz* interfaz_nueva = list_get(interfaces_genericas, i);
    pthread_mutex_unlock(&mutex_INTERFAZ_GENERICA);
    
    if (strcmp(nombre_interfaz, interfaz_nueva->nombre) == 0) {
        return interfaz_nueva;
            }   
        }
    
    // INTERFACES STDIN
    pthread_mutex_lock(&mutex_INTERFAZ_STDIN);
    int tamanio_lista_stdin = list_size(interfaces_stdin);
    pthread_mutex_unlock(&mutex_INTERFAZ_STDIN);

    for (int i = 0; i < tamanio_lista_stdin; i++) {
    pthread_mutex_lock(&mutex_INTERFAZ_STDIN);
    t_interfaz* interfaz_nueva = list_get(interfaces_stdin, i);
    pthread_mutex_unlock(&mutex_INTERFAZ_STDIN);

    if (strcmp(nombre_interfaz, interfaz_nueva->nombre) == 0) {
        return interfaz_nueva;
            }
        }

    // INTERFACES STDOUT
    pthread_mutex_lock(&mutex_INTERFAZ_STDOUT);
    int tamanio_lista_stdout = list_size(interfaces_stdout);
    pthread_mutex_unlock(&mutex_INTERFAZ_STDOUT);

    for (int i = 0; i < tamanio_lista_stdout; i++) {
    pthread_mutex_lock(&mutex_INTERFAZ_STDOUT);
    t_interfaz* interfaz_nueva = list_get(interfaces_stdout, i);
    pthread_mutex_unlock(&mutex_INTERFAZ_STDOUT);

    if (strcmp(nombre_interfaz, interfaz_nueva->nombre) == 0) {
        return interfaz_nueva;
            }
        }

    // INTERFACES DIALFS
    pthread_mutex_lock(&mutex_INTERFAZ_DIALFS);
    int tamanio_lista_dialfs = list_size(interfaces_dialfs);
    pthread_mutex_unlock(&mutex_INTERFAZ_DIALFS);

    for (int i = 0; i < tamanio_lista_dialfs; i++) {
    pthread_mutex_lock(&mutex_INTERFAZ_DIALFS);
    t_interfaz* interfaz_nueva = list_get(interfaces_dialfs, i);
    pthread_mutex_unlock(&mutex_INTERFAZ_DIALFS);

    if (strcmp(nombre_interfaz, interfaz_nueva->nombre) == 0) {
        return interfaz_nueva;
            }
        }
    
    return NULL;
}

bool admite_operacion_interfaz(t_interfaz* interfaz, codigo_instrucciones operacion) {

    if (strcmp(interfaz->tipo_interfaz, "GENERICA") == 0) {
        return (operacion == IO_GEN_SLEEP);
    } 
    if (strcmp(interfaz->tipo_interfaz, "STDIN") == 0) {
        return (operacion == IO_STDIN_READ);
    } 
    if (strcmp(interfaz->tipo_interfaz, "STDOUT") == 0) {
        return (operacion == IO_STDOUT_WRITE);
    } 
    if (strcmp(interfaz->tipo_interfaz, "DIALFS") == 0) {
        return (operacion == IO_FS_CREATE) || (operacion == IO_FS_DELETE) || (operacion == IO_FS_TRUNCATE) || (operacion == IO_FS_WRITE) || (operacion == IO_FS_READ);
    }
    return false;
}

void enviar_peticion_io(t_pcb* proceso, t_interfaz* interfaz, t_paquete* peticion) {
    char motivo[35] = "";

    strcat(motivo, "INTERFAZ ");
    strcat(motivo, interfaz->tipo_interfaz);
    strcat(motivo, ": ");
    strcat(motivo, interfaz->nombre);

    //Permite que el reloj calcule el tiempo restante del quantum antes que
    //el kernel llame a otro proceso
    if(!strcmp(config_valores_kernel.algoritmo, "VRR")){
        sem_wait(&ciclo_actual_quantum_sem);
        proceso->quantum = ciclo_actual_quantum;
    }
    
    ingresar_a_BLOCKED_IO(interfaz->cola_bloqueados ,proceso, motivo, interfaz->cola_bloqueado_mutex, interfaz->tipo_interfaz);
    logear_cola_io_bloqueados(interfaz); //NO es obligatorio

    enviar_paquete(peticion, interfaz->socket_conectado);
}

static void esperar_io(t_interfaz* interfaz)
{
    while(true){
        int pid;

        recv(interfaz->socket_conectado, &pid, sizeof(int), MSG_WAITALL);

        if(pid == -1){ //Se desconecto la IO
            eliminar_interfaz(interfaz);
            int desconectado = 1;
            send(interfaz->socket_conectado, &desconectado, sizeof(int), 0);
            close(interfaz->socket_conectado);
            free(interfaz);
            break; //para salir del while => Esta IO no va a mandar mas mensajes
        }else{
            t_pcb* proceso_IO = buscar_pcb_en_lista(interfaz->cola_bloqueados, pid, interfaz->cola_bloqueado_mutex);

            if(proceso_IO->eliminado == 1){
                mandar_a_EXIT(proceso_IO, "Pedido de finalizacion");
            }else{
                ingresar_de_BLOCKED_a_READY_IO(interfaz->cola_bloqueados, interfaz->cola_bloqueado_mutex);
            }
        }
    }
}

static void eliminar_interfaz(t_interfaz* interfaz){
    t_interfaz* interfaz_lista;
    if (!strcmp(interfaz->tipo_interfaz, "GENERICA")){
            
            for(int i = 0 ; i < list_size(interfaces_genericas); i++)
            {
                interfaz_lista = list_get(interfaces_genericas,i);
                if(!strcmp(interfaz_lista->nombre, interfaz->nombre)){
                    list_remove(interfaces_genericas, i);
                    liberar_memoria(interfaz_lista);
                    return;
                }
            }
    }    

    if (!strcmp(interfaz->tipo_interfaz, "STDIN")){
            
            for(int i = 0 ; i < list_size(interfaces_stdin); i++)
            {
                interfaz_lista = list_get(interfaces_stdin,i);
                if(!strcmp(interfaz_lista->nombre, interfaz->nombre)){
                    list_remove(interfaces_stdin, i);
                    liberar_memoria(interfaz_lista);
                    return;
                }
            }
    }        

    if (!strcmp(interfaz->tipo_interfaz, "STDOUT")){
            
            for(int i = 0 ; i < list_size(interfaces_stdout); i++)
            {
                interfaz_lista = list_get(interfaces_stdout,i);
                if(!strcmp(interfaz_lista->nombre, interfaz->nombre)){
                    list_remove(interfaces_stdout, i);
                    liberar_memoria(interfaz_lista);
                    return;
                }
            }
    }        
    
    if (!strcmp(interfaz->tipo_interfaz, "DIALFS")){
            
            for(int i = 0 ; i < list_size(interfaces_dialfs); i++)
            {
                interfaz_lista = list_get(interfaces_dialfs,i);
                if(!strcmp(interfaz_lista->nombre, interfaz->nombre)){
                    list_remove(interfaces_dialfs, i);
                    liberar_memoria(interfaz_lista);
                    return;
                }
           }      
    }
}

static void liberar_memoria(t_interfaz* interfaz){

        //Mandar los procesos bloqueados a EXIT
        t_pcb* proceso_bloqueado;
        for(int i = 0; i < list_size(interfaz->cola_bloqueados); i++){
            proceso_bloqueado = list_get(interfaz->cola_bloqueados,i);
            mandar_a_EXIT(proceso_bloqueado, "IO Desconectada");
        }

        free(interfaz->nombre);
        free(interfaz->tipo_interfaz);
        sem_destroy(&interfaz->sem_comunicacion_interfaz);
        pthread_mutex_destroy(&interfaz->cola_bloqueado_mutex);
        list_destroy(interfaz->cola_bloqueados);
}