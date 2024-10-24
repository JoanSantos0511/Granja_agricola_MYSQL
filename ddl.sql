-- Active: 1729309147950@@127.0.0.1@3306@granja_agricolamysql
CREATE DATABASE granja_agricolaMYSQL;

USE granja_agricolaMYSQL

-- Tabla continente
CREATE TABLE continente (
    id_continente INTEGER PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);

-- Tabla insumos
CREATE TABLE insumos (
    id_insumo INTEGER PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);

-- Tabla unidad_medida
CREATE TABLE unidad_medida (
    id_unidad_de_medida INTEGER PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);

-- Tabla precio_venta_u_medida
CREATE TABLE precio_venta_u_medida (
    id_precio_venta_u_medida INTEGER PRIMARY KEY,
    valor DECIMAL NOT NULL
);

-- Tabla tipo_proceso
CREATE TABLE tipo_proceso (
    id_tipo_proceso INTEGER PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL
);

-- Tabla tipo_maquina
CREATE TABLE tipo_maquina (
    id_tipo_maquina INTEGER PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    modelo VARCHAR(100)
);

-- Tabla maquinaria
CREATE TABLE maquinaria (
    id_maquina INTEGER PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    id_tipo_maquina INTEGER,
    FOREIGN KEY (id_tipo_maquina) REFERENCES tipo_maquina(id_tipo_maquina)
);



-- Tabla clientes
CREATE TABLE clientes (
    id_cliente INTEGER PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    telefono_cliente VARCHAR(100),
    email_cliente VARCHAR(100)
);


-- Tabla Cargo
CREATE TABLE Cargo (
    id_cargo INTEGER PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);

-- Tabla estados_empleados
CREATE TABLE estados_empleados (
    id_estado_empleado INTEGER PRIMARY KEY,
    estado VARCHAR(50) NOT NULL
);

-- Tabla estado_vacaciones
CREATE TABLE estado_vacaciones (
    id_estado_vacaciones INTEGER PRIMARY KEY,
    estado VARCHAR(100)
);

-- Tabla reporte_gastos
CREATE TABLE reporte_gastos (
    id_reporte INTEGER PRIMARY KEY,
    fecha_reporte DATETIME,
    total DECIMAL
);

--Tabla tipo_inventario
CREATE TABLE tipo_inventario (
    id_tipo_inventario INTEGER PRIMARY KEY,
    nombre VARCHAR(100)
);

-- Tabla de notificaciones
CREATE TABLE notificaciones (
    id_notificacion INTEGER PRIMARY KEY,
    mensaje VARCHAR(255) NOT NULL,
    fecha DATETIME NOT NULL
);

-- Tabla empleados
CREATE TABLE empleados (
    id_empleado INTEGER PRIMARY KEY,
    id_cargo INTEGER,
    nombre VARCHAR(100) NOT NULL,
    salario DECIMAL,
    correo VARCHAR(100),
    id_estado_empleado INTEGER,
    FOREIGN KEY (id_cargo) REFERENCES Cargo(id_cargo),
    FOREIGN KEY (id_estado_empleado) REFERENCES estados_empleados(id_estado_empleado)
);
-- Tabla pais
CREATE TABLE pais (
    id_pais INTEGER PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    id_continente INTEGER,
    FOREIGN KEY (id_continente) REFERENCES continente(id_continente)
);

-- Tabla ciudad
CREATE TABLE ciudad (
    id_ciudad INTEGER PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    id_pais INTEGER,
    FOREIGN KEY (id_pais) REFERENCES pais(id_pais)
);

-- Tabla direccion
CREATE TABLE direccion (
    id_direccion INTEGER PRIMARY KEY,
    direccion VARCHAR(255) NOT NULL,
    id_ciudad INTEGER,
    FOREIGN KEY (id_ciudad) REFERENCES ciudad(id_ciudad)
);

-- Tabla finca
CREATE TABLE finca (
    id_finca INTEGER PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    id_direccion INTEGER,
    FOREIGN KEY (id_direccion) REFERENCES direccion(id_direccion)
);

-- Tabla proveedores
CREATE TABLE proveedores (
    id_proveedor INTEGER PRIMARY KEY,
    nombre_empresa VARCHAR(100) NOT NULL,
    contacto_proveedor VARCHAR(100),
    id_finca INTEGER,
    FOREIGN KEY (id_finca) REFERENCES finca(id_finca)
);

-- Tabla compras
CREATE TABLE compras (
    id_compra INTEGER PRIMARY KEY,
    id_proveedor INTEGER,
    fecha_compra DATETIME,
    total DECIMAL,
    FOREIGN KEY (id_proveedor) REFERENCES proveedores(id_proveedor)
);

-- Tabla productos
CREATE TABLE productos (
    id_producto INTEGER PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    tipo_producto VARCHAR(50),
    id_unidad_de_medida INTEGER,
    id_precio_venta_u_medida INTEGER,
    FOREIGN KEY (id_unidad_de_medida) REFERENCES unidad_medida(id_unidad_de_medida),
    FOREIGN KEY (id_precio_venta_u_medida) REFERENCES precio_venta_u_medida(id_precio_venta_u_medida)
);

