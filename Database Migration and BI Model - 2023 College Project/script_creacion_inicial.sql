USE [GD1C2023]
GO

PRINT '**** Comenzando Migración  ****';

GO

DECLARE @DropConstraints NVARCHAR(max) = ''

SELECT @DropConstraints += 'ALTER TABLE ' + QUOTENAME(OBJECT_SCHEMA_NAME(parent_object_id)) + '.'

                        +  QUOTENAME(OBJECT_NAME(parent_object_id)) + ' ' + 'DROP CONSTRAINT' + QUOTENAME(name)

FROM sys.foreign_keys

EXECUTE sp_executesql @DropConstraints;

PRINT '**** CONSTRAINTs dropeadas correctamente ****';

GO

DECLARE @DropTables NVARCHAR(max) = ''

SELECT @DropTables += 'DROP TABLE NO_SE_BAJA_NADIE. ' + QUOTENAME(TABLE_NAME)

FROM INFORMATION_SCHEMA.TABLES

WHERE TABLE_SCHEMA = 'NO_SE_BAJA_NADIE' and TABLE_TYPE = 'BASE TABLE'

EXECUTE sp_executesql @DropTables;

PRINT '**** TABLAS dropeadas correctamente ****';

GO

/********* Drop de Stored Procedures *********/
IF EXISTS (SELECT name FROM sys.procedures WHERE name = 'Migrar_estados_reclamos')
DROP PROCEDURE NO_SE_BAJA_NADIE.Migrar_estados_reclamos;
GO

IF EXISTS (SELECT name FROM sys.procedures WHERE name = 'Migrar_reclamos_tipos')	
DROP PROCEDURE NO_SE_BAJA_NADIE.Migrar_reclamos_tipos;
GO

IF EXISTS (SELECT name FROM sys.procedures WHERE name = 'Migrar_Operadores')
DROP PROCEDURE NO_SE_BAJA_NADIE.Migrar_Operadores;
GO

IF EXISTS (SELECT name FROM sys.procedures WHERE name = 'Migrar_estados_mensajería')
DROP PROCEDURE NO_SE_BAJA_NADIE.Migrar_estados_mensajería
GO

IF EXISTS (SELECT name FROM sys.procedures WHERE name = 'Migrar_paquetes_tipos')
DROP PROCEDURE NO_SE_BAJA_NADIE.Migrar_paquetes_tipos;
GO

IF EXISTS (SELECT name FROM sys.procedures WHERE name = 'Migrar_paquetes')
DROP PROCEDURE NO_SE_BAJA_NADIE.Migrar_paquetes;
GO

IF EXISTS (SELECT name FROM sys.procedures WHERE name = 'Migrar_Productos_Pedidos')
DROP PROCEDURE NO_SE_BAJA_NADIE.Migrar_Productos_Pedidos;
GO

IF EXISTS (SELECT name FROM sys.procedures WHERE name = 'Migrar_estados_pedidos')
DROP PROCEDURE NO_SE_BAJA_NADIE.Migrar_estados_pedidos;
GO

IF EXISTS (SELECT name FROM sys.procedures WHERE name = 'Migrar_dias')
DROP PROCEDURE NO_SE_BAJA_NADIE.Migrar_dias;
GO

IF EXISTS (SELECT name FROM sys.procedures WHERE name = 'Migrar_Horario_Local')
DROP PROCEDURE NO_SE_BAJA_NADIE.Migrar_Horario_Local;
GO

IF EXISTS (SELECT name FROM sys.procedures WHERE name = 'Migrar_Tipo_Locales')
DROP PROCEDURE NO_SE_BAJA_NADIE.Migrar_Tipo_Locales;
GO

IF EXISTS (SELECT name FROM sys.procedures WHERE name = 'Migrar_Categorias_Locales')
DROP PROCEDURE NO_SE_BAJA_NADIE.Migrar_Categorias_Locales;
GO

IF EXISTS (SELECT name FROM sys.procedures WHERE name = 'Migrar_Tipo_Movilidades')
DROP PROCEDURE NO_SE_BAJA_NADIE.Migrar_Tipo_Movilidades;
GO

IF EXISTS (SELECT name FROM sys.procedures WHERE name = 'Migrar_Direcciones_Usuarios')
DROP PROCEDURE NO_SE_BAJA_NADIE.Migrar_Direcciones_Usuarios;
GO

IF EXISTS (SELECT name FROM sys.procedures WHERE name = 'Migrar_Medio_Pagos')
DROP PROCEDURE NO_SE_BAJA_NADIE.Migrar_Medio_Pagos;
GO

IF EXISTS (SELECT name FROM sys.procedures WHERE name = 'Migrar_Repartidores')
DROP PROCEDURE NO_SE_BAJA_NADIE.Migrar_Repartidores;
GO

IF EXISTS (SELECT name FROM sys.procedures WHERE name = 'Migrar_Envio_Mensajerias')
DROP PROCEDURE NO_SE_BAJA_NADIE.Migrar_Envio_Mensajerias;
GO

IF EXISTS (SELECT name FROM sys.procedures WHERE name = 'Migrar_Local')
DROP PROCEDURE NO_SE_BAJA_NADIE.Migrar_Local;
GO

IF EXISTS (SELECT name FROM sys.procedures WHERE name = 'Migrar_MediosDePagoTarjeta')
DROP PROCEDURE NO_SE_BAJA_NADIE.Migrar_MediosDePagoTarjeta;
GO

IF EXISTS (SELECT name FROM sys.procedures WHERE name = 'Migrar_Localidades')
DROP PROCEDURE NO_SE_BAJA_NADIE.Migrar_Localidades;
GO

IF EXISTS (SELECT name FROM sys.procedures WHERE name = 'Migrar_Productos_Locales')
DROP PROCEDURE NO_SE_BAJA_NADIE.Migrar_Productos_Locales;
GO

IF EXISTS (SELECT name FROM sys.procedures WHERE name = 'Migrar_TiposCupon')
DROP PROCEDURE NO_SE_BAJA_NADIE.Migrar_TiposCupon;
GO

IF EXISTS (SELECT name FROM sys.procedures WHERE name = 'Migrar_Cupones')
DROP PROCEDURE NO_SE_BAJA_NADIE.Migrar_Cupones;
GO

IF EXISTS (SELECT name FROM sys.procedures WHERE name = 'Migrar_PedidosCupon')
DROP PROCEDURE NO_SE_BAJA_NADIE.Migrar_PedidosCupon;
GO

IF EXISTS (SELECT name FROM sys.procedures WHERE name = 'Migrar_CuponesPorReclamos')
DROP PROCEDURE NO_SE_BAJA_NADIE.Migrar_CuponesPorReclamos;
GO

IF EXISTS (SELECT name FROM sys.procedures WHERE name = 'Migrar_Usuario')
DROP PROCEDURE NO_SE_BAJA_NADIE.Migrar_Usuario;
GO

IF EXISTS (SELECT name FROM sys.procedures WHERE name = 'Migrar_Pedido')
DROP PROCEDURE NO_SE_BAJA_NADIE.Migrar_Pedido;
GO

IF EXISTS (SELECT name FROM sys.procedures WHERE name = 'Migrar_Reclamo')
DROP PROCEDURE NO_SE_BAJA_NADIE.Migrar_Reclamo;
GO

IF EXISTS (SELECT name FROM sys.procedures WHERE name = 'Migrar_catalogos')
DROP PROCEDURE NO_SE_BAJA_NADIE.Migrar_catalogos;
GO

PRINT '**** SPs dropeados correctamente ****';

go

--DROP PREVENTIVO DE TABLAS-------------------------
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'usuario')
DROP TABLE NO_SE_BAJA_NADIE.usuario
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'medio_pago')
DROP TABLE NO_SE_BAJA_NADIE.medio_pago
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'medio_pago_tarjeta')
DROP TABLE NO_SE_BAJA_NADIE.medio_pago_tarjeta
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'localidad')
DROP TABLE NO_SE_BAJA_NADIE.localidad
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'direccion_usuario')
DROP TABLE NO_SE_BAJA_NADIE.direccion_usuario
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'tipo_movilidad')
DROP TABLE NO_SE_BAJA_NADIE.tipo_movilidad
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'repartidor')
DROP TABLE NO_SE_BAJA_NADIE.repartidor
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'local_tipo')
DROP TABLE NO_SE_BAJA_NADIE.local_tipo
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'local_categoria')
DROP TABLE NO_SE_BAJA_NADIE.local_categoria
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'local')
DROP TABLE NO_SE_BAJA_NADIE.local
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'horario_local')
DROP TABLE NO_SE_BAJA_NADIE.horario_local
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'dia')
DROP TABLE NO_SE_BAJA_NADIE.dia
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'estado_pedido')
DROP TABLE NO_SE_BAJA_NADIE.estado_pedido
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'pedido')
DROP TABLE NO_SE_BAJA_NADIE.pedido
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'producto_local')
DROP TABLE NO_SE_BAJA_NADIE.producto_local
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'catalogo_local')
DROP TABLE NO_SE_BAJA_NADIE.catalogo_local
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'producto_pedido')
DROP TABLE NO_SE_BAJA_NADIE.producto_pedido
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'paquete_tipo')
DROP TABLE NO_SE_BAJA_NADIE.paquete_tipo
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'paquete')
DROP TABLE NO_SE_BAJA_NADIE.paquete
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'estado_mensajeria')
DROP TABLE NO_SE_BAJA_NADIE.estado_mensajeria
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'envio_mensajeria')
DROP TABLE NO_SE_BAJA_NADIE.envio_mensajeria
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'operador_reclamo')
DROP TABLE NO_SE_BAJA_NADIE.operador_reclamo
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'reclamo_tipo')
DROP TABLE NO_SE_BAJA_NADIE.reclamo_tipo
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'estado_reclamo')
DROP TABLE NO_SE_BAJA_NADIE.estado_reclamo
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'reclamo')
DROP TABLE NO_SE_BAJA_NADIE.reclamo
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'cupon_tipo')
DROP TABLE NO_SE_BAJA_NADIE.cupon_tipo
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'cupon')
DROP TABLE NO_SE_BAJA_NADIE.cupon
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'cupon_pedido')
DROP TABLE NO_SE_BAJA_NADIE.cupon_pedido
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'cupon_por_reclamo')
DROP TABLE NO_SE_BAJA_NADIE.cupon_por_reclamo

