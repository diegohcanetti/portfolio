USE [GD1C2023]

GO

PRINT '**** Comenzando carga BI  ****';
GO

DECLARE @DropConstraints nvarchar(max) = ''

SELECT @DropConstraints += 'ALTER TABLE ' + QUOTENAME(OBJECT_SCHEMA_NAME(parent_object_id)) + '.'

                        +  QUOTENAME(OBJECT_NAME(parent_object_id)) + ' ' + 'DROP CONSTRAINT' + QUOTENAME(name)

FROM sys.foreign_keys

EXECUTE sp_executesql @DropConstraints;

PRINT '**** CONSTRAINTs BI dropeadas correctamente ****';

GO
/*
DECLARE @DropTables nvarchar(max) = ''

SELECT @DropTables += 'DROP TABLE NO_SE_BAJA_NADIE. ' + QUOTENAME(TABLE_NAME)

FROM INFORMATION_SCHEMA.TABLES

WHERE TABLE_SCHEMA = 'NO_SE_BAJA_NADIE' AND TABLE_TYPE = 'BASE TABLE'

EXECUTE sp_executesql @DropTables;

PRINT '**** TABLAS dropeadas correctamente ****';

GO
*/
/********* Drop de Tablas *********/
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'Hechos_pedidos')
	DROP TABLE NO_SE_BAJA_NADIE.Hechos_pedidos

IF EXISTS (SELECT name FROM sys.tables WHERE name = 'Hechos_envio_mensajeria')
	DROP TABLE NO_SE_BAJA_NADIE.Hechos_envio_mensajeria

IF EXISTS (SELECT name FROM sys.tables WHERE name = 'Hechos_reclamo')
	DROP TABLE NO_SE_BAJA_NADIE.Hechos_reclamo

IF EXISTS (SELECT name FROM sys.tables WHERE name = 'Dimension_categoria_local')
	DROP TABLE NO_SE_BAJA_NADIE.Dimension_categoria_local

IF EXISTS (SELECT name FROM sys.tables WHERE name = 'Dimension_tiempo')
	DROP TABLE NO_SE_BAJA_NADIE.Dimension_tiempo

IF EXISTS (SELECT name FROM sys.tables WHERE name = 'Dimension_dia')
	DROP TABLE NO_SE_BAJA_NADIE.Dimension_dia

IF EXISTS (SELECT name FROM sys.tables WHERE name = 'Dimension_rango_horario')
	DROP TABLE NO_SE_BAJA_NADIE.Dimension_rango_horario

IF EXISTS (SELECT name FROM sys.tables WHERE name = 'Dimension_rango_horario_final')
	DROP TABLE NO_SE_BAJA_NADIE.Dimension_rango_horario_final

IF EXISTS (SELECT name FROM sys.tables WHERE name = 'Dimension_localidad')
	DROP TABLE NO_SE_BAJA_NADIE.Dimension_localidad

IF EXISTS (SELECT name FROM sys.tables WHERE name = 'Dimension_rango_etario_usuario')
    DROP TABLE NO_SE_BAJA_NADIE.Dimension_rango_etario_usuario

IF EXISTS (SELECT name FROM sys.tables WHERE name = 'Dimension_rango_etario_repartidor')
    DROP TABLE NO_SE_BAJA_NADIE.Dimension_rango_etario_repartidor

IF EXISTS (SELECT name FROM sys.tables WHERE name = 'Dimension_rango_etario_operador')
    DROP TABLE NO_SE_BAJA_NADIE.Dimension_rango_etario_operador

IF EXISTS (SELECT name FROM sys.tables WHERE name = 'Dimension_medio_de_pago_tipo')
	DROP TABLE NO_SE_BAJA_NADIE.Dimension_medio_de_pago_tipo

IF EXISTS (SELECT name FROM sys.tables WHERE name = 'Dimension_local')
	DROP TABLE NO_SE_BAJA_NADIE.Dimension_local

IF EXISTS (SELECT name FROM sys.tables WHERE name = 'Dimension_tipo_local')
	DROP TABLE NO_SE_BAJA_NADIE.Dimension_tipo_local

IF EXISTS (SELECT name FROM sys.tables WHERE name = 'Dimension_tipo_movilidad')
	DROP TABLE NO_SE_BAJA_NADIE.Dimension_tipo_movilidad

IF EXISTS (SELECT name FROM sys.tables WHERE name = 'Dimension_tipo_paquete')
	DROP TABLE NO_SE_BAJA_NADIE.Dimension_tipo_paquete

IF EXISTS (SELECT name FROM sys.tables WHERE name = 'Dimension_estado_pedido')
	DROP TABLE NO_SE_BAJA_NADIE.Dimension_estado_pedido

IF EXISTS (SELECT name FROM sys.tables WHERE name = 'Dimension_estado_envio_mensajeria')
	DROP TABLE NO_SE_BAJA_NADIE.Dimension_estado_envio_mensajeria

IF EXISTS (SELECT name FROM sys.tables WHERE name = 'Dimension_estado_reclamo')
	DROP TABLE NO_SE_BAJA_NADIE.Dimension_estado_reclamo

IF EXISTS (SELECT name FROM sys.tables WHERE name = 'Dimension_tipo_reclamo')
	DROP TABLE NO_SE_BAJA_NADIE.Dimension_tipo_reclamo

IF EXISTS (SELECT name FROM sys.tables WHERE name = 'Dimension_cupon_pedido')
	DROP TABLE NO_SE_BAJA_NADIE.Dimension_cupon_pedido

IF EXISTS (SELECT name FROM sys.tables WHERE name = 'Dimension_cupon_reclamo')
	DROP TABLE NO_SE_BAJA_NADIE.Dimension_cupon_reclamo

PRINT '**** Tablas BI dropeados correctamente ****';

/********* Drop de Stored Procedures *********/

IF EXISTS (SELECT name FROM sys.procedures WHERE name = 'Migrar_Dimension_tiempo')
	DROP PROCEDURE NO_SE_BAJA_NADIE.Migrar_Dimension_tiempo

IF EXISTS (SELECT name FROM sys.procedures WHERE name = 'Migrar_Dimension_dia')
	DROP PROCEDURE NO_SE_BAJA_NADIE.Migrar_Dimension_dia

IF EXISTS (SELECT name FROM sys.procedures WHERE name = 'Migrar_Dimension_rango_horario')
	DROP PROCEDURE NO_SE_BAJA_NADIE.Migrar_Dimension_rango_horario

IF EXISTS (SELECT name FROM sys.procedures WHERE name = 'Migrar_Dimension_rango_horario_inicial')
	DROP PROCEDURE NO_SE_BAJA_NADIE.Migrar_Dimension_rango_horario_inicial

IF EXISTS (SELECT name FROM sys.procedures WHERE name = 'Migrar_Dimension_rango_horario_final')
	DROP PROCEDURE NO_SE_BAJA_NADIE.Migrar_Dimension_rango_horario_final

IF EXISTS (SELECT name FROM sys.procedures WHERE name = 'Migrar_Dimension_localidad')
	DROP PROCEDURE NO_SE_BAJA_NADIE.Migrar_Dimension_localidad

IF EXISTS (SELECT name FROM sys.procedures WHERE name = 'Migrar_Dimension_rango_etario')
    DROP PROCEDURE NO_SE_BAJA_NADIE.Migrar_Dimension_rango_etario

IF EXISTS (SELECT name FROM sys.procedures WHERE name = 'Migrar_Dimension_rango_etario_usuario')
    DROP PROCEDURE NO_SE_BAJA_NADIE.Migrar_Dimension_rango_etario_usuario

IF EXISTS (SELECT name FROM sys.procedures WHERE name = 'Migrar_Dimension_rango_etario_repartidor')
    DROP PROCEDURE NO_SE_BAJA_NADIE.Migrar_Dimension_rango_etario_repartidor

IF EXISTS (SELECT name FROM sys.procedures WHERE name = 'Migrar_Dimension_rango_etario_operador')
    DROP PROCEDURE NO_SE_BAJA_NADIE.Migrar_Dimension_rango_etario_operador

IF EXISTS (SELECT name FROM sys.procedures WHERE name = 'Migrar_Dimension_tipo_medio_pago')
	DROP PROCEDURE NO_SE_BAJA_NADIE.Migrar_Dimension_tipo_medio_pago

IF EXISTS (SELECT name FROM sys.procedures WHERE name = 'Migrar_Dimension_local')
	DROP PROCEDURE NO_SE_BAJA_NADIE.Migrar_Dimension_local

IF EXISTS (SELECT name FROM sys.procedures WHERE name = 'Migrar_Dimension_tipo_local')
	DROP PROCEDURE NO_SE_BAJA_NADIE.Migrar_Dimension_tipo_local

IF EXISTS (SELECT name FROM sys.procedures WHERE name = 'Migrar_Dimension_categoria_local')
	DROP PROCEDURE NO_SE_BAJA_NADIE.Migrar_Dimension_categoria_local

IF EXISTS (SELECT name FROM sys.procedures WHERE name = 'Migrar_Dimension_tipo_movilidad')
	DROP PROCEDURE NO_SE_BAJA_NADIE.Migrar_Dimension_tipo_movilidad

IF EXISTS (SELECT name FROM sys.procedures WHERE name = 'Migrar_Dimension_tipo_paquete')
	DROP PROCEDURE NO_SE_BAJA_NADIE.Migrar_Dimension_tipo_paquete

IF EXISTS (SELECT name FROM sys.procedures WHERE name = 'Migrar_Dimension_estado_pedido')
	DROP PROCEDURE NO_SE_BAJA_NADIE.Migrar_Dimension_estado_pedido

IF EXISTS (SELECT name FROM sys.procedures WHERE name = 'Migrar_Dimension_estado_envio_mensajeria')
	DROP PROCEDURE NO_SE_BAJA_NADIE.Migrar_Dimension_estado_envio_mensajeria

IF EXISTS (SELECT name FROM sys.procedures WHERE name = 'Migrar_Dimension_estado_reclamo')
	DROP PROCEDURE NO_SE_BAJA_NADIE.Migrar_Dimension_estado_reclamo

IF EXISTS (SELECT name FROM sys.procedures WHERE name = 'Migrar_Dimension_tipo_reclamo')
	DROP PROCEDURE NO_SE_BAJA_NADIE.Migrar_Dimension_tipo_reclamo

IF EXISTS (SELECT name FROM sys.procedures WHERE name = 'Migrar_Dimension_cupon_pedido')
	DROP PROCEDURE NO_SE_BAJA_NADIE.Migrar_Dimension_cupon_pedido

IF EXISTS (SELECT name FROM sys.procedures WHERE name = 'Migrar_Dimension_cupon_reclamo')
	DROP PROCEDURE NO_SE_BAJA_NADIE.Migrar_Dimension_cupon_reclamo

IF EXISTS (SELECT name FROM sys.procedures WHERE name = 'Migrar_Hechos_pedidos')
	DROP PROCEDURE NO_SE_BAJA_NADIE.Migrar_Hechos_pedidos

IF EXISTS (SELECT name FROM sys.procedures WHERE name = 'Migrar_Hechos_envio_mensajeria')
	DROP PROCEDURE NO_SE_BAJA_NADIE.Migrar_Hechos_envio_mensajeria

IF EXISTS (SELECT name FROM sys.procedures WHERE name = 'Migrar_Hechos_reclamo')
	DROP PROCEDURE NO_SE_BAJA_NADIE.Migrar_Hechos_reclamo

	PRINT '**** Stored Procedures BI dropeados correctamente ****';

GO

/********* Drop de Vistas *********/
IF EXISTS (SELECT name FROM sys.objects WHERE name = 'v_BI_Mayor_cantidad_pedidos_mensualmente')
	DROP VIEW NO_SE_BAJA_NADIE.v_BI_Mayor_cantidad_pedidos_mensualmente;

IF EXISTS (SELECT name FROM sys.objects WHERE name = 'v_BI_Monto_perdido_cancelacion')
	DROP VIEW NO_SE_BAJA_NADIE.v_BI_Monto_perdido_cancelacion;