-- Tabla procesos
CREATE TABLE procesos (
    id_proceso INTEGER PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    id_tipo_proceso INTEGER,
    FOREIGN KEY (id_tipo_proceso) REFERENCES tipo_proceso(id_tipo_proceso)
);

-- Tabla producto_proceso
CREATE TABLE producto_proceso (
    id_proceso_producto INTEGER PRIMARY KEY,
    id_producto INTEGER,
    id_proceso INTEGER,
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto),
    FOREIGN KEY (id_proceso) REFERENCES procesos(id_proceso)
);


-- Tabla ventas
CREATE TABLE ventas (
    id_venta INTEGER PRIMARY KEY,
    id_cliente INTEGER,
    id_empleado INTEGER,
    fecha_venta DATETIME,
    total DECIMAL,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
    FOREIGN KEY (id_empleado) REFERENCES empleados(id_empleado)
);

-- Tabla pedido
CREATE TABLE pedido (
    id_pedido INTEGER PRIMARY KEY,
    id_cliente INTEGER,
    id_venta INTEGER,
    id_insumo INTEGER,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
    FOREIGN KEY (id_venta) REFERENCES ventas(id_venta),
    FOREIGN KEY (id_insumo) REFERENCES insumos(id_insumo)
);

-- Tabla pago_empleados
CREATE TABLE pago_empleados (
    id_pago_empleado INTEGER PRIMARY KEY,
    id_empleado INTEGER,
    fecha_pago DATETIME,
    estado_pago VARCHAR(50),
    FOREIGN KEY (id_empleado) REFERENCES empleados(id_empleado)
);

-- Tabla ventas_empleados
CREATE TABLE ventas_empleados (
    id_empleado INTEGER,
    id_venta INTEGER,
    PRIMARY KEY (id_empleado, id_venta),
    FOREIGN KEY (id_empleado) REFERENCES empleados(id_empleado),
    FOREIGN KEY (id_venta) REFERENCES ventas(id_venta)
);

-- Tabla vacaciones
CREATE TABLE vacaciones (
    id_vacaciones INTEGER PRIMARY KEY,
    fecha_vacaciones DATETIME,
    id_empleado INTEGER,
    id_estado_vacaciones INTEGER,
    FOREIGN KEY (id_empleado) REFERENCES empleados(id_empleado),
    FOREIGN KEY (id_estado_vacaciones) REFERENCES estado_vacaciones(id_estado_vacaciones)
);



-- Tabla procesos_empleados
CREATE TABLE procesos_empleados (
    id_proceso_empleado INTEGER PRIMARY KEY,
    id_empleado INTEGER,
    id_proceso INTEGER,
    FOREIGN KEY (id_empleado) REFERENCES empleados(id_empleado),
    FOREIGN KEY (id_proceso) REFERENCES procesos(id_proceso)
);

-- Tabla procesos_maquinas
CREATE TABLE procesos_maquinas (
    id_proceso_maquina INTEGER PRIMARY KEY,
    id_proceso INTEGER,
    id_maquina INTEGER,
    FOREIGN KEY (id_proceso) REFERENCES procesos(id_proceso),
    FOREIGN KEY (id_maquina) REFERENCES maquinaria(id_maquina)
);

--Tabla inventario
CREATE TABLE inventario (
    id_inventario INTEGER PRIMARY KEY,
    nombre VARCHAR(100),
    id_tipo_inventario INTEGER,
    id_finca INTEGER,
    FOREIGN KEY (id_tipo_inventario) REFERENCES tipo_inventario(id_tipo_inventario),
    FOREIGN KEY (id_finca) REFERENCES finca(id_finca)
);

--Tabla pago_empleado_empleados
CREATE TABLE pago_empleado_empleados (
    id_pago_empleado INTEGER,
    id_empleado INTEGER,
    FOREIGN KEY (id_pago_empleado) REFERENCES pago_empleados(id_pago_empleado),
    FOREIGN KEY (id_empleado) REFERENCES empleados(id_empleado)
);

-- Tabla de eventos
CREATE TABLE eventos (
    id_evento INTEGER PRIMARY KEY,
    tipo_evento VARCHAR(100) NOT NULL,
    descripcion TEXT NOT NULL,
    fecha_evento DATETIME NOT NULL,
    id_empleado INTEGER,
    FOREIGN KEY (id_empleado) REFERENCES empleados(id_empleado)
);

-- Tabla de asistencia_eventos
CREATE TABLE asistencia_eventos (
    id_asistencia_evento INTEGER PRIMARY KEY,
    id_evento INTEGER,
    id_empleado INTEGER,
    estado_asistencia VARCHAR(50) NOT NULL,
    FOREIGN KEY (id_evento) REFERENCES eventos(id_evento),
    FOREIGN KEY (id_empleado) REFERENCES empleados(id_empleado)
);























