PRINT '**** Tablas dropeados correctamente ****';


--DROP PREVENTIVO DE SCHEMA-------------------------
IF EXISTS (SELECT name FROM sys.schemas WHERE name = 'NO_SE_BAJA_NADIE')
DROP SCHEMA NO_SE_BAJA_NADIE
GO

--CREACIÓN DE SCHEMA--------------------------------
CREATE SCHEMA NO_SE_BAJA_NADIE;
GO


--CREACIÓN DE TABLAS--------------------------------
CREATE TABLE NO_SE_BAJA_NADIE.usuario(
	USUARIO_ID int IDENTITY,
	NOMBRE nvarchar(255) null,
	APELLIDO nvarchar(255) null,
	FECHA_REGISTRO datetime2(3) null,
	TELEFONO decimal(18,0) null,
	MAIL nvarchar(255) null,
	FECHA_NAC date null,
	DNI decimal(18,0) null
);

CREATE TABLE NO_SE_BAJA_NADIE.medio_pago (
	MEDIO_PAGO_ID int IDENTITY,
	USUARIO_ID int not null,
	TIPO nvarchar(50) null
);

CREATE TABLE NO_SE_BAJA_NADIE.medio_pago_tarjeta (
	MEDIO_PAGO_TARJETA_ID int IDENTITY,
	NRO_TARJETA nvarchar(50) null,
	MEDIO_PAGO_ID int not null,
	MARCA_TARJETA nvarchar(100) null,
	TIPO_TARJETA nvarchar(50) null
);

CREATE TABLE NO_SE_BAJA_NADIE.localidad (
	LOCALIDAD_COD int IDENTITY,
	LOCALIDAD nvarchar(255) null
);

CREATE TABLE NO_SE_BAJA_NADIE.direccion_usuario (
	DIRECCION_USUARIO_CODIGO int IDENTITY,
	USUARIO_ID int not null,
	LOCALIDAD_COD int not null,
	NOMBRE nvarchar(50) null,
	DIRECCION nvarchar(255) null,
	PROVINCIA nvarchar(255) null
);

CREATE TABLE NO_SE_BAJA_NADIE.tipo_movilidad (
	TIPO_MOVILIDAD_ID int IDENTITY,
	NOMBRE nvarchar(50) null
);

CREATE TABLE NO_SE_BAJA_NADIE.repartidor (
	REPARTIDOR_ID int IDENTITY,
	TIPO_MOVILIDAD_ID int not null,
	LOCALIDAD_COD int not null,
	NOMBRE nvarchar(255) null,
	APELLIDO nvarchar(255) null,
	DNI decimal(18,0) null,
	TELEFONO decimal(18,0) null,
	EMAIL nvarchar(255) null,
    DIRECCION nvarchar(255) null,
	FECHA_NAC date null
);

CREATE TABLE NO_SE_BAJA_NADIE.local_tipo (
	LOCAL_TIPO_ID int IDENTITY,
	TIPO nvarchar(50) null
);

CREATE TABLE NO_SE_BAJA_NADIE.local_categoria (
	LOCAL_CATEGORIA_ID int IDENTITY,
	LOCAL_TIPO_ID int not null,
	CATEGORIA nvarchar(50) null
);

CREATE TABLE NO_SE_BAJA_NADIE.local (
	LOCAL_COD int IDENTITY,
	LOCAL_TIPO_ID int not null,
	LOCALIDAD_COD int not null,
	DESCRIPCION nvarchar(255) null,
	DIRECCION nvarchar(255) null,
	PROVINCIA nvarchar(255) null,
	NOMBRE nvarchar(100) null
);

CREATE TABLE NO_SE_BAJA_NADIE.dia (
	DIA_ID int IDENTITY,
	DIA nvarchar(50) not null
);

CREATE TABLE NO_SE_BAJA_NADIE.horario_local (
	HORARIO_LOCAL_COD int IDENTITY,
	LOCAL_COD int not null,
	DIA_ID int not null,
	HORA_APERTURA decimal(18,0) null,
	HORA_CIERRE decimal(18,0) null
);

CREATE TABLE NO_SE_BAJA_NADIE.estado_pedido (
	ESTADO_PEDIDO_ID int IDENTITY,
	ESTADO nvarchar(50) null
);

CREATE TABLE NO_SE_BAJA_NADIE.pedido (
	PEDIDO_NRO decimal(18,0) IDENTITY,
	LOCAL_COD int not null,
	USUARIO_ID int not null,
	REPARTIDOR_ID int not null,
	DIRECCION_USUARIO_CODIGO int not null,
	ESTADO_PEDIDO_ID int not null,
	MEDIO_PAGO_ID int not null,
	TOTAL_PRODUCTOS decimal(18,2) null,
	PRECIO_ENVIO decimal(18,2) null,
	TARIFA_SERVICIO decimal(18,2) null,
	PROPINA decimal(18,2) null,
	TOTAL_CUPONES decimal(18,2) null,
	TOTAL_SERVICIO decimal(18,2) null,
	OBSERV nvarchar(255) null,
	FECHA datetime null,
	FECHA_ENTREGA datetime null,
	TIEMPO_ESTIMADO_ENTREGA decimal(18,2) null,
	CALIFICACION decimal(18,0) null
);

CREATE TABLE NO_SE_BAJA_NADIE.producto_local (
	PRODUCTO_ID int IDENTITY, 
	LOCAL_COD int not null,
	PRODUCTO_LOCAL_CODIGO nvarchar(50),
	PRECIO decimal(18,2) null,
	NOMBRE nvarchar(50) null,
	DESCRIPCION nvarchar(255) null
);

CREATE TABLE NO_SE_BAJA_NADIE.catalogo_local (
	CATALOGO_LOCAL_NUM int IDENTITY,
	PRODUCTO_ID int not null,
	STOCK decimal(18,2) null,
	DESCRIPCION nvarchar(50) null,
	FOTO nvarchar(255) null,
	PROPAGANDA nvarchar(255) null
);

CREATE TABLE NO_SE_BAJA_NADIE.producto_pedido (
	PRODUCTO_PEDIDO_ID int IDENTITY,
	PRODUCTO_ID int not null,
	PEDIDO_NRO decimal(18,0) not null,
	CANTIDAD decimal(18,0) null,
	PRECIO decimal(18,2) null
);

CREATE TABLE NO_SE_BAJA_NADIE.paquete_tipo (
	TIPO_ID int IDENTITY,
	TIPO nvarchar(50) null,
	PRECIO decimal(18,2) null,
	ANCHO_MAX decimal(18,2) null,
	PESO_MAX decimal(18,2) null,
	LARGO_MAX decimal(18,2) null,
	ALTO_MAX decimal(18,2) null
);

CREATE TABLE NO_SE_BAJA_NADIE.paquete (
	PAQUETE_ID int IDENTITY,
	TIPO_ID int not null,
	PRECIO decimal(18,2) null
);

CREATE TABLE NO_SE_BAJA_NADIE.estado_mensajeria (
	ESTADO_MENSAJERIA_ID int IDENTITY,
	ESTADO nvarchar(50) null
);

CREATE TABLE NO_SE_BAJA_NADIE.envio_mensajeria (
	ENVIO_MENSAJERIA_NRO decimal(18,0) IDENTITY,
	USUARIO_ID int not null,
	REPARTIDOR_ID int not null,
	PAQUETE_ID int not null,
	ESTADO_MENSAJERIA_ID int not null,
	LOCALIDAD_COD int not null,
	DIR_ORIG nvarchar(255) null,
	DIR_DEST nvarchar(255) null,
	PROVINCIA nvarchar(255) null,
	KM decimal(18,2) null,
	VALOR_ASEGURADO decimal(18,2) null,
	PRECIO_SEGURO decimal(18,2) null,
	PRECIO_ENVIO decimal(18,2) null,
	PROPINA decimal (18,2) null,
	TOTAL decimal(18,2) null,
	OBSERV nvarchar(255) null,
	FECHA datetime null,
	FECHA_ENTREGA datetime null,
	TIEMPO_ESTIMADO decimal(18,2) null,
	CALIFICACION decimal(18,0) null
);