IF EXISTS (SELECT name FROM sys.objects WHERE name = 'v_BI_Valor_promedio_mensual')
	DROP VIEW NO_SE_BAJA_NADIE.v_BI_Valor_promedio_mensual;

IF EXISTS (SELECT name FROM sys.objects WHERE name = 'v_BI_Desvio_promedio_tiempo_entrega')
	DROP VIEW NO_SE_BAJA_NADIE.v_BI_Desvio_promedio_tiempo_entrega;

IF EXISTS (SELECT name FROM sys.objects WHERE name = 'v_BI_Monto_cupones_utilizados_mensualmente')
	DROP VIEW NO_SE_BAJA_NADIE.v_BI_Monto_cupones_utilizados_mensualmente;

IF EXISTS (SELECT name FROM sys.objects WHERE name = 'v_BI_Promedio_calificacion_mensual_local')
	DROP VIEW NO_SE_BAJA_NADIE.v_BI_Promedio_calificacion_mensual_local;

IF EXISTS (SELECT name FROM sys.objects WHERE name = 'v_BI_Promedio_entregados_mensualmente')
	DROP VIEW NO_SE_BAJA_NADIE.v_BI_Promedio_entregados_mensualmente;

IF EXISTS (SELECT name FROM sys.objects WHERE name = 'v_BI_Promedio_mensual_valor_asegurado_paquetes')
	DROP VIEW NO_SE_BAJA_NADIE.v_BI_Promedio_mensual_valor_asegurado_paquetes;

IF EXISTS (SELECT name FROM sys.objects WHERE name = 'v_BI_Cantidad_reclamos_mensuales_local')
	DROP VIEW NO_SE_BAJA_NADIE.v_BI_Cantidad_reclamos_mensuales_local;

IF EXISTS (SELECT name FROM sys.objects WHERE name = 'v_BI_Tiempo_promedio_resolucion_reclamos_mensualmente')
	DROP VIEW NO_SE_BAJA_NADIE.v_BI_Tiempo_promedio_resolucion_reclamos_mensualmente;

IF EXISTS (SELECT name FROM sys.objects WHERE name = 'v_BI_Monto_mensual_cupones_reclamos')
	DROP VIEW NO_SE_BAJA_NADIE.v_BI_Monto_mensual_cupones_reclamos;

PRINT '**** Vistas BI dropeadas correctamente ****';

GO
/*
--DROP PREVENTIVO DE SCHEMA-------------------------
IF EXISTS (SELECT name FROM sys.schemas WHERE name = 'NO_SE_BAJA_NADIE')
DROP SCHEMA NO_SE_BAJA_NADIE
GO

--CREACIÓN DE SCHEMA--------------------------------
CREATE SCHEMA NO_SE_BAJA_NADIE;
GO
*/

/********* Creación de Tablas *********/

--Tiempo
CREATE TABLE NO_SE_BAJA_NADIE.Dimension_tiempo(
	ID int IDENTITY,
	ANIO int,
	MES int
);

--Dia
CREATE TABLE NO_SE_BAJA_NADIE.Dimension_dia(
	ID int IDENTITY,
	DIA_SEMANA nvarchar(50)
);

--Rango Horario
CREATE TABLE NO_SE_BAJA_NADIE.Dimension_rango_horario(
	ID int IDENTITY,
	RANGO_HORARIO varchar(50)
);
--Localidad
CREATE TABLE NO_SE_BAJA_NADIE.Dimension_localidad(
	ID int IDENTITY,
	LOCALIDAD_DESCRIPCION nvarchar(255)
);

--Rango Etario Usuario
CREATE TABLE NO_SE_BAJA_NADIE.Dimension_rango_etario_usuario(
    ID int IDENTITY,
    RANGO_ETARIO_USUARIO nvarchar(50)
);

--Rango Etario Repartidor
CREATE TABLE NO_SE_BAJA_NADIE.Dimension_rango_etario_repartidor(
    ID int IDENTITY,
    RANGO_ETARIO_REPARTIDOR nvarchar(50)
);

--Rango Etario Operador
CREATE TABLE NO_SE_BAJA_NADIE.Dimension_rango_etario_operador(
    ID int IDENTITY,
    RANGO_ETARIO_OPERADOR nvarchar(50)
);

--Medio De Pago
CREATE TABLE NO_SE_BAJA_NADIE.Dimension_medio_de_pago_tipo( 
	ID int IDENTITY,
	MEDIO_PAGO_TIPO nvarchar(50)
);

-- Local
CREATE TABLE NO_SE_BAJA_NADIE.Dimension_local(
	ID int IDENTITY ,
	LOCAL_DESCRIPCION nvarchar(255) 
);

--Categoria local

CREATE TABLE NO_SE_BAJA_NADIE.Dimension_categoria_local(
	ID int IDENTITY ,
	LOCAL_TIPO_ID int NOT NULL,
	CATEGORIA_DESCRIPCION nvarchar(50) 
);

--Tipo local

CREATE TABLE NO_SE_BAJA_NADIE.Dimension_tipo_local(
	ID int IDENTITY ,
	TIPO_LOCAL_DESCRIPCION nvarchar(50) 
);

--Tipo Movilidad

CREATE TABLE NO_SE_BAJA_NADIE.Dimension_tipo_movilidad(
	ID int IDENTITY ,
	TIPO_MOVILIDAD_NOMBRE nvarchar(50) 
);

--Tipo Paquete

CREATE TABLE NO_SE_BAJA_NADIE.Dimension_tipo_paquete(
	ID int IDENTITY ,
	TIPO_PAQUETE_DESCRIPCION nvarchar(50),
	PRECIO_PAQUETE decimal(18,2)
);

--Estados Pedidos

CREATE TABLE NO_SE_BAJA_NADIE.Dimension_estado_pedido(
	ID int IDENTITY ,
	ESTADO_PEDIDO_DESCRIPCION nvarchar(50) 
);

--Estados envíos mensajería
CREATE TABLE NO_SE_BAJA_NADIE.Dimension_estado_envio_mensajeria(
	ID int IDENTITY ,
	ESTADO_ENVIO_MENSAJERIA_DESCRIPCION nvarchar(50) 
);

--Estados Reclamos
CREATE TABLE NO_SE_BAJA_NADIE.Dimension_estado_reclamo(
	ID int IDENTITY ,
	ESTADO_RECLAMO_DESCRIPCION nvarchar(50) 
);

--Tipos Reclamos
CREATE TABLE NO_SE_BAJA_NADIE.Dimension_tipo_reclamo(
	ID int IDENTITY ,
	TIPO_RECLAMO_DESCRIPCION nvarchar(50) 
);

--Cupon Pedido
CREATE TABLE NO_SE_BAJA_NADIE.Dimension_cupon_pedido(
	ID int IDENTITY,
	ID_CUPON_PEDIDO_NRO decimal(18,0) NOT NULL,
	MONTO decimal(18,2)
);

-- Cupon reclamo
CREATE TABLE NO_SE_BAJA_NADIE.Dimension_cupon_reclamo(
	ID int IDENTITY,
	ID_CUPON_RECLAMO_NRO decimal(18,0) NOT NULL,
	MONTO decimal(18,2)
);

--Pedidos
CREATE TABLE NO_SE_BAJA_NADIE.Hechos_pedidos(
	ID int IDENTITY,
	ID_TIEMPO int NOT NULL,
	ID_DIA int NOT NULL,
	ID_RANGO_HORARIO int NOT NULL,
	ID_LOCALIDAD int NOT NULL,
	ID_RANGO_ETARIO_USUARIO int NOT NULL,
	ID_RANGO_ETARIO_REPARTIDOR int NOT NULL,
	ID_MEDIO_PAGO_TIPO int NOT NULL,
	ID_LOCAL int NOT NULL,
	ID_TIPO_LOCAL int NOT NULL,
	ID_CATEGORIA_LOCAL int NOT NULL,
	ID_TIPO_MOVILIDAD int NOT NULL,
	ID_ESTADO_PEDIDO int NOT NULL,
	ID_CUPON_PEDIDO int NOT NULL,
	CANTIDAD_PEDIDOS int NULL,
	VALOR_PROMEDIO_ENVIO decimal(18,2) NULL,
	TOTAL decimal(18,2) NULL,
	DESVIO_MINUTOS decimal(18,2) NULL,
	PROMEDIO_CALIFICACION decimal(18,0) NULL
);

-- Hecho mensajeria
CREATE TABLE NO_SE_BAJA_NADIE.Hechos_envio_mensajeria (
	ID int IDENTITY,
	ID_TIEMPO int NOT NULL,
	ID_DIA int NOT NULL,
	ID_RANGO_HORARIO int NOT NULL,
	ID_LOCALIDAD int NOT NULL,
	ID_RANGO_ETARIO_USUARIO int NOT NULL,
	ID_RANGO_ETARIO_REPARTIDOR int NOT NULL,
	ID_TIPO_MOVILIDAD int NOT NULL,
	ID_TIPO_PAQUETE int NOT NULL,
	ID_ESTADO_ENVIO_MENSAJERIA int NOT NULL,
	CANTIDAD_ENVIOS int NOT NULL,
	PROMEDIO_VALOR_ASEGURADO decimal(18,2) NULL,
	TOTAL decimal(18,2) NULL,
	DESVIO_MINUTOS decimal(18,2) NULL,
	PROMEDIO_CALIFICACION decimal(18,0) NULL
);

--Hecho Reclamo 
CREATE TABLE NO_SE_BAJA_NADIE.Hechos_reclamo(
	ID int IDENTITY,
	ID_TIEMPO int NOT NULL,
	ID_DIA int NOT NULL,
	ID_RANGO_HORARIO int NOT NULL,
	ID_LOCAL int NOT NULL,
	ID_RANGO_ETARIO_OPERADOR int NOT NULL,
	ID_ESTADO_RECLAMO int NOT NULL,
	ID_TIPO_RECLAMO int NOT NULL,
	ID_CUPON_RECLAMO int NOT NULL,
	CANTIDAD_RECLAMOS int NULL,
	TIEMPO_RESOLUCION_MINUTOS decimal(18,0) NULL,
	PROMEDIO_CALIFICACION decimal(18,2) NULL
);

PRINT '**** Tablas creadas correctamente ****';

GO

/********* Creacion de CONSTRAINTS ********/
--Tiempo
ALTER TABLE NO_SE_BAJA_NADIE.Dimension_tiempo
ADD
		CONSTRAINT PK_BI_Tiempo PRIMARY KEY (ID);

--Dia
ALTER TABLE NO_SE_BAJA_NADIE.Dimension_dia
ADD
		CONSTRAINT PK_BI_Dia PRIMARY KEY (ID);

--Rango Horario inicial
ALTER TABLE NO_SE_BAJA_NADIE.Dimension_rango_horario
ADD
		CONSTRAINT PK_BI_rango_horario PRIMARY KEY (ID);

--Localidad
ALTER TABLE NO_SE_BAJA_NADIE.Dimension_localidad
ADD
		CONSTRAINT PK_BI_Localidad PRIMARY KEY (ID);

--Rango Etario usuario
ALTER TABLE NO_SE_BAJA_NADIE.Dimension_rango_etario_usuario
ADD
		CONSTRAINT PK_BI_Rango_etario_usuario PRIMARY KEY (ID);

--Rango Etario repartidor
ALTER TABLE NO_SE_BAJA_NADIE.Dimension_rango_etario_repartidor
ADD
		CONSTRAINT PK_BI_Rango_etario_repartidor PRIMARY KEY (ID);

--Rango Etario operador
ALTER TABLE NO_SE_BAJA_NADIE.Dimension_rango_etario_operador
ADD
		CONSTRAINT PK_BI_Rango_etario_operador PRIMARY KEY (ID);

--Medio de Pago
ALTER TABLE NO_SE_BAJA_NADIE.Dimension_medio_de_pago_tipo
ADD
		CONSTRAINT PK_BI_Medio_pago_tipo PRIMARY KEY (ID);
		
--Local
ALTER TABLE NO_SE_BAJA_NADIE.Dimension_local
ADD
		CONSTRAINT PK_BI_Local PRIMARY KEY (ID);

--Tipo Local
ALTER TABLE NO_SE_BAJA_NADIE.Dimension_tipo_local
ADD
		CONSTRAINT PK_BI_Tipo_local PRIMARY KEY (ID);