CREATE TABLE NO_SE_BAJA_NADIE.operador_reclamo (
	OPERADOR_RECLAMO_ID int IDENTITY,
	NOMBRE nvarchar(255) null,
	APELLIDO nvarchar(255) null,
	DNI decimal(18,0) null,
	TELEFONO decimal(18,0) null,
	DIRECCION nvarchar(255) null,
	MAIL nvarchar(255) null,
	FECHA_NAC date null	
);

CREATE TABLE NO_SE_BAJA_NADIE.reclamo_tipo(
	RECLAMO_TIPO_ID int IDENTITY,
	TIPO nvarchar(50) null
);

CREATE TABLE NO_SE_BAJA_NADIE.estado_reclamo(
	ESTADO_RECLAMO_ID int IDENTITY,
	ESTADO nvarchar(50) null
);

CREATE TABLE NO_SE_BAJA_NADIE.cupon_tipo(
	CUPON_TIPO_ID int IDENTITY,
	TIPO nvarchar(50) null
);

CREATE TABLE NO_SE_BAJA_NADIE.cupon(
	CUPON_NRO decimal(18,0) IDENTITY,
	USUARIO_ID int not null,
	CUPON_TIPO_ID int not null,
	MONTO decimal(18,2) null,
	FECHA_ALTA datetime null,
	FECHA_VENCIMIENTO datetime null
);

CREATE TABLE NO_SE_BAJA_NADIE.reclamo(
	RECLAMO_NRO decimal(18,0) IDENTITY,
	OPERADOR_RECLAMO_ID int not null,
	RECLAMO_TIPO_ID int not null,
	ESTADO_RECLAMO_ID int not null,
	PEDIDO_NRO decimal(18,0) not null,
	FECHA_SOLUCION datetime null,
	SOLUCION nvarchar(255) null,
	CALIFICACION decimal(18,0) null,
	DESCRIPCION nvarchar(255) null,
	FECHA datetime null
);

CREATE TABLE NO_SE_BAJA_NADIE.cupon_pedido(
	CUPON_NRO decimal(18,0) IDENTITY not null,
	PEDIDO_NRO decimal(18,0) not null,
	MONTO decimal(18,2) null
);

CREATE TABLE NO_SE_BAJA_NADIE.cupon_por_reclamo(
	CUPON_NRO decimal(18,0) IDENTITY not null,
	RECLAMO_NRO decimal(18,0) not null,
	MONTO decimal(18,2) null
);
GO

print '**** Tablas creadas correctamente ****';

GO

/********* Creacion de CONSTRAINTS ********/

-- Usuario
ALTER TABLE NO_SE_BAJA_NADIE.usuario
ADD
		CONSTRAINT PK_Usuario primary key (USUARIO_ID);

--Medio de Pago
ALTER TABLE NO_SE_BAJA_NADIE.medio_pago
ADD
		CONSTRAINT PK_Medio_pago primary key (MEDIO_PAGO_ID),
		CONSTRAINT FK_Medio_pago_usuario foreign key (USUARIO_ID) REFERENCES NO_SE_BAJA_NADIE.usuario (USUARIO_ID);

--Medio pago tarjeta
ALTER TABLE NO_SE_BAJA_NADIE.medio_pago_tarjeta
ADD 
		CONSTRAINT PK_Medio_pago_tarjeta primary key (MEDIO_PAGO_TARJETA_ID),
		CONSTRAINT FK_Medio_pago foreign key (MEDIO_PAGO_ID) REFERENCES NO_SE_BAJA_NADIE.medio_pago (MEDIO_PAGO_ID);

--Localidad
ALTER TABLE NO_SE_BAJA_NADIE.localidad
ADD
		CONSTRAINT PK_Localidad primary key (LOCALIDAD_COD);

--Direccion usuario
ALTER TABLE NO_SE_BAJA_NADIE.direccion_usuario
ADD
		CONSTRAINT PK_Direccion primary key (DIRECCION_USUARIO_CODIGO),
		CONSTRAINT FK_Direccion_usuario foreign key (USUARIO_ID) REFERENCES NO_SE_BAJA_NADIE.usuario (USUARIO_ID),
		CONSTRAINT FK_Direccion_localidad foreign key  (LOCALIDAD_COD) REFERENCES NO_SE_BAJA_NADIE.localidad (LOCALIDAD_COD);

--Tipo Movilidad
ALTER TABLE NO_SE_BAJA_NADIE.tipo_movilidad
ADD
		CONSTRAINT PK_Movilidad primary key (TIPO_MOVILIDAD_ID);

--Repartidor
ALTER TABLE NO_SE_BAJA_NADIE.repartidor
ADD
		CONSTRAINT PK_Repartidor primary key (REPARTIDOR_ID),
		CONSTRAINT FK_Repartidor_movilidad foreign key (TIPO_MOVILIDAD_ID) REFERENCES NO_SE_BAJA_NADIE.tipo_movilidad (TIPO_MOVILIDAD_ID),
		CONSTRAINT FK_Repartidor_localidad foreign key (LOCALIDAD_COD) REFERENCES NO_SE_BAJA_NADIE.localidad (LOCALIDAD_COD);

--Local tipo
ALTER TABLE NO_SE_BAJA_NADIE.local_tipo
ADD
		CONSTRAINT PK_Local_tipo primary key (LOCAL_TIPO_ID);

--Local categoria
ALTER TABLE NO_SE_BAJA_NADIE.local_categoria
ADD
		CONSTRAINT PK_Local_categoria primary key (LOCAL_CATEGORIA_ID),
		CONSTRAINT UQ_Local_categoria_tipo_categoria UNIQUE (LOCAL_TIPO_ID, CATEGORIA),
		CONSTRAINT FK_Local_categoria_tipo foreign key (LOCAL_TIPO_ID) REFERENCES NO_SE_BAJA_NADIE.local_tipo (LOCAL_TIPO_ID);

--Local
ALTER TABLE NO_SE_BAJA_NADIE.local
ADD
		CONSTRAINT PK_Local primary key (LOCAL_COD),
		CONSTRAINT FK_Local_tipo foreign key (LOCAL_TIPO_ID) REFERENCES NO_SE_BAJA_NADIE.local_tipo (LOCAL_TIPO_ID),
		CONSTRAINT FK_Local_localidad foreign key (LOCALIDAD_COD) REFERENCES NO_SE_BAJA_NADIE.localidad (LOCALIDAD_COD);

--Dia
ALTER TABLE NO_SE_BAJA_NADIE.dia
ADD
		CONSTRAINT PK_Dia primary key (DIA_ID);

--Horario local
ALTER TABLE NO_SE_BAJA_NADIE.horario_local
ADD
		CONSTRAINT PK_Horario_local primary key (HORARIO_LOCAL_COD),
		CONSTRAINT FK_Horario_local_local foreign key (LOCAL_COD) REFERENCES NO_SE_BAJA_NADIE.local (LOCAL_COD),
		CONSTRAINT FK_Horario_dia foreign key (DIA_ID) REFERENCES NO_SE_BAJA_NADIE.dia (DIA_ID);

--Estado pedido
ALTER TABLE NO_SE_BAJA_NADIE.estado_pedido
ADD
		CONSTRAINT PK_Estado_pedido primary key (ESTADO_PEDIDO_ID);

--Pedido
ALTER TABLE NO_SE_BAJA_NADIE.pedido
ADD
		CONSTRAINT PK_Pedido primary key (PEDIDO_NRO),
		CONSTRAINT FK_Pedido_local foreign key (LOCAL_COD) REFERENCES NO_SE_BAJA_NADIE.local (LOCAL_COD),
		CONSTRAINT FK_Pedido_usuario foreign key (USUARIO_ID) REFERENCES NO_SE_BAJA_NADIE.usuario (USUARIO_ID),
		CONSTRAINT FK_Pedido_repartidor foreign key (REPARTIDOR_ID) REFERENCES NO_SE_BAJA_NADIE.repartidor (REPARTIDOR_ID),
		CONSTRAINT FK_Pedido_direccion foreign key (DIRECCION_USUARIO_CODIGO) REFERENCES NO_SE_BAJA_NADIE.direccion_usuario (DIRECCION_USUARIO_CODIGO),
		CONSTRAINT FK_Pedido_estado foreign key (ESTADO_PEDIDO_ID) REFERENCES NO_SE_BAJA_NADIE.estado_pedido (ESTADO_PEDIDO_ID),
		CONSTRAINT FK_Pedido_pago foreign key (MEDIO_PAGO_ID) REFERENCES NO_SE_BAJA_NADIE.medio_pago (MEDIO_PAGO_ID);

--Producto local
ALTER TABLE NO_SE_BAJA_NADIE.producto_local
ADD
		CONSTRAINT PK_Producto primary key (PRODUCTO_ID),
		CONSTRAINT FK_Producto_local foreign key (LOCAL_COD) REFERENCES NO_SE_BAJA_NADIE.local (LOCAL_COD);