--Categoria Local
ALTER TABLE NO_SE_BAJA_NADIE.Dimension_categoria_local
ADD
		CONSTRAINT PK_BI_Categoria_local PRIMARY KEY (ID),
		CONSTRAINT UQ_BI_Local_categoria_tipo_categoria UNIQUE (LOCAL_TIPO_ID, CATEGORIA_DESCRIPCION),
		CONSTRAINT FK_BI_Tipo_local_categoria FOREIGN KEY (LOCAL_TIPO_ID) REFERENCES NO_SE_BAJA_NADIE.Dimension_tipo_local (ID);

--Tipo Movilidad
ALTER TABLE NO_SE_BAJA_NADIE.Dimension_tipo_movilidad
ADD
		CONSTRAINT PK_BI_Tipo_movilidad PRIMARY KEY (ID);

--Paquete tipo
ALTER TABLE NO_SE_BAJA_NADIE.Dimension_tipo_paquete
ADD
		CONSTRAINT PK_BI_Tipo_paquete PRIMARY KEY (ID);

--Estado pedido
ALTER TABLE NO_SE_BAJA_NADIE.Dimension_estado_pedido
ADD
		CONSTRAINT PK_BI_Estado_pedido PRIMARY KEY (ID);

--Estado mensajeria
ALTER TABLE NO_SE_BAJA_NADIE.Dimension_estado_envio_mensajeria
ADD
		CONSTRAINT PK_BI_estado_envio_mensajeria PRIMARY KEY (ID);

--Estado reclamo
ALTER TABLE NO_SE_BAJA_NADIE.Dimension_estado_reclamo
ADD
		CONSTRAINT PK_BI_Estado_reclamo PRIMARY KEY (ID);

--Tipo Reclamo
ALTER TABLE NO_SE_BAJA_NADIE.Dimension_tipo_reclamo
ADD
		CONSTRAINT PK_BI_Tipo_reclamo PRIMARY KEY (ID);

--Cupon Pedido
ALTER TABLE NO_SE_BAJA_NADIE.Dimension_cupon_pedido
ADD
		CONSTRAINT PK_BI_Cupon_pedido PRIMARY KEY (ID),
		CONSTRAINT UC_BI_Cupon_pedido_nro UNIQUE (ID_CUPON_PEDIDO_NRO);

--Cupon Reclamo
ALTER TABLE NO_SE_BAJA_NADIE.Dimension_cupon_reclamo
ADD
		CONSTRAINT PK_BI_Cupon_reclamo PRIMARY KEY (ID),
		CONSTRAINT UC_BI_Cupon_reclamo_nro UNIQUE (ID_CUPON_RECLAMO_NRO);

--Pedido
ALTER TABLE NO_SE_BAJA_NADIE.Hechos_pedidos
ADD
		CONSTRAINT PK_BI_Pedido PRIMARY KEY (ID),
		CONSTRAINT FK_BI_Tiempo_pedido FOREIGN KEY (ID_TIEMPO) REFERENCES NO_SE_BAJA_NADIE.Dimension_tiempo (ID),
		CONSTRAINT FK_BI_Dia_pedido FOREIGN KEY (ID_DIA) REFERENCES NO_SE_BAJA_NADIE.Dimension_dia (ID),
		CONSTRAINT FK_BI_Rango_horario_pedido FOREIGN KEY (ID_RANGO_HORARIO) REFERENCES NO_SE_BAJA_NADIE.Dimension_rango_horario (ID),
		CONSTRAINT FK_BI_Localidad_pedido FOREIGN KEY (ID_LOCALIDAD) REFERENCES NO_SE_BAJA_NADIE.Dimension_localidad (ID),
		CONSTRAINT FK_BI_Rango_etario_usuario_pedido FOREIGN KEY (ID_RANGO_ETARIO_USUARIO) REFERENCES NO_SE_BAJA_NADIE.Dimension_rango_etario_usuario (ID),
		CONSTRAINT FK_BI_Rango_etario_repartidor_pedido FOREIGN KEY (ID_RANGO_ETARIO_REPARTIDOR) REFERENCES NO_SE_BAJA_NADIE.Dimension_rango_etario_repartidor (ID),
		CONSTRAINT FK_BI_Medio_de_pago_pedido FOREIGN KEY (ID_MEDIO_PAGO_TIPO) REFERENCES NO_SE_BAJA_NADIE.Dimension_medio_de_pago_tipo (ID),
		CONSTRAINT FK_BI_Local_pedido FOREIGN KEY (ID_LOCAL) REFERENCES NO_SE_BAJA_NADIE.Dimension_local (ID),
		CONSTRAINT FK_BI_Tipo_local_pedido FOREIGN KEY (ID_TIPO_LOCAL) REFERENCES NO_SE_BAJA_NADIE.Dimension_tipo_local (ID),
		CONSTRAINT FK_BI_Categoria_local_pedido FOREIGN KEY (ID_CATEGORIA_LOCAL) REFERENCES NO_SE_BAJA_NADIE.Dimension_categoria_local (ID),
		CONSTRAINT FK_BI_Tipo_movilidad_pedido FOREIGN KEY (ID_TIPO_MOVILIDAD) REFERENCES NO_SE_BAJA_NADIE.Dimension_tipo_movilidad (ID),
		CONSTRAINT FK_BI_Estado_pedido FOREIGN KEY (ID_ESTADO_PEDIDO) REFERENCES NO_SE_BAJA_NADIE.Dimension_estado_pedido (ID),
		CONSTRAINT FK_BI_Cupon_pedido FOREIGN KEY (ID_CUPON_PEDIDO) REFERENCES NO_SE_BAJA_NADIE.Dimension_cupon_pedido (ID);
		
--Envio Mensajeria
ALTER TABLE NO_SE_BAJA_NADIE.Hechos_envio_mensajeria
ADD
		CONSTRAINT PK_BI_Envio_mensajeria PRIMARY KEY (ID),
		CONSTRAINT FK_BI_Tiempo_mensajeria FOREIGN KEY (ID_TIEMPO) REFERENCES NO_SE_BAJA_NADIE.Dimension_tiempo (ID),
		CONSTRAINT FK_BI_Dia_mensajeria FOREIGN KEY (ID_DIA) REFERENCES NO_SE_BAJA_NADIE.Dimension_dia (ID),
		CONSTRAINT FK_BI_Rango_horario_mensajeria FOREIGN KEY (ID_RANGO_HORARIO) REFERENCES NO_SE_BAJA_NADIE.Dimension_rango_horario (ID),
		CONSTRAINT FK_BI_Localidad_mensajeria FOREIGN KEY (ID_LOCALIDAD) REFERENCES NO_SE_BAJA_NADIE.Dimension_localidad (ID),
		CONSTRAINT FK_BI_Rango_etario_usuario_mensajeria FOREIGN KEY (ID_RANGO_ETARIO_USUARIO) REFERENCES NO_SE_BAJA_NADIE.Dimension_rango_etario_usuario (ID),
		CONSTRAINT FK_BI_Rango_etario_repartidor_mensajeria FOREIGN KEY (ID_RANGO_ETARIO_REPARTIDOR) REFERENCES NO_SE_BAJA_NADIE.Dimension_rango_etario_repartidor (ID),
		CONSTRAINT FK_BI_Tipo_movilidad_mensajeria FOREIGN KEY (ID_TIPO_MOVILIDAD) REFERENCES NO_SE_BAJA_NADIE.Dimension_tipo_movilidad (ID),
		CONSTRAINT FK_BI_Tipo_paquete_mensajeria FOREIGN KEY (ID_TIPO_PAQUETE) REFERENCES NO_SE_BAJA_NADIE.Dimension_tipo_paquete (ID),
		CONSTRAINT FK_BI_Estado_envio_mensajeria FOREIGN KEY (ID_ESTADO_ENVIO_MENSAJERIA) REFERENCES NO_SE_BAJA_NADIE.Dimension_estado_envio_mensajeria (ID);
	
--Reclamo
ALTER TABLE NO_SE_BAJA_NADIE.Hechos_reclamo
ADD
		CONSTRAINT PK_BI_Reclamo PRIMARY KEY (ID),
		CONSTRAINT FK_BI_Tiempo_reclamo FOREIGN KEY (ID_TIEMPO) REFERENCES NO_SE_BAJA_NADIE.Dimension_tiempo (ID),
		CONSTRAINT FK_BI_Dia_reclamo FOREIGN KEY (ID_DIA) REFERENCES NO_SE_BAJA_NADIE.Dimension_dia (ID),
		CONSTRAINT FK_BI_Rango_horario_reclamo FOREIGN KEY (ID_RANGO_HORARIO) REFERENCES NO_SE_BAJA_NADIE.Dimension_rango_horario (ID),
		CONSTRAINT FK_BI_Local_reclamo FOREIGN KEY (ID_LOCAL) REFERENCES NO_SE_BAJA_NADIE.Dimension_local (ID),
		CONSTRAINT FK_BI_Rango_etario_operador_reclamo FOREIGN KEY (ID_RANGO_ETARIO_OPERADOR) REFERENCES NO_SE_BAJA_NADIE.Dimension_rango_etario_operador (ID),
		CONSTRAINT FK_BI_Estado_reclamo FOREIGN KEY (ID_ESTADO_RECLAMO) REFERENCES NO_SE_BAJA_NADIE.Dimension_estado_reclamo (ID),
		CONSTRAINT FK_BI_Tipo_reclamo FOREIGN KEY (ID_TIPO_RECLAMO) REFERENCES NO_SE_BAJA_NADIE.Dimension_tipo_reclamo (ID),
		CONSTRAINT FK_BI_Cupon_reclamo FOREIGN KEY (Id_cupon_reclamo) REFERENCES NO_SE_BAJA_NADIE.Dimension_cupon_reclamo (ID);

PRINT '**** CONSTRAINTs BI creadas correctamente ****';
GO

/********* Creacion de Vistas *********/

-- Mayor cantidad de pedidos mensualmente

CREATE VIEW NO_SE_BAJA_NADIE.v_BI_Mayor_cantidad_pedidos_mensualmente
AS
	SELECT t.ANIO, 
		   t.MES, 
		   d.DIA_SEMANA, 
		   rh.RANGO_HORARIO, 
		   l.LOCALIDAD_DESCRIPCION, 
		   cl.CATEGORIA_DESCRIPCION, 
		   COUNT(p.CANTIDAD_PEDIDOS) AS CANTIDAD_PEDIDOS
FROM
    NO_SE_BAJA_NADIE.Hechos_pedidos p
    JOIN NO_SE_BAJA_NADIE.Dimension_tiempo t ON p.ID_TIEMPO = t.ID
    JOIN NO_SE_BAJA_NADIE.Dimension_dia d ON p.ID_DIA = d.ID
    JOIN NO_SE_BAJA_NADIE.Dimension_rango_horario rh ON p.ID_RANGO_HORARIO = rh.ID
    JOIN NO_SE_BAJA_NADIE.Dimension_localidad l ON p.ID_LOCALIDAD = l.ID
    JOIN NO_SE_BAJA_NADIE.Dimension_categoria_local cl ON p.ID_CATEGORIA_LOCAL = cl.ID
GROUP BY t.ANIO, t.MES, d.DIA_SEMANA, rh.RANGO_HORARIO, l.LOCALIDAD_DESCRIPCION, cl.CATEGORIA_DESCRIPCION
GO


--Monto perdido por cancelacion

CREATE VIEW NO_SE_BAJA_NADIE.v_BI_Monto_perdido_cancelacion
AS
	SELECT d.DIA_SEMANA, 
		   rh.RANGO_HORARIO, 
		   l.LOCAL_DESCRIPCION, 
		   SUM(p.TOTAL) AS MONTO_NO_COBRADO
FROM
    NO_SE_BAJA_NADIE.Hechos_pedidos p
    JOIN NO_SE_BAJA_NADIE.Dimension_dia d ON p.ID_DIA = d.ID
    JOIN NO_SE_BAJA_NADIE.Dimension_rango_horario rh ON p.ID_RANGO_HORARIO = rh.ID
    JOIN NO_SE_BAJA_NADIE.Dimension_local l ON p.ID_LOCAL = l.ID
    JOIN NO_SE_BAJA_NADIE.Dimension_estado_pedido ep ON p.ID_ESTADO_PEDIDO = ep.ID
WHERE ep.ESTADO_PEDIDO_DESCRIPCION = 'Estado Mensajeria Cancelado'
GROUP BY d.DIA_SEMANA, rh.RANGO_HORARIO, l.LOCAL_DESCRIPCION
GO

--Valor promedio mensual

CREATE VIEW NO_SE_BAJA_NADIE.v_BI_Valor_promedio_mensual
AS
	SELECT
    t.MES,
	t.ANIO,
	l.LOCALIDAD_DESCRIPCION,
    SUM(p.VALOR_PROMEDIO_ENVIO)/COUNT(p.VALOR_PROMEDIO_ENVIO) AS VALOR_PROMEDIO_ENVIOS
FROM
    NO_SE_BAJA_NADIE.Hechos_pedidos p
    JOIN NO_SE_BAJA_NADIE.Dimension_tiempo t ON p.ID_TIEMPO = t.ID
    JOIN NO_SE_BAJA_NADIE.Dimension_localidad l ON p.ID_LOCALIDAD = l.ID
    JOIN NO_SE_BAJA_NADIE.Dimension_estado_pedido ep ON p.ID_ESTADO_PEDIDO = ep.ID
WHERE ep.ESTADO_PEDIDO_DESCRIPCION = 'Estado Mensajeria Entregado'
GROUP BY t.MES, t.ANIO, l.LOCALIDAD_DESCRIPCION, p.VALOR_PROMEDIO_ENVIO
GO

--Desvio promedio

CREATE VIEW NO_SE_BAJA_NADIE.v_BI_Desvio_promedio_tiempo_entrega
AS
WITH Pedidos AS (
    SELECT p.ID,
        p.ID_TIEMPO,
        p.ID_DIA,
        p.ID_TIPO_MOVILIDAD,
        p.ID_ESTADO_PEDIDO,
        p.DESVIO_MINUTOS as desvio_minutos
    FROM NO_SE_BAJA_NADIE.Hechos_pedidos p
         JOIN NO_SE_BAJA_NADIE.Dimension_tiempo t ON p.ID_TIEMPO = t.ID
	WHERE p.DESVIO_MINUTOS IS NOT NULL 
), Mensajeria AS (
    SELECT
        em.ID,
        em.ID_TIEMPO,
        em.ID_DIA,
        em.ID_TIPO_MOVILIDAD,
        em.ID_ESTADO_ENVIO_MENSAJERIA,
        em.DESVIO_MINUTOS as desvio_minutos
    FROM NO_SE_BAJA_NADIE.Hechos_envio_mensajeria em
        JOIN NO_SE_BAJA_NADIE.Dimension_tiempo t ON em.ID_TIEMPO = t.ID
	WHERE em.DESVIO_MINUTOS is NOT NULL
)
SELECT
    d.DIA_SEMANA,
    tm.TIPO_MOVILIDAD_NOMBRE,
    AVG(desvio_minutos) AS DESVIO_PROMEDIO_MINUTOS
FROM
(
SELECT
	ID_DIA,
	ID_TIPO_MOVILIDAD,
	desvio_minutos
FROM Pedidos
       WHERE ID_ESTADO_PEDIDO = (SELECT ID FROM NO_SE_BAJA_NADIE.Dimension_estado_pedido WHERE ESTADO_PEDIDO_DESCRIPCION = 'Estado Mensajeria Entregado')
UNION ALL
SELECT
	ID_DIA,
	ID_TIPO_MOVILIDAD,
	desvio_minutos
FROM Mensajeria
       WHERE ID_ESTADO_ENVIO_MENSAJERIA = (SELECT ID FROM NO_SE_BAJA_NADIE.Dimension_estado_envio_mensajeria WHERE ESTADO_ENVIO_MENSAJERIA_DESCRIPCION = 'Estado Mensajeria Entregado')
) AS combinadas
    JOIN NO_SE_BAJA_NADIE.Dimension_dia d ON combinadas.ID_DIA = d.ID
    JOIN NO_SE_BAJA_NADIE.Dimension_tipo_movilidad tm ON combinadas.ID_TIPO_MOVILIDAD = tm.ID
GROUP BY d.DIA_SEMANA, tm.TIPO_MOVILIDAD_NOMBRE; 
GO

--Monto de cupones utilizados mensualmente

CREATE VIEW NO_SE_BAJA_NADIE.v_BI_Monto_cupones_utilizados_mensualmente
AS
	SELECT
    t.MES,
	t.ANIO, --Pq sino no se entiende
    r.RANGO_ETARIO_USUARIO,
    SUM(cp.MONTO) AS MONTO_TOTAL_CUPONES
FROM
    NO_SE_BAJA_NADIE.Hechos_pedidos p
    JOIN NO_SE_BAJA_NADIE.Dimension_tiempo t ON p.ID_TIEMPO = t.ID
    JOIN NO_SE_BAJA_NADIE.Dimension_rango_etario_usuario r ON p.ID_RANGO_ETARIO_USUARIO = r.ID
	JOIN NO_SE_BAJA_NADIE.Dimension_cupon_pedido cp ON p.ID_CUPON_PEDIDO = cp.ID
GROUP BY
    t.MES,
	t.ANIO,
    r.RANGO_ETARIO_USUARIO; 
GO

/* Pensar en esto
SELECT
    t.MES,
	t.ANIO,
    r.RANGO_ETARIO_USUARIO,
    SUM(p.TOTAL_CUPONES) AS monto_total_cupones
FROM
    NO_SE_BAJA_NADIE.Hechos_pedidos p
    JOIN NO_SE_BAJA_NADIE.Dimension_tiempo t ON p.ID_TIEMPO = t.ID
    JOIN NO_SE_BAJA_NADIE.Dimension_rango_etario_usuario r ON p.ID_RANGO_ETARIO_USUARIO = r.ID
	
GROUP BY
    t.MES,
	t.ANIO,
    r.RANGO_ETARIO_USUARIO;
*/

--Promedio de CALIFICACION mensual por local

CREATE VIEW NO_SE_BAJA_NADIE.v_BI_Promedio_calificacion_mensual_local
AS
	SELECT t.MES,
	   l.LOCAL_DESCRIPCION, 
	   SUM (p.PROMEDIO_CALIFICACION) / COUNT (p.PROMEDIO_CALIFICACION) AS PROMEDIO_CALIFICACION
FROM NO_SE_BAJA_NADIE.Hechos_pedidos p
	 JOIN NO_SE_BAJA_NADIE.Dimension_tiempo t ON t.ID = p.ID_TIEMPO
	 JOIN NO_SE_BAJA_NADIE.Dimension_local l ON l.ID = p.ID_LOCAL
GROUP BY t.MES, l.LOCAL_DESCRIPCION 
GO

--Porcentaje de entregados mensualmente

CREATE VIEW NO_SE_BAJA_NADIE.v_BI_Promedio_entregados_mensualmente
AS
WITH TotalPedidos AS (
    SELECT
        t.MES,
        r.RANGO_ETARIO_REPARTIDOR,
        l.LOCALIDAD_DESCRIPCION,
        COUNT(p.CANTIDAD_PEDIDOS) AS total_pedidos
    FROM
        NO_SE_BAJA_NADIE.Hechos_pedidos p
        JOIN NO_SE_BAJA_NADIE.Dimension_tiempo t ON p.ID_TIEMPO = t.ID
        JOIN NO_SE_BAJA_NADIE.Dimension_rango_etario_repartidor r ON p.ID_RANGO_ETARIO_REPARTIDOR = r.ID
        JOIN NO_SE_BAJA_NADIE.Dimension_localidad l ON p.ID_LOCALIDAD = l.ID
		JOIN NO_SE_BAJA_NADIE.Dimension_estado_pedido ep ON p.ID_ESTADO_PEDIDO = ep.ID
	WHERE ep.ESTADO_PEDIDO_DESCRIPCION = 'Estado Mensajeria Entregado'
    GROUP BY t.MES, r.RANGO_ETARIO_REPARTIDOR, l.LOCALIDAD_DESCRIPCION
),
Envios_Mensajeria AS (
    SELECT
        t.MES,
        r.RANGO_ETARIO_REPARTIDOR,
        l.LOCALIDAD_DESCRIPCION,
        COUNT(em.CANTIDAD_ENVIOS) AS total_envios
    FROM
        NO_SE_BAJA_NADIE.Hechos_envio_mensajeria em
        JOIN NO_SE_BAJA_NADIE.Dimension_tiempo t ON em.ID_TIEMPO = t.ID
        JOIN NO_SE_BAJA_NADIE.Dimension_rango_etario_repartidor r ON em.ID_RANGO_ETARIO_REPARTIDOR = r.ID
        JOIN NO_SE_BAJA_NADIE.Dimension_localidad l ON em.ID_LOCALIDAD = l.ID
        JOIN NO_SE_BAJA_NADIE.Dimension_estado_envio_mensajeria eem ON em.ID_ESTADO_ENVIO_MENSAJERIA = eem.ID
    WHERE eem.ESTADO_ENVIO_MENSAJERIA_DESCRIPCION = 'Estado Mensajeria Entregado'
    GROUP BY t.MES, r.RANGO_ETARIO_REPARTIDOR, l.LOCALIDAD_DESCRIPCION
)
SELECT
    p.MES,
    p.RANGO_ETARIO_REPARTIDOR,
    p.LOCALIDAD_DESCRIPCION,
    (CAST(e.total_envios AS decimal) / p.total_pedidos) * 100 AS PORCENTAJE_ENTREGAS
FROM TotalPedidos p
    JOIN Envios_Mensajeria e ON p.MES = e.MES AND p.RANGO_ETARIO_REPARTIDOR = e.RANGO_ETARIO_REPARTIDOR AND p.LOCALIDAD_DESCRIPCION = e.LOCALIDAD_DESCRIPCION;
GO

--Promedio mensual del valor asegurado de paquetes

CREATE VIEW NO_SE_BAJA_NADIE.v_BI_Promedio_mensual_valor_asegurado_paquetes
AS
	SELECT t.MES, 
		   tp.TIPO_PAQUETE_DESCRIPCION, 
		   SUM(hm.PROMEDIO_VALOR_ASEGURADO)/COUNT(hm.PROMEDIO_VALOR_ASEGURADO) AS PROMEDIO_VALOR_ASEGURADO
	FROM NO_SE_BAJA_NADIE.Hechos_envio_mensajeria hm
	JOIN NO_SE_BAJA_NADIE.Dimension_tiempo t ON t.ID = hm.ID_TIEMPO
	JOIN NO_SE_BAJA_NADIE.Dimension_tipo_paquete tp ON tp.ID = hm.ID_TIPO_PAQUETE
GROUP BY t.MES, tp.TIPO_PAQUETE_DESCRIPCION
GO

--Cantidad reclamos mensuales local

CREATE VIEW NO_SE_BAJA_NADIE.v_BI_Cantidad_reclamos_mensuales_local
AS
SELECT t.MES, 
	   l.LOCAL_DESCRIPCION, 
	   rh.RANGO_HORARIO, 
	   COUNT(r.CANTIDAD_RECLAMOS) AS CANTIDAD_RECLAMOS
	FROM NO_SE_BAJA_NADIE.Hechos_reclamo r
	JOIN NO_SE_BAJA_NADIE.Dimension_local l ON r.ID_LOCAL = l.ID
	JOIN NO_SE_BAJA_NADIE.Dimension_tiempo t ON r.ID_TIEMPO = t.ID
	JOIN NO_SE_BAJA_NADIE.Dimension_rango_horario rh ON rh.ID = r.ID_RANGO_HORARIO
	GROUP BY t.MES, l.LOCAL_DESCRIPCION, rh.RANGO_HORARIO 
GO

--Tiempo promedio resolucion reclamos mensualmente