--Catalogo local
ALTER TABLE NO_SE_BAJA_NADIE.catalogo_local
ADD
		CONSTRAINT PK_Catalogo primary key (CATALOGO_LOCAL_NUM),
		CONSTRAINT FK_Catalogo_producto foreign key (PRODUCTO_ID) REFERENCES NO_SE_BAJA_NADIE.producto_local (PRODUCTO_ID);

--Producto pedido
ALTER TABLE NO_SE_BAJA_NADIE.producto_pedido
ADD
		CONSTRAINT PK_Producto_pedido primary key (PRODUCTO_PEDIDO_ID),
		CONSTRAINT FK_Producto foreign key (PRODUCTO_ID) REFERENCES NO_SE_BAJA_NADIE.producto_local (PRODUCTO_ID),
		CONSTRAINT FK_Pedido_producto foreign key (PEDIDO_NRO) REFERENCES NO_SE_BAJA_NADIE.pedido (PEDIDO_NRO);

--Paquete tipo
ALTER TABLE NO_SE_BAJA_NADIE.paquete_tipo
ADD
		CONSTRAINT PK_Tipo primary key (TIPO_ID);

--Paquete
ALTER TABLE NO_SE_BAJA_NADIE.paquete
ADD
		CONSTRAINT PK_Paquete primary key (PAQUETE_ID),
		CONSTRAINT FK_Paquete_tipo foreign key (TIPO_ID) REFERENCES NO_SE_BAJA_NADIE.paquete_tipo (TIPO_ID);

--Estado mensajeria
ALTER TABLE NO_SE_BAJA_NADIE.estado_mensajeria
ADD
		CONSTRAINT PK_estado_mensajeria primary key (ESTADO_MENSAJERIA_ID);

--Envio Mensajeria
ALTER TABLE NO_SE_BAJA_NADIE.envio_mensajeria
ADD
		CONSTRAINT PK_Envio_mensajeria primary key (ENVIO_MENSAJERIA_NRO),
		CONSTRAINT FK_Envio_usuario foreign key (USUARIO_ID) REFERENCES NO_SE_BAJA_NADIE.usuario (USUARIO_ID),
		CONSTRAINT FK_Envio_repartidor foreign key (REPARTIDOR_ID) REFERENCES NO_SE_BAJA_NADIE.repartidor (REPARTIDOR_ID),
		CONSTRAINT FK_Envio_paquete foreign key (PAQUETE_ID) REFERENCES NO_SE_BAJA_NADIE.paquete (PAQUETE_ID),
		CONSTRAINT FK_Envio_estado foreign key (ESTADO_MENSAJERIA_ID) REFERENCES NO_SE_BAJA_NADIE.estado_mensajeria (ESTADO_MENSAJERIA_ID),
		CONSTRAINT FK_Envio_localidad foreign key (LOCALIDAD_COD) REFERENCES NO_SE_BAJA_NADIE.localidad (LOCALIDAD_COD);

--Operador Reclamo
ALTER TABLE NO_SE_BAJA_NADIE.operador_reclamo
ADD
		CONSTRAINT PK_Operador primary key (OPERADOR_RECLAMO_ID);

--Reclamo tipo
ALTER TABLE NO_SE_BAJA_NADIE.reclamo_tipo
ADD
		CONSTRAINT PK_Tipo_reclamo primary key (RECLAMO_TIPO_ID);

--Estado reclamo
ALTER TABLE NO_SE_BAJA_NADIE.estado_reclamo
ADD
		CONSTRAINT PK_Estado_reclamo primary key (ESTADO_RECLAMO_ID);

-- Cupon tipo
ALTER TABLE NO_SE_BAJA_NADIE.cupon_tipo
ADD
		CONSTRAINT PK_Cupon_tipo primary key (CUPON_TIPO_ID);

--Cupon
ALTER TABLE NO_SE_BAJA_NADIE.cupon
ADD
		CONSTRAINT PK_Cupon primary key (CUPON_NRO),
		CONSTRAINT FK_Cupon_usuario foreign key (USUARIO_ID) REFERENCES NO_SE_BAJA_NADIE.usuario (USUARIO_ID),
		CONSTRAINT FK_Cupon_tipo foreign key (CUPON_TIPO_ID) REFERENCES NO_SE_BAJA_NADIE.cupon_tipo (CUPON_TIPO_ID);

--Reclamo
ALTER TABLE NO_SE_BAJA_NADIE.reclamo
ADD
		CONSTRAINT PK_Reclamo primary key (RECLAMO_NRO),
		CONSTRAINT FK_Reclamo_operador foreign key (OPERADOR_RECLAMO_ID) REFERENCES NO_SE_BAJA_NADIE.operador_reclamo (OPERADOR_RECLAMO_ID),
		CONSTRAINT FK_Reclamo_tipo foreign key (RECLAMO_TIPO_ID) REFERENCES NO_SE_BAJA_NADIE.reclamo_tipo (RECLAMO_TIPO_ID),
		CONSTRAINT FK_Reclamo_estado foreign key (ESTADO_RECLAMO_ID) REFERENCES NO_SE_BAJA_NADIE.estado_reclamo (ESTADO_RECLAMO_ID),
		CONSTRAINT FK_Reclamo_pedido foreign key (PEDIDO_NRO) REFERENCES NO_SE_BAJA_NADIE.pedido (PEDIDO_NRO);

--Cupon pedido
ALTER TABLE NO_SE_BAJA_NADIE.cupon_pedido
ADD
		CONSTRAINT PK_Cupon_pedido primary key (CUPON_NRO),
		CONSTRAINT FK_Cupon_pedido_cupon foreign key (CUPON_NRO) REFERENCES NO_SE_BAJA_NADIE.cupon (CUPON_NRO),
		CONSTRAINT FK_Cupon_pedido_pedido foreign key (PEDIDO_NRO) REFERENCES NO_SE_BAJA_NADIE.pedido (PEDIDO_NRO);

--Cupon reclamo
ALTER TABLE NO_SE_BAJA_NADIE.cupon_por_reclamo
ADD
		CONSTRAINT PK_Cupon_reclamo primary key (CUPON_NRO),
		CONSTRAINT FK_Cupon_reclamo_cupon foreign key (CUPON_NRO) REFERENCES NO_SE_BAJA_NADIE.cupon (CUPON_NRO),
		CONSTRAINT FK_Cupon_reclamo_reclamo foreign key (RECLAMO_NRO) REFERENCES NO_SE_BAJA_NADIE.reclamo (RECLAMO_NRO);


GO

/********* Creacion de Indices *********/
CREATE INDEX idx_usuariodireccion
ON NO_SE_BAJA_NADIE.direccion_usuario(USUARIO_ID,DIRECCION_USUARIO_CODIGO);

CREATE INDEX idx_enviousuario
ON NO_SE_BAJA_NADIE.envio_mensajeria(USUARIO_ID,ENVIO_MENSAJERIA_NRO);

CREATE INDEX idx_enviorepartidor
ON NO_SE_BAJA_NADIE.envio_mensajeria(REPARTIDOR_ID,ENVIO_MENSAJERIA_NRO);

CREATE INDEX idx_usuariomediopago
ON NO_SE_BAJA_NADIE.medio_pago(USUARIO_ID,MEDIO_PAGO_ID);

CREATE INDEX idx_cuponusuario
ON NO_SE_BAJA_NADIE.cupon(USUARIO_ID,CUPON_NRO);

CREATE INDEX idx_pedidousuario
ON NO_SE_BAJA_NADIE.pedido(USUARIO_ID,PEDIDO_NRO);

CREATE INDEX idx_pedidoreclamo
ON NO_SE_BAJA_NADIE.reclamo(PEDIDO_NRO,RECLAMO_NRO);

CREATE INDEX idx_cuponpedido
ON NO_SE_BAJA_NADIE.cupon_pedido(PEDIDO_NRO,CUPON_NRO);

CREATE INDEX idx_productopedido
ON NO_SE_BAJA_NADIE.producto_pedido(PEDIDO_NRO,PRODUCTO_ID);

CREATE INDEX idx_pedidorepartidor
ON NO_SE_BAJA_NADIE.pedido(REPARTIDOR_ID,PEDIDO_NRO);

CREATE INDEX idx_productocatalogo
ON NO_SE_BAJA_NADIE.catalogo_local(PRODUCTO_ID,CATALOGO_LOCAL_NUM);

CREATE INDEX idx_horariolocal
ON NO_SE_BAJA_NADIE.horario_local(LOCAL_COD,HORARIO_LOCAL_COD);

print '**** Indices creados correctamente ****'
GO


-- Creacion de StoredProcedures para migracion

--Estado Reclamo

create procedure NO_SE_BAJA_NADIE.Migrar_estados_reclamos
as
begin 
insert into NO_SE_BAJA_NADIE.estado_reclamo(ESTADO)
select distinct M.RECLAMO_ESTADO
from gd_esquema.Maestra as M
	where M.RECLAMO_ESTADO is not null
end
go

--Reclamo Tipo
create procedure NO_SE_BAJA_NADIE.Migrar_reclamos_tipos
as
begin 
insert into NO_SE_BAJA_NADIE.reclamo_tipo(TIPO)
select distinct M.RECLAMO_TIPO
from gd_esquema.Maestra as M
	where M.RECLAMO_TIPO is not null
end
go

--Operador 
create procedure NO_SE_BAJA_NADIE.Migrar_Operadores
as
begin 
insert into NO_SE_BAJA_NADIE.operador_reclamo(DNI, APELLIDO, NOMBRE, TELEFONO, MAIL, DIRECCION, FECHA_NAC)

select distinct M.OPERADOR_RECLAMO_DNI,M.OPERADOR_RECLAMO_APELLIDO, M.OPERADOR_RECLAMO_NOMBRE, M.OPERADOR_RECLAMO_TELEFONO,  M.OPERADOR_RECLAMO_MAIL, M.OPERADOR_RECLAMO_DIRECCION, M.OPERADOR_RECLAMO_FECHA_NAC
	from gd_esquema.Maestra as M
	where M.OPERADOR_RECLAMO_DNI is not null
end
go

--Estado Mensajeria
create procedure NO_SE_BAJA_NADIE.Migrar_estados_mensajería
as
begin 
insert into NO_SE_BAJA_NADIE.estado_mensajeria(ESTADO)
select distinct M.ENVIO_MENSAJERIA_ESTADO
from gd_esquema.Maestra as M
	where M.ENVIO_MENSAJERIA_ESTADO is not null
end
go

--Paquete Tipo
create procedure NO_SE_BAJA_NADIE.Migrar_paquetes_tipos
as
begin 
insert into NO_SE_BAJA_NADIE.paquete_tipo(TIPO, PRECIO, ANCHO_MAX,PESO_MAX, LARGO_MAX, ALTO_MAX)
select distinct M.PAQUETE_TIPO, M.PAQUETE_TIPO_PRECIO, M.PAQUETE_ANCHO_MAX, M.PAQUETE_PESO_MAX, M.PAQUETE_LARGO_MAX, M.PAQUETE_ALTO_MAX
from gd_esquema.Maestra as M
	where M.PAQUETE_TIPO is not null
end
go

--Paquete
create procedure NO_SE_BAJA_NADIE.Migrar_paquetes
as
begin 
insert into NO_SE_BAJA_NADIE.paquete(PRECIO, TIPO_ID)
select distinct M.PAQUETE_TIPO_PRECIO,
				(SELECT TIPO_ID FROM NO_SE_BAJA_NADIE.paquete_tipo where TIPO = M.PAQUETE_TIPO)
from gd_esquema.Maestra as M
	where M.PAQUETE_TIPO_PRECIO is not null
end
go

--Producto
CREATE PROCEDURE NO_SE_BAJA_NADIE.Migrar_Productos_Locales
AS
BEGIN
    INSERT INTO NO_SE_BAJA_NADIE.producto_local(PRODUCTO_LOCAL_CODIGO, LOCAL_COD, NOMBRE, PRECIO, DESCRIPCION)
    SELECT DISTINCT
		 M.PRODUCTO_LOCAL_CODIGO,
        (SELECT TOP 1 LOCAL_COD FROM NO_SE_BAJA_NADIE.local WHERE NOMBRE = M.LOCAL_NOMBRE),
		M.PRODUCTO_LOCAL_NOMBRE,
        M.PRODUCTO_LOCAL_PRECIO,
        M.PRODUCTO_LOCAL_DESCRIPCION
    FROM gd_esquema.Maestra AS M
    WHERE M.PRODUCTO_LOCAL_CODIGO IS NOT NULL;

END
GO

--Producto pedido
CREATE PROCEDURE NO_SE_BAJA_NADIE.Migrar_Productos_Pedidos
AS
BEGIN
    INSERT INTO NO_SE_BAJA_NADIE.producto_pedido (PEDIDO_NRO, PRODUCTO_ID, CANTIDAD, PRECIO)
    SELECT DISTINCT
	    (SELECT PEDIDO_NRO FROM NO_SE_BAJA_NADIE.pedido WHERE PEDIDO_NRO = M.PEDIDO_NRO),
        (SELECT TOP 1 PRODUCTO_ID FROM NO_SE_BAJA_NADIE.producto_local WHERE PRODUCTO_LOCAL_CODIGO = M.PRODUCTO_LOCAL_CODIGO),
        M.PRODUCTO_CANTIDAD,
        M.PRODUCTO_LOCAL_PRECIO
    FROM
        gd_esquema.Maestra AS M
    WHERE
        M.PEDIDO_NRO IS NOT NULL AND M.PRODUCTO_LOCAL_CODIGO IS NOT NULL
END
GO

--Estado Pedido
create procedure NO_SE_BAJA_NADIE.Migrar_estados_pedidos
as
begin 
insert into NO_SE_BAJA_NADIE.estado_pedido(ESTADO)
select distinct M.PEDIDO_ESTADO
from gd_esquema.Maestra as M
	where M.PEDIDO_ESTADO is not null
end
go

--Dia
create procedure NO_SE_BAJA_NADIE.Migrar_dias
as
begin 
insert into NO_SE_BAJA_NADIE.dia(DIA)
select distinct M.HORARIO_LOCAL_DIA
from gd_esquema.Maestra as M
	where M.HORARIO_LOCAL_DIA is not null
end
go

--Horario
create procedure NO_SE_BAJA_NADIE.Migrar_Horario_Local
as
begin 
insert into NO_SE_BAJA_NADIE.horario_local(HORA_APERTURA, HORA_CIERRE, LOCAL_COD, DIA_ID)
select distinct M.HORARIO_LOCAL_HORA_APERTURA,  M.HORARIO_LOCAL_HORA_CIERRE,
(SELECT LOCAL_COD FROM NO_SE_BAJA_NADIE.local where NOMBRE = M.LOCAL_NOMBRE),
(SELECT DIA_ID FROM NO_SE_BAJA_NADIE.dia where DIA = M.HORARIO_LOCAL_DIA)
from gd_esquema.Maestra as M
	where M.HORARIO_LOCAL_HORA_APERTURA is not null
end
go

--Tipo local
create procedure NO_SE_BAJA_NADIE.Migrar_Tipo_Locales
as
begin 
insert into NO_SE_BAJA_NADIE.local_tipo(TIPO)
select distinct M.LOCAL_TIPO
from gd_esquema.Maestra as M
	where M.LOCAL_TIPO is not null
end
go

--Categoria local
create procedure NO_SE_BAJA_NADIE.Migrar_Categorias_Locales
as
begin
insert into NO_SE_BAJA_NADIE.local_categoria(LOCAL_TIPO_ID)
 select distinct (SELECT LOCAL_TIPO_ID FROM NO_SE_BAJA_NADIE.local_tipo where TIPO = M.LOCAL_TIPO) 
 from gd_esquema.Maestra as M
 WHERE M.LOCAL_TIPO IS NOT NULL

 UPDATE NO_SE_BAJA_NADIE.local_categoria
	SET CATEGORIA = 'parrilla'
	WHERE LOCAL_TIPO_ID = 1

UPDATE NO_SE_BAJA_NADIE.local_categoria
	SET CATEGORIA = 'kiosco'
	WHERE LOCAL_TIPO_ID = 2

end
go
--Tipo Movilidad
create procedure NO_SE_BAJA_NADIE.Migrar_Tipo_Movilidades
as
begin 
insert into NO_SE_BAJA_NADIE.tipo_movilidad(NOMBRE)
select distinct M.REPARTIDOR_TIPO_MOVILIDAD
from gd_esquema.Maestra as M
	where M.REPARTIDOR_TIPO_MOVILIDAD is not null
end
go

--Direccion Usuario
create procedure NO_SE_BAJA_NADIE.Migrar_Direcciones_Usuarios
as
begin 
insert into NO_SE_BAJA_NADIE.direccion_usuario(DIRECCION, USUARIO_ID, LOCALIDAD_COD, NOMBRE,PROVINCIA)
select distinct M.DIRECCION_USUARIO_DIRECCION, 
				(SELECT USUARIO_ID FROM NO_SE_BAJA_NADIE.usuario where DNI = M.USUARIO_DNI),
				(SELECT LOCALIDAD_COD FROM NO_SE_BAJA_NADIE.localidad where LOCALIDAD = M.DIRECCION_USUARIO_LOCALIDAD),
				M.DIRECCION_USUARIO_NOMBRE, 
				M.DIRECCION_USUARIO_PROVINCIA
from gd_esquema.Maestra as M
	where M.DIRECCION_USUARIO_DIRECCION is not null
end
go

--Medio Pago

create procedure NO_SE_BAJA_NADIE.Migrar_Medio_Pagos
as
begin 
insert into NO_SE_BAJA_NADIE.medio_pago(TIPO, USUARIO_ID)
select distinct M.MEDIO_PAGO_TIPO,
				(SELECT USUARIO_ID FROM NO_SE_BAJA_NADIE.usuario WHERE DNI = M.USUARIO_DNI)
from gd_esquema.Maestra as M
	where M.MEDIO_PAGO_TIPO is not null
end
go