CREATE VIEW NO_SE_BAJA_NADIE.v_BI_Tiempo_promedio_resolucion_reclamos_mensualmente
AS
	SELECT t.MES, 
		   tr.TIPO_RECLAMO_DESCRIPCION,
	       reo.RANGO_ETARIO_OPERADOR,
	       SUM(r.TIEMPO_RESOLUCION_MINUTOS) / COUNT(r.TIEMPO_RESOLUCION_MINUTOS) AS TIEMPO_PROMEDIO_RESOLUCION_EN_MINUTOS
FROM NO_SE_BAJA_NADIE.Hechos_reclamo r
	 JOIN NO_SE_BAJA_NADIE.Dimension_tiempo t ON r.ID_TIEMPO = t.ID
	 JOIN NO_SE_BAJA_NADIE.Dimension_tipo_reclamo tr ON r.ID_TIPO_RECLAMO = tr.ID
	 JOIN NO_SE_BAJA_NADIE.Dimension_rango_etario_operador reo ON r.ID_RANGO_ETARIO_OPERADOR = reo.ID
	 WHERE r.TIEMPO_RESOLUCION_MINUTOS IS NOT NULL
	 GROUP BY t.MES, tr.TIPO_RECLAMO_DESCRIPCION, reo.RANGO_ETARIO_OPERADOR
GO

--Monto mensual cupones de reclamos

CREATE VIEW NO_SE_BAJA_NADIE.v_BI_Monto_mensual_cupones_reclamos
AS
	SELECT
    t.MES,
    SUM(cr.MONTO) AS MONTO_GENERADO_POR_CUPONES
FROM
    NO_SE_BAJA_NADIE.Hechos_reclamo r
    JOIN NO_SE_BAJA_NADIE.Dimension_tiempo t ON r.ID_TIEMPO = t.ID
    JOIN NO_SE_BAJA_NADIE.Dimension_cupon_reclamo cr ON r.Id_cupon_reclamo = cr.ID
GROUP BY
    t.MES 
GO

PRINT '**** Vistas BI creadas correctamente ****';

GO
/********* Creacion de StoredProcedures para migracion *********/

-- Migrar_Dimension_tiempo
	CREATE PROCEDURE NO_SE_BAJA_NADIE.Migrar_Dimension_tiempo
	AS
	BEGIN
		INSERT INTO NO_SE_BAJA_NADIE.Dimension_tiempo(ANIO, MES)
		SELECT DISTINCT YEAR(FECHA), MONTH(FECHA)

		FROM NO_SE_BAJA_NADIE.pedido
END
GO

-- Migrar_Dimension_dia
    CREATE PROCEDURE NO_SE_BAJA_NADIE.Migrar_Dimension_dia
    AS
    BEGIN
        INSERT INTO NO_SE_BAJA_NADIE.Dimension_dia(DIA_SEMANA)
        SELECT DISTINCT(CASE 
        WHEN DATEPART(WEEKDAY, P.FECHA) = 1 THEN 'L'
        WHEN DATEPART(WEEKDAY, P.FECHA) = 2 THEN 'Ma'
        WHEN DATEPART(WEEKDAY, P.FECHA) = 3 THEN 'Mi'
        WHEN DATEPART(WEEKDAY, P.FECHA) = 4 THEN 'J'
        WHEN DATEPART(WEEKDAY, P.FECHA) = 5 THEN 'V'
        WHEN DATEPART(WEEKDAY, P.FECHA) = 6 THEN 'S'
        WHEN DATEPART(WEEKDAY, P.FECHA) = 7 THEN 'D' END)
        FROM NO_SE_BAJA_NADIE.pedido P;
END
GO

-- Migrar_Dimension_rango_horario
	CREATE PROCEDURE NO_SE_BAJA_NADIE.Migrar_Dimension_rango_horario
AS
BEGIN
    WITH IntervalosTiempo AS (
        SELECT '8:00 - 10:00' AS Intervalo
        UNION ALL
        SELECT '10:00 - 12:00'
        UNION ALL
        SELECT '12:00 - 14:00'
        UNION ALL
        SELECT '14:00 - 16:00'
        UNION ALL
        SELECT '16:00 - 18:00'
        UNION ALL
        SELECT '18:00 - 20:00'
        UNION ALL
        SELECT '20:00 - 22:00'
        UNION ALL
        SELECT '22:00 - 00:00'
    )
    INSERT INTO NO_SE_BAJA_NADIE.Dimension_rango_horario(RANGO_HORARIO)
    SELECT DISTINCT IT.Intervalo
    FROM IntervalosTiempo IT
    LEFT JOIN NO_SE_BAJA_NADIE.pedido P ON IT.Intervalo =
        CASE
            WHEN DATEPART(HOUR, P.FECHA) >= 8 AND DATEPART(HOUR, P.FECHA) < 10 THEN '8:00 - 10:00'
            WHEN DATEPART(HOUR, P.FECHA) >= 10 AND DATEPART(HOUR, P.FECHA) < 12 THEN '10:00 - 12:00'
            WHEN DATEPART(HOUR, P.FECHA) >= 12 AND DATEPART(HOUR, P.FECHA) < 14 THEN '12:00 - 14:00'
            WHEN DATEPART(HOUR, P.FECHA) >= 14 AND DATEPART(HOUR, P.FECHA) < 16 THEN '14:00 - 16:00'
            WHEN DATEPART(HOUR, P.FECHA) >= 16 AND DATEPART(HOUR, P.FECHA) < 18 THEN '16:00 - 18:00'
            WHEN DATEPART(HOUR, P.FECHA) >= 18 AND DATEPART(HOUR, P.FECHA) < 20 THEN '18:00 - 20:00'
            WHEN DATEPART(HOUR, P.FECHA) >= 20 AND DATEPART(HOUR, P.FECHA) < 22 THEN '20:00 - 22:00'
            WHEN DATEPART(HOUR, P.FECHA) >= 22 THEN '22:00 - 00:00'
        END
  
    LEFT JOIN NO_SE_BAJA_NADIE.envio_mensajeria E ON IT.Intervalo =
        CASE
            WHEN DATEPART(HOUR, E.FECHA) >= 8 AND DATEPART(HOUR, E.FECHA) < 10 THEN '8:00 - 10:00'
            WHEN DATEPART(HOUR, E.FECHA) >= 10 AND DATEPART(HOUR, E.FECHA) < 12 THEN '10:00 - 12:00'
            WHEN DATEPART(HOUR, E.FECHA) >= 12 AND DATEPART(HOUR, E.FECHA) < 14 THEN '12:00 - 14:00'
            WHEN DATEPART(HOUR, E.FECHA) >= 14 AND DATEPART(HOUR, E.FECHA) < 16 THEN '14:00 - 16:00'
            WHEN DATEPART(HOUR, E.FECHA) >= 16 AND DATEPART(HOUR, E.FECHA) < 18 THEN '16:00 - 18:00'
            WHEN DATEPART(HOUR, E.FECHA) >= 18 AND DATEPART(HOUR, E.FECHA) < 20 THEN '18:00 - 20:00'
            WHEN DATEPART(HOUR, E.FECHA) >= 20 AND DATEPART(HOUR, E.FECHA) < 22 THEN '20:00 - 22:00'
            WHEN DATEPART(HOUR, E.FECHA) >= 22 THEN '22:00 - 00:00'
        END
    
    LEFT JOIN NO_SE_BAJA_NADIE.reclamo R ON IT.Intervalo =
        CASE
            WHEN DATEPART(HOUR, R.FECHA) >= 8 AND DATEPART(HOUR, R.FECHA) < 10 THEN '8:00 - 10:00'
            WHEN DATEPART(HOUR, R.FECHA) >= 10 AND DATEPART(HOUR, R.FECHA) < 12 THEN '10:00 - 12:00'
            WHEN DATEPART(HOUR, R.FECHA) >= 12 AND DATEPART(HOUR, R.FECHA) < 14 THEN '12:00 - 14:00'
            WHEN DATEPART(HOUR, R.FECHA) >= 14 AND DATEPART(HOUR, R.FECHA) < 16 THEN '14:00 - 16:00'
            WHEN DATEPART(HOUR, R.FECHA) >= 16 AND DATEPART(HOUR, R.FECHA) < 18 THEN '16:00 - 18:00'
            WHEN DATEPART(HOUR, R.FECHA) >= 18 AND DATEPART(HOUR, R.FECHA) < 20 THEN '18:00 - 20:00'
            WHEN DATEPART(HOUR, R.FECHA) >= 20 AND DATEPART(HOUR, R.FECHA) < 22 THEN '20:00 - 22:00'
            WHEN DATEPART(HOUR, R.FECHA) >= 22 THEN '22:00 - 00:00'
        END
    
    LEFT JOIN NO_SE_BAJA_NADIE.horario_local H ON IT.Intervalo =
        CASE
            WHEN DATEPART(HOUR, H.HORA_APERTURA) >= 8 AND DATEPART(HOUR, H.HORA_APERTURA) < 10 THEN '8:00 - 10:00'
            WHEN DATEPART(HOUR, H.HORA_APERTURA) >= 10 AND DATEPART(HOUR, H.HORA_APERTURA) < 12 THEN '10:00 - 12:00'
            WHEN DATEPART(HOUR, H.HORA_APERTURA) >= 12 AND DATEPART(HOUR, H.HORA_APERTURA) < 14 THEN '12:00 - 14:00'
            WHEN DATEPART(HOUR, H.HORA_APERTURA) >= 14 AND DATEPART(HOUR, H.HORA_APERTURA) < 16 THEN '14:00 - 16:00'
            WHEN DATEPART(HOUR, H.HORA_APERTURA) >= 16 AND DATEPART(HOUR, H.HORA_APERTURA) < 18 THEN '16:00 - 18:00'
            WHEN DATEPART(HOUR, H.HORA_APERTURA) >= 18 AND DATEPART(HOUR, H.HORA_APERTURA) < 20 THEN '18:00 - 20:00'
            WHEN DATEPART(HOUR, H.HORA_APERTURA) >= 20 AND DATEPART(HOUR, H.HORA_APERTURA) < 22 THEN '20:00 - 22:00'
            WHEN DATEPART(HOUR, H.HORA_APERTURA) >= 22 THEN '22:00 - 00:00'
        END
        LEFT JOIN NO_SE_BAJA_NADIE.pedido ON IT.Intervalo = 
            CASE
                WHEN DATEPART(HOUR, P.FECHA_ENTREGA) >= 8 AND DATEPART(HOUR, P.FECHA_ENTREGA) < 10 THEN '8:00 - 10:00'
                WHEN DATEPART(HOUR, P.FECHA_ENTREGA) >= 10 AND DATEPART(HOUR, P.FECHA_ENTREGA) < 12 THEN '10:00 - 12:00'
                WHEN DATEPART(HOUR, P.FECHA_ENTREGA) >= 12 AND DATEPART(HOUR, P.FECHA_ENTREGA) < 14 THEN '12:00 - 14:00'
                WHEN DATEPART(HOUR, P.FECHA_ENTREGA) >= 14 AND DATEPART(HOUR, P.FECHA_ENTREGA) < 16 THEN '14:00 - 16:00'
                WHEN DATEPART(HOUR, P.FECHA_ENTREGA) >= 16 AND DATEPART(HOUR, P.FECHA_ENTREGA) < 18 THEN '16:00 - 18:00'
                WHEN DATEPART(HOUR, P.FECHA_ENTREGA) >= 18 AND DATEPART(HOUR, P.FECHA_ENTREGA) < 20 THEN '18:00 - 20:00'
                WHEN DATEPART(HOUR, P.FECHA_ENTREGA) >= 20 AND DATEPART(HOUR, P.FECHA_ENTREGA) < 22 THEN '20:00 - 22:00'
                WHEN DATEPART(HOUR, P.FECHA_ENTREGA) >= 22 THEN '22:00 - 00:00'
            END

        LEFT JOIN NO_SE_BAJA_NADIE.envio_mensajeria ON IT.Intervalo = 
            CASE
                WHEN DATEPART(HOUR, E.FECHA_ENTREGA) >= 8 AND DATEPART(HOUR, E.FECHA_ENTREGA) < 10 THEN '8:00 - 10:00'
                WHEN DATEPART(HOUR, E.FECHA_ENTREGA) >= 10 AND DATEPART(HOUR, E.FECHA_ENTREGA) < 12 THEN '10:00 - 12:00'
                WHEN DATEPART(HOUR, E.FECHA_ENTREGA) >= 12 AND DATEPART(HOUR, E.FECHA_ENTREGA) < 14 THEN '12:00 - 14:00'
                WHEN DATEPART(HOUR, E.FECHA_ENTREGA) >= 14 AND DATEPART(HOUR, E.FECHA_ENTREGA) < 16 THEN '14:00 - 16:00'
                WHEN DATEPART(HOUR, E.FECHA_ENTREGA) >= 16 AND DATEPART(HOUR, E.FECHA_ENTREGA) < 18 THEN '16:00 - 18:00'
                WHEN DATEPART(HOUR, E.FECHA_ENTREGA) >= 18 AND DATEPART(HOUR, E.FECHA_ENTREGA) < 20 THEN '18:00 - 20:00'
                WHEN DATEPART(HOUR, E.FECHA_ENTREGA) >= 20 AND DATEPART(HOUR, E.FECHA_ENTREGA) < 22 THEN '20:00 - 22:00'
                WHEN DATEPART(HOUR, E.FECHA_ENTREGA) >= 22 THEN '22:00 - 00:00'
            END

        LEFT JOIN NO_SE_BAJA_NADIE.reclamo ON IT.Intervalo = 
            CASE
                WHEN DATEPART(HOUR, R.FECHA_SOLUCION) >= 8 AND DATEPART(HOUR, R.FECHA_SOLUCION) < 10 THEN '8:00 - 10:00'
                WHEN DATEPART(HOUR, R.FECHA_SOLUCION) >= 10 AND DATEPART(HOUR, R.FECHA_SOLUCION) < 12 THEN '10:00 - 12:00'
                WHEN DATEPART(HOUR, R.FECHA_SOLUCION) >= 12 AND DATEPART(HOUR, R.FECHA_SOLUCION) < 14 THEN '12:00 - 14:00'
                WHEN DATEPART(HOUR, R.FECHA_SOLUCION) >= 14 AND DATEPART(HOUR, R.FECHA_SOLUCION) < 16 THEN '14:00 - 16:00'
                WHEN DATEPART(HOUR, R.FECHA_SOLUCION) >= 16 AND DATEPART(HOUR, R.FECHA_SOLUCION) < 18 THEN '16:00 - 18:00'
                WHEN DATEPART(HOUR, R.FECHA_SOLUCION) >= 18 AND DATEPART(HOUR, R.FECHA_SOLUCION) < 20 THEN '18:00 - 20:00'
                WHEN DATEPART(HOUR, R.FECHA_SOLUCION) >= 20 AND DATEPART(HOUR, R.FECHA_SOLUCION) < 22 THEN '20:00 - 22:00'
                WHEN DATEPART(HOUR, R.FECHA_SOLUCION) >= 22 THEN '22:00 - 00:00'
            END

        LEFT JOIN NO_SE_BAJA_NADIE.horario_local ON IT.Intervalo = 
            CASE
                WHEN DATEPART(HOUR, H.HORA_CIERRE) >= 8 AND DATEPART(HOUR, H.HORA_CIERRE) < 10 THEN '8:00 - 10:00'
                WHEN DATEPART(HOUR, H.HORA_CIERRE) >= 10 AND DATEPART(HOUR, H.HORA_CIERRE) < 12 THEN '10:00 - 12:00'
                WHEN DATEPART(HOUR, H.HORA_CIERRE) >= 12 AND DATEPART(HOUR, H.HORA_CIERRE) < 14 THEN '12:00 - 14:00'
                WHEN DATEPART(HOUR, H.HORA_CIERRE) >= 14 AND DATEPART(HOUR, H.HORA_CIERRE) < 16 THEN '14:00 - 16:00'
                WHEN DATEPART(HOUR, H.HORA_CIERRE) >= 16 AND DATEPART(HOUR, H.HORA_CIERRE) < 18 THEN '16:00 - 18:00'
                WHEN DATEPART(HOUR, H.HORA_CIERRE) >= 18 AND DATEPART(HOUR, H.HORA_CIERRE) < 20 THEN '18:00 - 20:00'
                WHEN DATEPART(HOUR, H.HORA_CIERRE) >= 20 AND DATEPART(HOUR, H.HORA_CIERRE) < 22 THEN '20:00 - 22:00'
                WHEN DATEPART(HOUR, H.HORA_CIERRE) >= 22 THEN '22:00 - 00:00'
            END

END
GO  
-- Migrar_Dimension_localidad
  CREATE PROCEDURE NO_SE_BAJA_NADIE.Migrar_Dimension_localidad
    AS
    BEGIN
        INSERT INTO NO_SE_BAJA_NADIE.Dimension_localidad(LOCALIDAD_DESCRIPCION)
        SELECT LOCALIDAD 
		FROM NO_SE_BAJA_NADIE.localidad
END
GO

-- Migrar rango etario usuario
CREATE PROCEDURE NO_SE_BAJA_NADIE.Migrar_Dimension_rango_etario_usuario
AS
BEGIN
    INSERT INTO NO_SE_BAJA_NADIE.Dimension_rango_etario_usuario(RANGO_ETARIO_USUARIO)
    SELECT DISTINCT
        CASE
            WHEN DATEDIFF(YEAR, U.FECHA_NAC, CONVERT(DATE, GETDATE())) < 25 THEN '<25'
            WHEN DATEDIFF(YEAR, U.FECHA_NAC, CONVERT(DATE, GETDATE())) BETWEEN 25 AND 35 THEN '25-35'
            WHEN DATEDIFF(YEAR, U.FECHA_NAC, CONVERT(DATE, GETDATE())) BETWEEN 35 AND 55 THEN '35-55'
            WHEN DATEDIFF(YEAR, U.FECHA_NAC, CONVERT(DATE, GETDATE())) > 55 THEN '>55'
        END
    FROM NO_SE_BAJA_NADIE.usuario U

END
GO

-- Migrar Rango etario de Repartidor
 CREATE PROCEDURE NO_SE_BAJA_NADIE.Migrar_Dimension_rango_etario_repartidor
AS
BEGIN
    INSERT INTO NO_SE_BAJA_NADIE.Dimension_rango_etario_repartidor(RANGO_ETARIO_REPARTIDOR)
    SELECT DISTINCT
        CASE
            WHEN DATEDIFF(YEAR, R.FECHA_NAC, CONVERT(DATE, GETDATE())) < 25 THEN '<25'
            WHEN DATEDIFF(YEAR, R.FECHA_NAC, CONVERT(DATE, GETDATE())) BETWEEN 25 AND 35 THEN '25-35'
            WHEN DATEDIFF(YEAR, R.FECHA_NAC, CONVERT(DATE, GETDATE())) BETWEEN 35 AND 55 THEN '35-55'
            WHEN DATEDIFF(YEAR, R.FECHA_NAC, CONVERT(DATE, GETDATE())) > 55 THEN '>55'
        END
    FROM NO_SE_BAJA_NADIE.repartidor R

END
GO
-- Migrar rango etario de Operador
CREATE PROCEDURE NO_SE_BAJA_NADIE.Migrar_Dimension_rango_etario_operador
AS
BEGIN
    INSERT INTO NO_SE_BAJA_NADIE.Dimension_rango_etario_operador(RANGO_ETARIO_OPERADOR)
    SELECT DISTINCT
        CASE
            WHEN DATEDIFF(YEAR, O.FECHA_NAC, CONVERT(DATE, GETDATE())) < 25 THEN '<25'
            WHEN DATEDIFF(YEAR, O.FECHA_NAC, CONVERT(DATE, GETDATE())) BETWEEN 25 AND 35 THEN '25-35'
            WHEN DATEDIFF(YEAR, O.FECHA_NAC, CONVERT(DATE, GETDATE())) BETWEEN 35 AND 55 THEN '35-55'
            WHEN DATEDIFF(YEAR, O.FECHA_NAC, CONVERT(DATE, GETDATE())) > 55 THEN '>55'
        END
    FROM NO_SE_BAJA_NADIE.operador_reclamo O

END
GO

-- Migrar_Dimension_tipo_medio_pago
    CREATE PROCEDURE NO_SE_BAJA_NADIE.Migrar_Dimension_tipo_medio_pago
    AS
    BEGIN
        INSERT INTO NO_SE_BAJA_NADIE.Dimension_medio_de_pago_tipo(MEDIO_PAGO_TIPO)
        SELECT DISTINCT TIPO 
		FROM NO_SE_BAJA_NADIE.medio_pago
END
GO

-- Migrar_Dimension_local
    CREATE PROCEDURE NO_SE_BAJA_NADIE.Migrar_Dimension_local
    AS
    BEGIN
        INSERT INTO NO_SE_BAJA_NADIE.Dimension_local(LOCAL_DESCRIPCION)
        SELECT DESCRIPCION 
		FROM NO_SE_BAJA_NADIE.local
END
GO

-- Migrar_Dimension_tipo_local
    CREATE PROCEDURE NO_SE_BAJA_NADIE.Migrar_Dimension_tipo_local
    AS
    BEGIN
        INSERT INTO NO_SE_BAJA_NADIE.Dimension_tipo_local(TIPO_LOCAL_DESCRIPCION)
        SELECT TIPO 
		FROM NO_SE_BAJA_NADIE.local_tipo
END
GO

-- Migrar_Dimension_categoria_local
    CREATE PROCEDURE NO_SE_BAJA_NADIE.Migrar_Dimension_categoria_local
    AS
    BEGIN
        INSERT INTO NO_SE_BAJA_NADIE.Dimension_categoria_local(LOCAL_TIPO_ID, CATEGORIA_DESCRIPCION)
        SELECT LOCAL_TIPO_ID, CATEGORIA 
		FROM NO_SE_BAJA_NADIE.local_categoria

END
GO

-- Migrar_Dimension_tipo_movilidad
    CREATE PROCEDURE NO_SE_BAJA_NADIE.Migrar_Dimension_tipo_movilidad
    AS
    BEGIN
        INSERT INTO NO_SE_BAJA_NADIE.Dimension_tipo_movilidad(TIPO_MOVILIDAD_NOMBRE)
        SELECT NOMBRE 
		FROM NO_SE_BAJA_NADIE.tipo_movilidad
        END
        GO

-- Migrar_Dimension_tipo_paquete
    CREATE PROCEDURE NO_SE_BAJA_NADIE.Migrar_Dimension_tipo_paquete
    AS
    BEGIN
        INSERT INTO NO_SE_BAJA_NADIE.Dimension_tipo_paquete(TIPO_PAQUETE_DESCRIPCION, PRECIO_PAQUETE)
        SELECT TIPO, PRECIO 
		FROM NO_SE_BAJA_NADIE.paquete_tipo

        END
        GO

-- Migrar_Dimension_estado_pedido
    CREATE PROCEDURE NO_SE_BAJA_NADIE.Migrar_Dimension_estado_pedido
    AS
    BEGIN
        INSERT INTO NO_SE_BAJA_NADIE.Dimension_estado_pedido(ESTADO_PEDIDO_DESCRIPCION)
        SELECT ESTADO 
		FROM NO_SE_BAJA_NADIE.estado_pedido
        END
        GO

-- Migrar_Dimension_estado_envio_mensajeria
	CREATE PROCEDURE NO_SE_BAJA_NADIE.Migrar_Dimension_estado_envio_mensajeria
	AS
	BEGIN
		INSERT INTO NO_SE_BAJA_NADIE.Dimension_estado_envio_mensajeria(ESTADO_ENVIO_MENSAJERIA_DESCRIPCION)
		SELECT ESTADO 
		FROM NO_SE_BAJA_NADIE.estado_mensajeria

		END
		GO

-- Migrar_Dimension_estado_reclamo
	CREATE PROCEDURE NO_SE_BAJA_NADIE.Migrar_Dimension_estado_reclamo
	AS
	BEGIN
		INSERT INTO NO_SE_BAJA_NADIE.Dimension_estado_reclamo(ESTADO_RECLAMO_DESCRIPCION)
		SELECT ESTADO 
		FROM NO_SE_BAJA_NADIE.estado_reclamo

		END
		GO