--Catalogo
create procedure NO_SE_BAJA_NADIE.Migrar_catalogos
as
begin
insert into NO_SE_BAJA_NADIE.catalogo_local(PRODUCTO_ID)
select (SELECT TOP 1 PRODUCTO_ID FROM NO_SE_BAJA_NADIE.producto_local WHERE PRODUCTO_LOCAL_CODIGO = M.PRODUCTO_LOCAL_CODIGO)
FROM gd_esquema.Maestra as M
WHERE M.PRODUCTO_LOCAL_CODIGO IS NOT NULL
end
go

--Repartidor
CREATE PROCEDURE NO_SE_BAJA_NADIE.Migrar_Repartidores
AS
BEGIN
    INSERT INTO NO_SE_BAJA_NADIE.repartidor (DNI, TIPO_MOVILIDAD_ID, LOCALIDAD_COD, APELLIDO, NOMBRE, TELEFONO, EMAIL, DIRECCION, FECHA_NAC)
    SELECT
        M.REPARTIDOR_DNI,
        TM.TIPO_MOVILIDAD_ID,
        L.LOCALIDAD_COD,
        M.REPARTIDOR_APELLIDO,
        M.REPARTIDOR_NOMBRE,
        M.REPARTIDOR_TELEFONO,
        M.REPARTIDOR_EMAIL,
        M.REPARTIDOR_DIRECION,
        M.REPARTIDOR_FECHA_NAC
    FROM (
        SELECT
            REPARTIDOR_DNI,
            REPARTIDOR_APELLIDO,
            REPARTIDOR_NOMBRE,
            REPARTIDOR_TELEFONO,
            REPARTIDOR_EMAIL,
            REPARTIDOR_DIRECION,
            REPARTIDOR_FECHA_NAC,
            REPARTIDOR_TIPO_MOVILIDAD,
            LOCALIDAD,
            ROW_NUMBER() OVER (PARTITION BY REPARTIDOR_DNI ORDER BY LOCALIDAD) AS rn
        FROM (
            SELECT
                REPARTIDOR_DNI,
                REPARTIDOR_APELLIDO,
                REPARTIDOR_NOMBRE,
                REPARTIDOR_TELEFONO,
                REPARTIDOR_EMAIL,
                REPARTIDOR_DIRECION,
                REPARTIDOR_FECHA_NAC,
                REPARTIDOR_TIPO_MOVILIDAD,
                CASE
                    WHEN ENVIO_MENSAJERIA_LOCALIDAD IS NOT NULL THEN ENVIO_MENSAJERIA_LOCALIDAD
                    WHEN DIRECCION_USUARIO_LOCALIDAD IS NOT NULL THEN DIRECCION_USUARIO_LOCALIDAD
                    WHEN LOCAL_LOCALIDAD IS NOT NULL THEN LOCAL_LOCALIDAD
                END AS LOCALIDAD
            FROM gd_esquema.Maestra
            WHERE REPARTIDOR_DNI IS NOT NULL
        ) AS SubQuery
    ) AS M
    LEFT JOIN NO_SE_BAJA_NADIE.tipo_movilidad TM ON TM.NOMBRE = M.REPARTIDOR_TIPO_MOVILIDAD
    LEFT JOIN NO_SE_BAJA_NADIE.localidad L ON L.LOCALIDAD = M.LOCALIDAD
    WHERE M.rn = 1;
END
GO

--Envio_Mensajeria
create procedure NO_SE_BAJA_NADIE.Migrar_Envio_Mensajerias
as
begin 
	SET IDENTITY_INSERT NO_SE_BAJA_NADIE.envio_mensajeria ON;

	insert into NO_SE_BAJA_NADIE.envio_mensajeria(ENVIO_MENSAJERIA_NRO, USUARIO_ID, REPARTIDOR_ID, PAQUETE_ID, ESTADO_MENSAJERIA_ID, LOCALIDAD_COD, DIR_ORIG, DIR_DEST, PROVINCIA, KM, VALOR_ASEGURADO, PRECIO_SEGURO, PRECIO_ENVIO, PROPINA, TOTAL, OBSERV, FECHA, FECHA_ENTREGA, TIEMPO_ESTIMADO, CALIFICACION)

	select distinct M.ENVIO_MENSAJERIA_NRO,
				(SELECT TOP 1 USUARIO_ID FROM NO_SE_BAJA_NADIE.usuario WHERE DNI = M.USUARIO_DNI),
				(SELECT TOP 1 REPARTIDOR_ID FROM NO_SE_BAJA_NADIE.repartidor WHERE DNI = M.REPARTIDOR_DNI),
				(SELECT TOP 1 PAQUETE_ID FROM NO_SE_BAJA_NADIE.paquete WHERE PRECIO = M.PAQUETE_TIPO_PRECIO),
				(SELECT TOP 1 ESTADO_MENSAJERIA_ID FROM NO_SE_BAJA_NADIE.estado_mensajeria WHERE ESTADO = M.ENVIO_MENSAJERIA_ESTADO),
				(SELECT TOP 1 LOCALIDAD_COD FROM NO_SE_BAJA_NADIE.localidad WHERE LOCALIDAD = M.ENVIO_MENSAJERIA_LOCALIDAD),
				M.ENVIO_MENSAJERIA_DIR_ORIG, 
				M.ENVIO_MENSAJERIA_DIR_DEST, 
				M.ENVIO_MENSAJERIA_PROVINCIA, 
				M.ENVIO_MENSAJERIA_KM, 
				M.ENVIO_MENSAJERIA_VALOR_ASEGURADO, 
				M.ENVIO_MENSAJERIA_PRECIO_SEGURO, 
				M.ENVIO_MENSAJERIA_PRECIO_ENVIO, 
				M.ENVIO_MENSAJERIA_PROPINA,
				M.ENVIO_MENSAJERIA_TOTAL, 
				M.ENVIO_MENSAJERIA_OBSERV, 
				M.ENVIO_MENSAJERIA_FECHA, 
				M.ENVIO_MENSAJERIA_FECHA_ENTREGA, 
				M.ENVIO_MENSAJERIA_TIEMPO_ESTIMADO, 
				M.ENVIO_MENSAJERIA_CALIFICACION 
	from gd_esquema.Maestra as M
	where M.ENVIO_MENSAJERIA_NRO is not null

	SET IDENTITY_INSERT NO_SE_BAJA_NADIE.envio_mensajeria OFF;
end
go

--Local
create procedure NO_SE_BAJA_NADIE.Migrar_Local
as
begin 
	insert into 
NO_SE_BAJA_NADIE.local(NOMBRE, LOCAL_TIPO_ID, LOCALIDAD_COD, DIRECCION, PROVINCIA, DESCRIPCION)

select distinct M.LOCAL_NOMBRE,
				(SELECT LOCAL_TIPO_ID FROM NO_SE_BAJA_NADIE.local_tipo WHERE TIPO = M.LOCAL_TIPO),
				(SELECT LOCALIDAD_COD FROM NO_SE_BAJA_NADIE.localidad WHERE LOCALIDAD = M.LOCAL_LOCALIDAD),
				M.LOCAL_DIRECCION, 
				M.LOCAL_PROVINCIA, 
				M.LOCAL_DESCRIPCION
	from gd_esquema.Maestra as M 

	where M.LOCAL_NOMBRE is not null
end
go

-- MedioDePagoTarjeta
create procedure NO_SE_BAJA_NADIE.Migrar_MediosDePagoTarjeta
as
begin 
	insert into NO_SE_BAJA_NADIE.medio_pago_tarjeta(NRO_TARJETA, MEDIO_PAGO_ID, MARCA_TARJETA, TIPO_TARJETA)

	select distinct M.MEDIO_PAGO_NRO_TARJETA,
					(SELECT TOP 1 MEDIO_PAGO_ID FROM NO_SE_BAJA_NADIE.medio_pago WHERE TIPO = M.MEDIO_PAGO_TIPO),
					M.MARCA_TARJETA, 
					M.MEDIO_PAGO_TIPO
	from gd_esquema.Maestra as M
	where  MEDIO_PAGO_TIPO IS NOT NULL AND MEDIO_PAGO_TIPO != 'efectivo'
end
go


--Localidad

create procedure NO_SE_BAJA_NADIE.Migrar_Localidades
as
begin 

	insert into NO_SE_BAJA_NADIE.localidad(LOCALIDAD)
	
	select distinct M.LOCAL_LOCALIDAD

	from gd_esquema.Maestra as M

	where M.LOCAL_LOCALIDAD is not null   

	union 

	select distinct M.ENVIO_MENSAJERIA_LOCALIDAD
	
	from gd_esquema.Maestra as M

	where M.ENVIO_MENSAJERIA_LOCALIDAD is not null  

	union

select distinct M.DIRECCION_USUARIO_LOCALIDAD
	
	from gd_esquema.Maestra as M

	where M.DIRECCION_USUARIO_LOCALIDAD is not null  
end
go

--TipoCupon

create procedure NO_SE_BAJA_NADIE.Migrar_TiposCupon
as
 begin 	
	insert into NO_SE_BAJA_NADIE.cupon_tipo(TIPO)
		select distinct M.CUPON_TIPO
		
		from gd_esquema.Maestra M

 		where M.CUPON_TIPO is not null
end
go 