-- Migrar_Dimension_tipo_reclamo
	CREATE PROCEDURE NO_SE_BAJA_NADIE.Migrar_Dimension_tipo_reclamo
	AS
	BEGIN
		INSERT INTO NO_SE_BAJA_NADIE.Dimension_tipo_reclamo(TIPO_RECLAMO_DESCRIPCION)
		SELECT TIPO 
		FROM NO_SE_BAJA_NADIE.reclamo_tipo

		END
		GO

-- Migrar_Dimension_cupon_pedido
	CREATE PROCEDURE NO_SE_BAJA_NADIE.Migrar_Dimension_cupon_pedido
	AS
	BEGIN
		INSERT INTO NO_SE_BAJA_NADIE.Dimension_cupon_pedido(ID_CUPON_PEDIDO_NRO, MONTO)
		SELECT CUPON_NRO,MONTO 
		FROM NO_SE_BAJA_NADIE.cupon_pedido

		END
		GO

-- Migrar_Dimension_cupon_reclamo
	CREATE PROCEDURE NO_SE_BAJA_NADIE.Migrar_Dimension_cupon_reclamo
	AS
	BEGIN
		INSERT INTO NO_SE_BAJA_NADIE.Dimension_cupon_reclamo(ID_CUPON_RECLAMO_NRO, MONTO)
		SELECT CUPON_NRO, MONTO 
		FROM NO_SE_BAJA_NADIE.cupon_por_reclamo

		END
		GO

-- Migrar_Hechos_pedidos
	CREATE PROCEDURE NO_SE_BAJA_NADIE.Migrar_Hechos_pedidos
	AS
	BEGIN
		INSERT INTO NO_SE_BAJA_NADIE.Hechos_pedidos(ID_TIEMPO, ID_DIA, ID_RANGO_HORARIO, ID_LOCALIDAD, ID_RANGO_ETARIO_USUARIO,ID_RANGO_ETARIO_REPARTIDOR, ID_MEDIO_PAGO_TIPO, 
		ID_LOCAL,ID_TIPO_LOCAL, ID_CATEGORIA_LOCAL, ID_TIPO_MOVILIDAD, ID_ESTADO_PEDIDO, ID_CUPON_PEDIDO, CANTIDAD_PEDIDOS, VALOR_PROMEDIO_ENVIO, TOTAL, DESVIO_MINUTOS, PROMEDIO_CALIFICACION)
		SELECT 
		t.ID,
		d.ID,
		rh.ID,
		l3.ID,
		reu.ID,
		rer.ID,
		mpt.ID,
		l1.ID,
		tl.ID,
		cl.ID,
		tm.ID,
		ep.ID,
		cp2.ID,
		COUNT(*),
		AVG(p.PRECIO_ENVIO),
		SUM((p.TOTAL_PRODUCTOS + p.PRECIO_ENVIO + p.PROPINA + p.TARIFA_SERVICIO) - p.TOTAL_CUPONES),
		ABS(DATEDIFF(MINUTE, p.FECHA, p.FECHA_ENTREGA) - p.TIEMPO_ESTIMADO_ENTREGA),
		AVG(p.CALIFICACION) 
		FROM NO_SE_BAJA_NADIE.pedido p
		JOIN NO_SE_BAJA_NADIE.Dimension_estado_pedido ep ON ep.ID = p.ESTADO_PEDIDO_ID
		JOIN NO_SE_BAJA_NADIE.Dimension_local l1 ON l1.id = p.LOCAL_COD
		JOIN NO_SE_BAJA_NADIE.Dimension_tiempo t ON (t.ANIO = YEAR(p.FECHA_ENTREGA) AND t.MES = MONTH(p.FECHA_ENTREGA))
		JOIN NO_SE_BAJA_NADIE.Dimension_rango_horario rh ON (rh.RANGO_HORARIO = (CASE WHEN DATEPART(HOUR, P.FECHA) between 8 AND 10 THEN '8:00 - 10:00'
		WHEN DATEPART(HOUR, P.FECHA) between 10 AND 12 THEN '10:00 - 12:00'
		WHEN DATEPART(HOUR, P.FECHA) between 12 AND 14 THEN '12:00 - 14:00'
		WHEN DATEPART(HOUR, P.FECHA) between 14 AND 16 THEN '14:00 - 16:00'
		WHEN DATEPART(HOUR, P.FECHA) between 16 AND 18 THEN '16:00 - 18:00'
		WHEN DATEPART(HOUR, P.FECHA) between 18 AND 20 THEN '18:00 - 20:00'
		WHEN DATEPART(HOUR, P.FECHA) between 20 AND 22 THEN '20:00 - 22:00'
		WHEN DATEPART(HOUR, P.FECHA) > 22 THEN '22:00 - 00:00' END))
		JOIN NO_SE_BAJA_NADIE.Dimension_dia d ON (d.DIA_SEMANA =(CASE 
        WHEN DATEPART(WEEKDAY, P.FECHA) = 1 THEN 'L'
        WHEN DATEPART(WEEKDAY, P.FECHA) = 2 THEN 'Ma'
        WHEN DATEPART(WEEKDAY, P.FECHA) = 3 THEN 'Mi'
        WHEN DATEPART(WEEKDAY, P.FECHA) = 4 THEN 'J'
        WHEN DATEPART(WEEKDAY, P.FECHA) = 5 THEN 'V'
        WHEN DATEPART(WEEKDAY, P.FECHA) = 6 THEN 'S'
        WHEN DATEPART(WEEKDAY, P.FECHA) = 7 THEN 'D' END))
		JOIN NO_SE_BAJA_NADIE.usuario u ON p.USUARIO_ID = u.USUARIO_ID
		JOIN NO_SE_BAJA_NADIE.Dimension_rango_etario_usuario reu ON (reu.RANGO_ETARIO_USUARIO =  (CASE
            WHEN DATEDIFF(YEAR, U.FECHA_NAC, CONVERT(DATE, GETDATE())) < 25 THEN '<25'
            WHEN DATEDIFF(YEAR, U.FECHA_NAC, CONVERT(DATE, GETDATE())) BETWEEN 25 AND 35 THEN '25-35'
            WHEN DATEDIFF(YEAR, U.FECHA_NAC, CONVERT(DATE, GETDATE())) BETWEEN 35 AND 55 THEN '35-55'
            WHEN DATEDIFF(YEAR, U.FECHA_NAC, CONVERT(DATE, GETDATE())) > 55 THEN '>55'
        END))
		JOIN NO_SE_BAJA_NADIE.local l2 ON l2.LOCAL_COD = p.LOCAL_COD 
		JOIN NO_SE_BAJA_NADIE.Dimension_tipo_local tl ON tl.ID = l2.LOCAL_TIPO_ID
		JOIN NO_SE_BAJA_NADIE.Dimension_categoria_local cl ON tl.ID = cl.LOCAL_TIPO_ID
		JOIN NO_SE_BAJA_NADIE.Dimension_localidad l3 ON l3.ID = l2.LOCALIDAD_COD
		JOIN NO_SE_BAJA_NADIE.repartidor r ON r.LOCALIDAD_COD = l3.ID
		JOIN NO_SE_BAJA_NADIE.Dimension_rango_etario_repartidor rer ON (rer.RANGO_ETARIO_REPARTIDOR =  (CASE
            WHEN DATEDIFF(YEAR, r.FECHA_NAC, CONVERT(DATE, GETDATE())) < 25 THEN '<25'
            WHEN DATEDIFF(YEAR, r.FECHA_NAC, CONVERT(DATE, GETDATE())) BETWEEN 25 AND 35 THEN '25-35'
            WHEN DATEDIFF(YEAR, r.FECHA_NAC, CONVERT(DATE, GETDATE())) BETWEEN 35 AND 55 THEN '35-55'
            WHEN DATEDIFF(YEAR, r.FECHA_NAC, CONVERT(DATE, GETDATE())) > 55 THEN '>55'
        END))
		JOIN NO_SE_BAJA_NADIE.Dimension_tipo_movilidad tm ON tm.ID = r.TIPO_MOVILIDAD_ID
		JOIN NO_SE_BAJA_NADIE.medio_pago mp ON p.MEDIO_PAGO_ID = mp.MEDIO_PAGO_ID
		JOIN NO_SE_BAJA_NADIE.Dimension_medio_de_pago_tipo mpt ON mpt.MEDIO_PAGO_TIPO = mp.TIPO
		JOIN NO_SE_BAJA_NADIE.cupon_pedido cp1 ON cp1.PEDIDO_NRO = p.PEDIDO_NRO
		JOIN NO_SE_BAJA_NADIE.Dimension_cupon_pedido cp2 ON cp2.ID_CUPON_PEDIDO_NRO = cp1.CUPON_NRO
		group by t.ID,d.ID,rh.ID,l3.ID,reu.ID,rer.ID,mpt.ID,l1.ID,tl.ID,cl.ID,tm.ID,ep.ID,cp2.ID, p.FECHA, p.FECHA_ENTREGA, p.TIEMPO_ESTIMADO_ENTREGA
		END
		GO

-- Migrar_Hechos_envio_mensajeria
	CREATE PROCEDURE NO_SE_BAJA_NADIE.Migrar_Hechos_envio_mensajeria
	AS
	BEGIN
		INSERT INTO NO_SE_BAJA_NADIE.Hechos_envio_mensajeria(ID_TIEMPO, ID_DIA, ID_RANGO_HORARIO, ID_LOCALIDAD, 
		ID_RANGO_ETARIO_USUARIO, ID_RANGO_ETARIO_REPARTIDOR, ID_TIPO_MOVILIDAD, ID_TIPO_PAQUETE, ID_ESTADO_ENVIO_MENSAJERIA, CANTIDAD_ENVIOS, PROMEDIO_VALOR_ASEGURADO, TOTAL,
		DESVIO_MINUTOS, PROMEDIO_CALIFICACION)
		SELECT
		t.id,
		d.id,
		rh.id,
		l.id,
		reu.id,
		rer.id,
		tm.id,
		tp.id,
		eem.id,
		COUNT(*),
		AVG(em.VALOR_ASEGURADO),
		SUM(em.PRECIO_SEGURO + em.PRECIO_ENVIO + em.PROPINA),
		ABS(DATEDIFF(MINUTE, em.FECHA, em.FECHA_ENTREGA) - em.TIEMPO_ESTIMADO),
		AVG(em.CALIFICACION)
		FROM NO_SE_BAJA_NADIE.envio_mensajeria em
		JOIN NO_SE_BAJA_NADIE.Dimension_localidad l ON em.LOCALIDAD_COD = l.ID
		JOIN NO_SE_BAJA_NADIE.Dimension_estado_envio_mensajeria eem ON eem.ID =	em.ESTADO_MENSAJERIA_ID
		JOIN NO_SE_BAJA_NADIE.usuario u ON em.USUARIO_ID = u.USUARIO_ID
		JOIN NO_SE_BAJA_NADIE.repartidor r ON em.REPARTIDOR_ID = r.REPARTIDOR_ID
		JOIN NO_SE_BAJA_NADIE.Dimension_rango_etario_usuario reu ON (reu.RANGO_ETARIO_USUARIO = (CASE WHEN DATEDIFF(YEAR, u.FECHA_NAC, CONVERT(DATE, GETDATE())) < 25 THEN '<25'
            WHEN DATEDIFF(YEAR, u.FECHA_NAC, CONVERT(DATE, GETDATE())) BETWEEN 25 AND 35 THEN '25-35'
            WHEN DATEDIFF(YEAR, u.FECHA_NAC, CONVERT(DATE, GETDATE())) BETWEEN 35 AND 55 THEN '35-55'
            WHEN DATEDIFF(YEAR, u.FECHA_NAC, CONVERT(DATE, GETDATE())) > 55 THEN '>55'
			END))
		JOIN NO_SE_BAJA_NADIE.Dimension_rango_etario_repartidor rer ON (rer.RANGO_ETARIO_REPARTIDOR = (CASE WHEN DATEDIFF(YEAR, r.FECHA_NAC, CONVERT(DATE, GETDATE())) < 25 THEN '<25'
            WHEN DATEDIFF(YEAR, r.FECHA_NAC, CONVERT(DATE, GETDATE())) BETWEEN 25 AND 35 THEN '25-35'
            WHEN DATEDIFF(YEAR, r.FECHA_NAC, CONVERT(DATE, GETDATE())) BETWEEN 35 AND 55 THEN '35-55'
            WHEN DATEDIFF(YEAR, r.FECHA_NAC, CONVERT(DATE, GETDATE())) > 55 THEN '>55'
			END))
		JOIN NO_SE_BAJA_NADIE.Dimension_tipo_movilidad tm ON tm.ID = r.REPARTIDOR_ID
		JOIN NO_SE_BAJA_NADIE.Dimension_tiempo t ON (t.ANIO = YEAR(em.FECHA) AND t.MES = MONTH(em.FECHA))
		JOIN NO_SE_BAJA_NADIE.Dimension_dia d  ON (d.DIA_SEMANA =(CASE 
        WHEN DATEPART(WEEKDAY, em.FECHA) = 1 THEN 'L'
        WHEN DATEPART(WEEKDAY, em.FECHA) = 2 THEN 'Ma'
        WHEN DATEPART(WEEKDAY, em.FECHA) = 3 THEN 'Mi'
        WHEN DATEPART(WEEKDAY, em.FECHA) = 4 THEN 'J'
        WHEN DATEPART(WEEKDAY, em.FECHA) = 5 THEN 'V'
        WHEN DATEPART(WEEKDAY, em.FECHA) = 6 THEN 'S'
        WHEN DATEPART(WEEKDAY, em.FECHA) = 7 THEN 'D' END))
		JOIN NO_SE_BAJA_NADIE.Dimension_rango_horario rh ON (rh.RANGO_HORARIO = (CASE WHEN DATEPART(HOUR, em.FECHA) between 8 AND 10 THEN '8:00 - 10:00'
		WHEN DATEPART(HOUR, em.FECHA) between 10 AND 12 THEN '10:00 - 12:00'
		WHEN DATEPART(HOUR, em.FECHA) between 12 AND 14 THEN '12:00 - 14:00'
		WHEN DATEPART(HOUR, em.FECHA) between 14 AND 16 THEN '14:00 - 16:00'
		WHEN DATEPART(HOUR, em.FECHA) between 16 AND 18 THEN '16:00 - 18:00'
		WHEN DATEPART(HOUR, em.FECHA) between 18 AND 20 THEN '18:00 - 20:00'
		WHEN DATEPART(HOUR, em.FECHA) between 20 AND 22 THEN '20:00 - 22:00'
		WHEN DATEPART(HOUR, em.FECHA) > 22 THEN '22:00 - 00:00' END))
		JOIN NO_SE_BAJA_NADIE.paquete p ON p.PAQUETE_ID = em.PAQUETE_ID
		JOIN NO_SE_BAJA_NADIE.Dimension_tipo_paquete tp ON tp.ID = p.TIPO_ID
		group by t.id,d.id,rh.id, l.id,reu.id, rer.id, tm.id,tp.id,eem.id,em.FECHA, em.FECHA_ENTREGA, em.TIEMPO_ESTIMADO
		END
		GO
-- Migrar_Hechos_reclamo
	CREATE PROCEDURE NO_SE_BAJA_NADIE.Migrar_Hechos_reclamo
	AS
	BEGIN
		INSERT INTO NO_SE_BAJA_NADIE.Hechos_reclamo(ID_TIEMPO, ID_DIA, ID_RANGO_HORARIO, ID_LOCAL, ID_RANGO_ETARIO_OPERADOR, ID_ESTADO_RECLAMO, ID_TIPO_RECLAMO,
		ID_CUPON_RECLAMO, CANTIDAD_RECLAMOS, TIEMPO_RESOLUCION_MINUTOS, PROMEDIO_CALIFICACION)
		SELECT
		t.ID,
		d.ID,
		rh.ID,
		l.ID,
		reo.ID,
		er.ID,
		tr.ID,
		cr2.id,
		COUNT(*),
		DATEDIFF(MINUTE, r.FECHA, r.FECHA_SOLUCION),
		AVG(r.CALIFICACION)
		FROM NO_SE_BAJA_NADIE.reclamo r
		JOIN NO_SE_BAJA_NADIE.Dimension_estado_reclamo er ON er.ID = r.ESTADO_RECLAMO_ID
		JOIN NO_SE_BAJA_NADIE.Dimension_tipo_reclamo tr ON tr.ID = r.RECLAMO_TIPO_ID
		JOIN NO_SE_BAJA_NADIE.Dimension_tiempo t ON (t.ANIO = YEAR(r.FECHA) AND t.MES = MONTH(r.FECHA)) 
		JOIN NO_SE_BAJA_NADIE.Dimension_dia d  ON (d.DIA_SEMANA =(CASE 
        WHEN DATEPART(WEEKDAY, r.FECHA) = 1 THEN 'L'
        WHEN DATEPART(WEEKDAY, r.FECHA) = 2 THEN 'Ma'
        WHEN DATEPART(WEEKDAY, r.FECHA) = 3 THEN 'Mi'
        WHEN DATEPART(WEEKDAY, r.FECHA) = 4 THEN 'J'
        WHEN DATEPART(WEEKDAY, r.FECHA) = 5 THEN 'V'
        WHEN DATEPART(WEEKDAY, r.FECHA) = 6 THEN 'S'
        WHEN DATEPART(WEEKDAY, r.FECHA) = 7 THEN 'D' END))
		JOIN NO_SE_BAJA_NADIE.Dimension_rango_horario rh ON (rh.RANGO_HORARIO = (CASE WHEN DATEPART(HOUR, r.FECHA) between 8 AND 10 THEN '8:00 - 10:00'
		WHEN DATEPART(HOUR, r.FECHA) between 10 AND 12 THEN '10:00 - 12:00'
		WHEN DATEPART(HOUR, r.FECHA) between 12 AND 14 THEN '12:00 - 14:00'
		WHEN DATEPART(HOUR, r.FECHA) between 14 AND 16 THEN '14:00 - 16:00'
		WHEN DATEPART(HOUR, r.FECHA) between 16 AND 18 THEN '16:00 - 18:00'
		WHEN DATEPART(HOUR, r.FECHA) between 18 AND 20 THEN '18:00 - 20:00'
		WHEN DATEPART(HOUR, r.FECHA) between 20 AND 22 THEN '20:00 - 22:00'
		WHEN DATEPART(HOUR, r.FECHA) > 22 THEN '22:00 - 00:00' END))
		JOIN NO_SE_BAJA_NADIE.pedido p ON p.PEDIDO_NRO = r.PEDIDO_NRO
		JOIN NO_SE_BAJA_NADIE.Dimension_local l ON l.ID = p.LOCAL_COD
		JOIN NO_SE_BAJA_NADIE.operador_reclamo o ON r.OPERADOR_RECLAMO_ID = o.OPERADOR_RECLAMO_ID
		JOIN NO_SE_BAJA_NADIE.Dimension_rango_etario_operador reo ON (reo.RANGO_ETARIO_OPERADOR = (CASE
            WHEN DATEDIFF(YEAR, o.FECHA_NAC, CONVERT(DATE, GETDATE())) < 25 THEN '<25'
            WHEN DATEDIFF(YEAR, o.FECHA_NAC, CONVERT(DATE, GETDATE())) BETWEEN 25 AND 35 THEN '25-35'
            WHEN DATEDIFF(YEAR, o.FECHA_NAC, CONVERT(DATE, GETDATE())) BETWEEN 35 AND 55 THEN '35-55'
            WHEN DATEDIFF(YEAR, o.FECHA_NAC, CONVERT(DATE, GETDATE())) > 55 THEN '>55'
        END))
		JOIN NO_SE_BAJA_NADIE.cupon_por_reclamo cr1 ON cr1.RECLAMO_NRO = r.RECLAMO_NRO
		JOIN NO_SE_BAJA_NADIE.Dimension_cupon_reclamo cr2 ON cr2.id_cupon_reclamo_nro = cr1.CUPON_NRO
		GROUP BY t.ID, d.ID, rh.ID, l.ID, reo.ID, er.ID, tr.ID, cr2.id,r.FECHA, r.FECHA_SOLUCION
		END
		GO

PRINT '**** Stored Procedures creados correctamente ****';

GO

/********* Ejecucion de StoredProcedures para migracion *********/

--Tablas sin FKs

	EXECUTE NO_SE_BAJA_NADIE.Migrar_Dimension_tiempo;
	EXECUTE NO_SE_BAJA_NADIE.Migrar_Dimension_dia;
	EXECUTE NO_SE_BAJA_NADIE.Migrar_Dimension_rango_horario;
	EXECUTE NO_SE_BAJA_NADIE.Migrar_Dimension_localidad;
	EXECUTE NO_SE_BAJA_NADIE.Migrar_Dimension_rango_etario_usuario;
	EXECUTE NO_SE_BAJA_NADIE.Migrar_Dimension_rango_etario_repartidor;
	EXECUTE NO_SE_BAJA_NADIE.Migrar_Dimension_rango_etario_operador;
	EXECUTE NO_SE_BAJA_NADIE.Migrar_Dimension_tipo_medio_pago;
	EXECUTE NO_SE_BAJA_NADIE.Migrar_Dimension_local;
	EXECUTE NO_SE_BAJA_NADIE.Migrar_Dimension_tipo_local;
	EXECUTE NO_SE_BAJA_NADIE.Migrar_Dimension_tipo_movilidad;
	EXECUTE NO_SE_BAJA_NADIE.Migrar_Dimension_tipo_paquete;
	EXECUTE NO_SE_BAJA_NADIE.Migrar_Dimension_estado_pedido;
	EXECUTE NO_SE_BAJA_NADIE.Migrar_Dimension_estado_envio_mensajeria;
	EXECUTE NO_SE_BAJA_NADIE.Migrar_Dimension_estado_reclamo;
	EXECUTE NO_SE_BAJA_NADIE.Migrar_Dimension_tipo_reclamo;
	EXECUTE NO_SE_BAJA_NADIE.Migrar_Dimension_cupon_pedido;
	EXECUTE NO_SE_BAJA_NADIE.Migrar_Dimension_cupon_reclamo;

--Tablas con FKs a tablas sin FKs
	EXECUTE NO_SE_BAJA_NADIE.Migrar_Dimension_categoria_local; 

--Tablas con FKs a tablas con FKs
	EXECUTE NO_SE_BAJA_NADIE.Migrar_Hechos_pedidos;
	EXECUTE NO_SE_BAJA_NADIE.Migrar_Hechos_envio_mensajeria;
	EXECUTE NO_SE_BAJA_NADIE.Migrar_Hechos_reclamo;

	PRINT 'Tablas BI migradas correctamente.';

/*
/********* Pruebas Vistas *********/
SELECT * FROM NO_SE_BAJA_NADIE.v_BI_Mayor_cantidad_pedidos_mensualmente
ORDER BY CANTIDAD_PEDIDOS DESC;

SELECT * FROM NO_SE_BAJA_NADIE.v_BI_Monto_perdido_cancelacion

SELECT * FROM NO_SE_BAJA_NADIE.v_BI_Valor_promedio_mensual 

SELECT * FROM NO_SE_BAJA_NADIE.v_BI_Desvio_promedio_tiempo_entrega

SELECT * FROM NO_SE_BAJA_NADIE.v_BI_Monto_cupones_utilizados_mensualmente

SELECT * FROM NO_SE_BAJA_NADIE.v_BI_Promedio_calificacion_mensual_local

SELECT * FROM NO_SE_BAJA_NADIE.v_BI_Promedio_mensual_valor_asegurado_paquetes 

SELECT * FROM NO_SE_BAJA_NADIE.v_BI_Cantidad_reclamos_mensuales_local 

SELECT * FROM NO_SE_BAJA_NADIE.v_BI_Tiempo_promedio_resolucion_reclamos_mensualmente 

SELECT * FROM NO_SE_BAJA_NADIE.v_BI_Monto_mensual_cupones_reclamos

SELECT * FROM NO_SE_BAJA_NADIE.v_BI_Promedio_entregados_mensualmente

*/