--Cupon

CREATE PROCEDURE NO_SE_BAJA_NADIE.Migrar_Cupones
AS
BEGIN
    SET IDENTITY_INSERT NO_SE_BAJA_NADIE.cupon ON;
    
    -- Migramos M.CUPON_NRO
    INSERT INTO NO_SE_BAJA_NADIE.cupon (CUPON_NRO, USUARIO_ID, CUPON_TIPO_ID, MONTO, FECHA_ALTA, FECHA_VENCIMIENTO)
    SELECT DISTINCT
        M.CUPON_NRO, 
        (SELECT USUARIO_ID FROM NO_SE_BAJA_NADIE.usuario WHERE DNI = M.USUARIO_DNI),
        (SELECT CUPON_TIPO_ID FROM NO_SE_BAJA_NADIE.cupon_tipo WHERE TIPO = M.CUPON_TIPO),
        M.CUPON_MONTO,
        M.CUPON_FECHA_ALTA,
        M.CUPON_FECHA_VENCIMIENTO
    FROM gd_esquema.Maestra M 
    WHERE M.CUPON_NRO IS NOT NULL AND M.CUPON_TIPO IS NOT NULL
    AND NOT EXISTS (
        SELECT 1
        FROM NO_SE_BAJA_NADIE.cupon C
        WHERE C.CUPON_NRO = M.CUPON_NRO
    );
    
    -- Migramos M.CUPON_RECLAMO_NRO
    INSERT INTO NO_SE_BAJA_NADIE.cupon (CUPON_NRO, USUARIO_ID, CUPON_TIPO_ID, MONTO, FECHA_ALTA, FECHA_VENCIMIENTO)
    SELECT DISTINCT
        M.CUPON_RECLAMO_NRO, 
        (SELECT USUARIO_ID FROM NO_SE_BAJA_NADIE.usuario WHERE DNI = M.USUARIO_DNI),
        (SELECT CUPON_TIPO_ID FROM NO_SE_BAJA_NADIE.cupon_tipo WHERE TIPO = M.CUPON_RECLAMO_TIPO),
        M.CUPON_MONTO,
        M.CUPON_FECHA_ALTA,
        M.CUPON_FECHA_VENCIMIENTO
    FROM gd_esquema.Maestra M 
    WHERE M.CUPON_RECLAMO_NRO IS NOT NULL AND M.CUPON_RECLAMO_TIPO IS NOT NULL
    AND NOT EXISTS (
        SELECT 1
        FROM NO_SE_BAJA_NADIE.cupon C
        WHERE C.CUPON_NRO = M.CUPON_RECLAMO_NRO
    );
    
    SET IDENTITY_INSERT NO_SE_BAJA_NADIE.cupon OFF;
END
GO


--pedidos_cupon
create procedure NO_SE_BAJA_NADIE.Migrar_PedidosCupon
as
begin
SET IDENTITY_INSERT NO_SE_BAJA_NADIE.cupon_pedido ON;
	insert into NO_SE_BAJA_NADIE.cupon_pedido(CUPON_NRO, PEDIDO_NRO, MONTO)
		
		select distinct (select CUPON_NRO from  NO_SE_BAJA_NADIE.cupon where CUPON_NRO  = M.CUPON_NRO ),

		(select PEDIDO_NRO from NO_SE_BAJA_NADIE.pedido where PEDIDO_NRO= M.PEDIDO_NRO ),

		M.CUPON_MONTO

		from gd_esquema.Maestra M 

		where M.CUPON_NRO is not null  AND M.PEDIDO_NRO is not null

		SET IDENTITY_INSERT NO_SE_BAJA_NADIE.cupon_pedido OFF;
end
go

--cupones por reclamo
create procedure NO_SE_BAJA_NADIE.Migrar_CuponesPorReclamos
as
begin
SET IDENTITY_INSERT NO_SE_BAJA_NADIE.cupon_por_reclamo ON;
	insert into NO_SE_BAJA_NADIE.cupon_por_reclamo(CUPON_NRO, RECLAMO_NRO , MONTO)
		
		select distinct (select CUPON_NRO from  NO_SE_BAJA_NADIE.cupon where CUPON_NRO  = M.CUPON_RECLAMO_NRO ),

		(select RECLAMO_NRO from NO_SE_BAJA_NADIE.reclamo where RECLAMO_NRO= M.RECLAMO_NRO ),

		M.CUPON_RECLAMO_MONTO

		from gd_esquema.Maestra M 

		where M.CUPON_RECLAMO_NRO is not null  AND M.RECLAMO_NRO is not null

		SET IDENTITY_INSERT NO_SE_BAJA_NADIE.cupon_por_reclamo OFF;
end
go

-- Usuario

CREATE PROCEDURE NO_SE_BAJA_NADIE.Migrar_Usuario
AS
BEGIN
 
             insert into NO_SE_BAJA_NADIE.usuario(DNI,APELLIDO,NOMBRE,FECHA_REGISTRO,TELEFONO,MAIL,FECHA_NAC)
            select distinct M.USUARIO_DNI, M.USUARIO_APELLIDO, M.USUARIO_NOMBRE, M.USUARIO_FECHA_REGISTRO,M.USUARIO_TELEFONO,M.USUARIO_MAIL,M.USUARIO_FECHA_NAC 
            from gd_esquema.Maestra M 
			where M.USUARIO_DNI is not null
end
go

--PEDIDO 

CREATE PROCEDURE NO_SE_BAJA_NADIE.Migrar_Pedido
AS
BEGIN
	SET IDENTITY_INSERT NO_SE_BAJA_NADIE.pedido ON;
	
	INSERT INTO NO_SE_BAJA_NADIE.pedido(PEDIDO_NRO, LOCAL_COD, USUARIO_ID, REPARTIDOR_ID, DIRECCION_USUARIO_CODIGO, ESTADO_PEDIDO_ID, MEDIO_PAGO_ID, TOTAL_PRODUCTOS, PRECIO_ENVIO, TARIFA_SERVICIO, PROPINA, TOTAL_CUPONES, TOTAL_SERVICIO, OBSERV, FECHA, FECHA_ENTREGA, TIEMPO_ESTIMADO_ENTREGA, CALIFICACION)
	SELECT DISTINCT
		M.PEDIDO_NRO,
		(SELECT TOP 1 LOCAL_COD FROM NO_SE_BAJA_NADIE.local WHERE NOMBRE = M.LOCAL_NOMBRE),
		(SELECT TOP 1 USUARIO_ID FROM NO_SE_BAJA_NADIE.usuario WHERE DNI = M.USUARIO_DNI),
		(SELECT TOP 1 REPARTIDOR_ID FROM NO_SE_BAJA_NADIE.repartidor WHERE DNI = M.REPARTIDOR_DNI),
		(SELECT TOP 1 DIRECCION_USUARIO_CODIGO FROM NO_SE_BAJA_NADIE.direccion_usuario WHERE DIRECCION = M.DIRECCION_USUARIO_DIRECCION),
		(SELECT TOP 1 ESTADO_PEDIDO_ID FROM NO_SE_BAJA_NADIE.estado_pedido WHERE ESTADO = M.PEDIDO_ESTADO),
		(SELECT TOP 1 MEDIO_PAGO_ID FROM NO_SE_BAJA_NADIE.medio_pago WHERE TIPO = M.MEDIO_PAGO_TIPO),		  
		M.PEDIDO_TOTAL_PRODUCTOS,
		M.PEDIDO_PRECIO_ENVIO,
		M.PEDIDO_TARIFA_SERVICIO,
		M.PEDIDO_PROPINA,
		M.PEDIDO_TOTAL_CUPONES,
		M.PEDIDO_TOTAL_SERVICIO,
		M.PEDIDO_OBSERV,
		M.PEDIDO_FECHA,
		M.PEDIDO_FECHA_ENTREGA,
		M.PEDIDO_TIEMPO_ESTIMADO_ENTREGA,
		M.PEDIDO_CALIFICACION
	FROM gd_esquema.Maestra M
	WHERE M.PEDIDO_NRO IS NOT NULL;
	
	SET IDENTITY_INSERT NO_SE_BAJA_NADIE.pedido OFF;
END
GO


-- Reclamos
CREATE PROCEDURE NO_SE_BAJA_NADIE.Migrar_Reclamo
AS
BEGIN
		SET IDENTITY_INSERT NO_SE_BAJA_NADIE.reclamo ON;
               insert into
NO_SE_BAJA_NADIE.reclamo(RECLAMO_NRO, OPERADOR_RECLAMO_ID, RECLAMO_TIPO_ID, ESTADO_RECLAMO_ID, PEDIDO_NRO,FECHA,DESCRIPCION,FECHA_SOLUCION,SOLUCION,CALIFICACION)
             select distinct M.RECLAMO_NRO, 
			(select TOP 1 OPERADOR_RECLAMO_ID FROM NO_SE_BAJA_NADIE.operador_reclamo where DNI = M.OPERADOR_RECLAMO_DNI),
			(SELECT TOP 1 RECLAMO_TIPO_ID FROM NO_SE_BAJA_NADIE.reclamo_tipo where TIPO = M.RECLAMO_TIPO),
			(SELECT TOP 1 ESTADO_RECLAMO_ID FROM NO_SE_BAJA_NADIE.estado_reclamo where ESTADO = M.RECLAMO_ESTADO),
			 (select TOP 1 PEDIDO_NRO from NO_SE_BAJA_NADIE.pedido where PEDIDO_NRO= M.PEDIDO_NRO ), 
							 M.RECLAMO_FECHA, 
							 M.RECLAMO_DESCRIPCION, 
							 M.RECLAMO_FECHA_SOLUCION,
							 M.RECLAMO_SOLUCION, 
							 M.RECLAMO_CALIFICACION

             from gd_esquema.Maestra M 
			 where M.RECLAMO_NRO is not null and M.PEDIDO_NRO is not null
			 SET IDENTITY_INSERT NO_SE_BAJA_NADIE.reclamo OFF;
end
go


print '**** Stored Procedures creados correctamente ****';

go

/********* Ejecucion de StoredProcedures para migracion *********/

--Tablas sin FKs (tienen que ir primero porque el resto de las tablas depende de estas)

EXECUTE NO_SE_BAJA_NADIE.Migrar_estados_reclamos;
EXECUTE NO_SE_BAJA_NADIE.Migrar_reclamos_tipos;
EXECUTE NO_SE_BAJA_NADIE.Migrar_Operadores;
EXECUTE NO_SE_BAJA_NADIE.Migrar_estados_mensajería;
EXECUTE NO_SE_BAJA_NADIE.Migrar_paquetes_tipos;
EXECUTE NO_SE_BAJA_NADIE.Migrar_estados_pedidos;
EXECUTE NO_SE_BAJA_NADIE.Migrar_Tipo_Locales;
EXECUTE NO_SE_BAJA_NADIE.Migrar_Tipo_Movilidades;
EXECUTE NO_SE_BAJA_NADIE.Migrar_Localidades;
EXECUTE NO_SE_BAJA_NADIE.Migrar_TiposCupon;
EXECUTE NO_SE_BAJA_NADIE.Migrar_Usuario;
EXECUTE NO_SE_BAJA_NADIE.Migrar_dias;

--Tablas con FKs (a tablas sin FKs)

EXECUTE NO_SE_BAJA_NADIE.Migrar_paquetes;
EXECUTE NO_SE_BAJA_NADIE.Migrar_Direcciones_Usuarios;
EXECUTE NO_SE_BAJA_NADIE.Migrar_Medio_Pagos;
EXECUTE NO_SE_BAJA_NADIE.Migrar_Repartidores;
EXECUTE NO_SE_BAJA_NADIE.Migrar_Local;
EXECUTE NO_SE_BAJA_NADIE.Migrar_Cupones;
EXECUTE NO_SE_BAJA_NADIE.Migrar_Categorias_Locales;

--Tablas con FKs (a tablas con FKs)

EXECUTE NO_SE_BAJA_NADIE.Migrar_Horario_Local;
EXECUTE NO_SE_BAJA_NADIE.Migrar_Envio_Mensajerias;
EXECUTE NO_SE_BAJA_NADIE.Migrar_MediosDePagoTarjeta;
EXECUTE NO_SE_BAJA_NADIE.Migrar_Pedido;
EXECUTE NO_SE_BAJA_NADIE.Migrar_Productos_Locales;
EXECUTE NO_SE_BAJA_NADIE.Migrar_Productos_Pedidos;
EXECUTE NO_SE_BAJA_NADIE.Migrar_PedidosCupon; 
EXECUTE NO_SE_BAJA_NADIE.Migrar_Reclamo; 
EXECUTE NO_SE_BAJA_NADIE.Migrar_catalogos;
EXECUTE NO_SE_BAJA_NADIE.Migrar_CuponesPorReclamos


IF (EXISTS (SELECT * FROM NO_SE_BAJA_NADIE.usuario)
AND EXISTS (SELECT * FROM  NO_SE_BAJA_NADIE.localidad)
AND EXISTS (SELECT * FROM  NO_SE_BAJA_NADIE.tipo_movilidad)
AND EXISTS (SELECT * FROM  NO_SE_BAJA_NADIE.local_tipo)
AND EXISTS (SELECT * FROM  NO_SE_BAJA_NADIE.local_categoria)
AND EXISTS (SELECT * FROM  NO_SE_BAJA_NADIE.estado_pedido)
AND EXISTS (SELECT * FROM  NO_SE_BAJA_NADIE.producto_local)
AND EXISTS (SELECT * FROM  NO_SE_BAJA_NADIE.catalogo_local)
AND EXISTS (SELECT * FROM  NO_SE_BAJA_NADIE.paquete_tipo)
AND EXISTS (SELECT * FROM  NO_SE_BAJA_NADIE.estado_mensajeria)
AND EXISTS (SELECT * FROM  NO_SE_BAJA_NADIE.operador_reclamo)
AND EXISTS (SELECT * FROM  NO_SE_BAJA_NADIE.reclamo_tipo)
AND EXISTS (SELECT * FROM  NO_SE_BAJA_NADIE.estado_reclamo)
AND EXISTS (SELECT * FROM  NO_SE_BAJA_NADIE.cupon_tipo)
AND EXISTS (SELECT * FROM  NO_SE_BAJA_NADIE.medio_pago_tarjeta)
AND EXISTS (SELECT * FROM  NO_SE_BAJA_NADIE.horario_local)
AND EXISTS (SELECT * FROM  NO_SE_BAJA_NADIE.dia)
AND EXISTS (SELECT * FROM  NO_SE_BAJA_NADIE.pedido)
AND EXISTS (SELECT * FROM  NO_SE_BAJA_NADIE.catalogo_local)
AND EXISTS (SELECT * FROM  NO_SE_BAJA_NADIE.producto_pedido)
AND EXISTS (SELECT * FROM  NO_SE_BAJA_NADIE.envio_mensajeria)
AND EXISTS (SELECT * FROM  NO_SE_BAJA_NADIE.reclamo)
AND EXISTS (SELECT * FROM  NO_SE_BAJA_NADIE.cupon_pedido)
AND EXISTS (SELECT * FROM  NO_SE_BAJA_NADIE.medio_pago)
AND EXISTS (SELECT * FROM  NO_SE_BAJA_NADIE.direccion_usuario)
AND EXISTS (SELECT * FROM  NO_SE_BAJA_NADIE.repartidor)
AND EXISTS (SELECT * FROM  NO_SE_BAJA_NADIE.local)
AND EXISTS (SELECT * FROM  NO_SE_BAJA_NADIE.paquete)
AND EXISTS (SELECT * FROM  NO_SE_BAJA_NADIE.cupon)
AND EXISTS (SELECT * FROM  NO_SE_BAJA_NADIE.cupon_por_reclamo)

)

PRINT 'Tablas migradas correctamente.';
   
GO

/*
DBCC CHECKIDENT ('NO_SE_BAJA_NADIE.local_categoria', RESEED,0)
DELETE FROM NO_SE_BAJA_NADIE.local_categoria;
DELETE FROM NO_SE_BAJA_NADIE.estado_reclamo;
DELETE FROM NO_SE_BAJA_NADIE.reclamo_tipo;
DELETE FROM NO_SE_BAJA_NADIE.operador_reclamo;
DELETE FROM NO_SE_BAJA_NADIE.estado_mensajeria;
DELETE FROM NO_SE_BAJA_NADIE.paquete_tipo;
DELETE FROM NO_SE_BAJA_NADIE.estado_pedido;
DELETE FROM NO_SE_BAJA_NADIE.local_tipo;
DELETE FROM NO_SE_BAJA_NADIE.tipo_movilidad;
DELETE FROM NO_SE_BAJA_NADIE.localidad;
DELETE FROM NO_SE_BAJA_NADIE.producto_local;
DELETE FROM NO_SE_BAJA_NADIE.cupon_tipo;
DELETE FROM NO_SE_BAJA_NADIE.dia;
DELETE FROM NO_SE_BAJA_NADIE.paquete;
DELETE FROM NO_SE_BAJA_NADIE.direccion_usuario;
DELETE FROM NO_SE_BAJA_NADIE.medio_Pago;
DELETE FROM NO_SE_BAJA_NADIE.repartidor;
DELETE FROM NO_SE_BAJA_NADIE.local;
DELETE FROM NO_SE_BAJA_NADIE.cupon;
DELETE FROM  NO_SE_BAJA_NADIE.horario_local;
DELETE FROM  NO_SE_BAJA_NADIE.envio_mensajeria;
DELETE FROM  NO_SE_BAJA_NADIE.medio_pago_tarjeta;
DELETE FROM  NO_SE_BAJA_NADIE.pedido;
DELETE FROM  NO_SE_BAJA_NADIE.catalogo_local;
DELETE FROM  NO_SE_BAJA_NADIE.producto_pedido;
DELETE FROM  NO_SE_BAJA_NADIE.cupon_pedido; 
DELETE FROM  NO_SE_BAJA_NADIE.reclamo; 
DELETE FROM  NO_SE_BAJA_NADIE.cupon_por_reclamo
DELETE FROM NO_SE_BAJA_NADIE.usuario;
*/
