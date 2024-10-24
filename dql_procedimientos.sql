-- 1.Procedimiento para procesar ventas y actualizar inventario
DELIMITER //
CREATE PROCEDURE procesar_venta(
    IN p_id_venta INT
)
BEGIN
    -- Procesar la venta
    DECLARE v_id_producto INT;
    DECLARE v_cantidad INT;
    
    -- Actualizar el inventario
    SELECT id_producto, cantidad
    INTO v_id_producto, v_cantidad
    FROM pedido
    WHERE id_venta = p_id_venta;
    
    UPDATE inventario
    SET cantidad = cantidad - v_cantidad
    WHERE id_producto = v_id_producto;
END//
DELIMITER ;

-- 2.Procedimiento para registrar nuevos proveedores
DELIMITER //
CREATE PROCEDURE registrar_proveedor(
    IN p_nombre_empresa VARCHAR(100),
    IN p_contacto_proveedor VARCHAR(100),
    IN p_id_finca INT
)
BEGIN
    INSERT INTO proveedores (nombre_empresa, contacto_proveedor, id_finca)
    VALUES (p_nombre_empresa, p_contacto_proveedor, p_id_finca);
END//
DELIMITER ;

-- 3.Procedimiento para registrar nuevos empleados
DELIMITER //
CREATE PROCEDURE registrar_empleado(
    IN p_nombre VARCHAR(100),
    IN p_id_cargo INT,
    IN p_salario DECIMAL,
    IN p_correo VARCHAR(100),
    IN p_id_estado_empleado INT
)
BEGIN
    INSERT INTO empleados (nombre, id_cargo, salario, correo, id_estado_empleado)
    VALUES (p_nombre, p_id_cargo, p_salario, p_correo, p_id_estado_empleado);
END//
DELIMITER ;

-- 4.Procedimiento para actualizar el estado de maquinaria
DELIMITER //
CREATE PROCEDURE actualizar_estado_maquinaria(
    IN p_id_maquina INT,
    IN p_nuevo_estado VARCHAR(100)
)
BEGIN
    UPDATE maquinaria
    SET estado = p_nuevo_estado
    WHERE id_maquina = p_id_maquina;
END//
DELIMITER ;

-- 5.Procedimiento para registrar un nuevo producto
DELIMITER //
CREATE PROCEDURE registrar_producto(
    IN p_nombre VARCHAR(100),
    IN p_tipo_producto VARCHAR(50),
    IN p_id_unidad_de_medida INT,
    IN p_id_precio_venta_u_medida INT
)
BEGIN
    INSERT INTO productos (nombre, tipo_producto, id_unidad_de_medida, id_precio_venta_u_medida)
    VALUES (p_nombre, p_tipo_producto, p_id_unidad_de_medida, p_id_precio_venta_u_medida);
END//
DELIMITER ;

-- 6.Procedimiento para actualizar el inventario tras una compra
DELIMITER //
CREATE PROCEDURE actualizar_inventario_compra(
    IN p_id_producto INT,
    IN p_cantidad INT
)
BEGIN
    UPDATE inventario
    SET cantidad = cantidad + p_cantidad
    WHERE id_producto = p_id_producto;
END//
DELIMITER ;

-- 7.Procedimiento para registrar un nuevo cliente
DELIMITER //
CREATE PROCEDURE registrar_cliente(
    IN p_nombre VARCHAR(100),
    IN p_telefono_cliente VARCHAR(100),
    IN p_email_cliente VARCHAR(100)
)
BEGIN
    INSERT INTO clientes (nombre, telefono_cliente, email_cliente)
    VALUES (p_nombre, p_telefono_cliente, p_email_cliente);
END//
DELIMITER ;

-- 8.Procedimiento para registrar una nueva venta
DELIMITER //
CREATE PROCEDURE registrar_venta(
    IN p_id_cliente INT,
    IN p_id_empleado INT,
    IN p_fecha_venta DATETIME,
    IN p_total DECIMAL
)
BEGIN
    INSERT INTO ventas (id_cliente, id_empleado, fecha_venta, total)
    VALUES (p_id_cliente, p_id_empleado, p_fecha_venta, p_total);
END//
DELIMITER ;

-- 9.Procedimiento para actualizar el salario de un empleado
DELIMITER //
CREATE PROCEDURE actualizar_salario_empleado(
    IN p_id_empleado INT,
    IN p_nuevo_salario DECIMAL
)
BEGIN
    UPDATE empleados
    SET salario = p_nuevo_salario
    WHERE id_empleado = p_id_empleado;
END//
DELIMITER ;

-- 10.Procedimiento para registrar un proceso de un producto
DELIMITER //
CREATE PROCEDURE registrar_proceso_producto(
    IN p_id_producto INT,
    IN p_id_proceso INT
)
BEGIN
    INSERT INTO producto_proceso (id_producto, id_proceso)
    VALUES (p_id_producto, p_id_proceso);
END//
DELIMITER ;

-- 11.Procedimiento para registrar una compra
DELIMITER //
CREATE PROCEDURE registrar_compra(
    IN p_id_proveedor INT,
    IN p_fecha_compra DATETIME,
    IN p_total DECIMAL
)
BEGIN
    INSERT INTO compras (id_proveedor, fecha_compra, total)
    VALUES (p_id_proveedor, p_fecha_compra, p_total);
END//
DELIMITER ;

-- 12.Procedimiento para actualizar el estado de vacaciones de un empleado
DELIMITER //
CREATE PROCEDURE actualizar_estado_vacaciones(
    IN p_id_empleado INT,
    IN p_id_estado_vacaciones INT
)
BEGIN
    UPDATE vacaciones
    SET id_estado_vacaciones = p_id_estado_vacaciones
    WHERE id_empleado = p_id_empleado;
END//
DELIMITER ;

-- 13.Procedimiento para registrar un nuevo reporte de gastos
DELIMITER //
CREATE PROCEDURE registrar_reporte_gastos(
    IN p_fecha_reporte DATETIME,
    IN p_total DECIMAL
)
BEGIN
    INSERT INTO reporte_gastos (fecha_reporte, total)
    VALUES (p_fecha_reporte, p_total);
END//
DELIMITER ;

-- 14.Procedimiento para asignar una máquina a un proceso
DELIMITER //
CREATE PROCEDURE asignar_maquina_a_proceso(
    IN p_id_maquina INT,
    IN p_id_proceso INT
)
BEGIN
    INSERT INTO procesos_maquinas (id_maquina, id_proceso)
    VALUES (p_id_maquina, p_id_proceso);
END//
DELIMITER ;

-- 15.Procedimiento para actualizar el estado de pago de un empleado
DELIMITER //
CREATE PROCEDURE actualizar_estado_pago_empleado(
    IN p_id_empleado INT,
    IN p_estado_pago VARCHAR(50)
)
BEGIN
    UPDATE pago_empleados
    SET estado_pago = p_estado_pago
    WHERE id_empleado = p_id_empleado;
END//
DELIMITER ;

-- 16.Procedimiento para registrar una nueva dirección
DELIMITER //
CREATE PROCEDURE registrar_direccion(
    IN p_direccion VARCHAR(255),
    IN p_id_ciudad INT
)
BEGIN
    INSERT INTO direccion (direccion, id_ciudad)
    VALUES (p_direccion, p_id_ciudad);
END//
DELIMITER ;

-- 17.Procedimiento para asignar un empleado a un proceso
DELIMITER //
CREATE PROCEDURE asignar_empleado_a_proceso(
    IN p_id_empleado INT,
    IN p_id_proceso INT
)
BEGIN
    INSERT INTO procesos_empleados (id_empleado, id_proceso)
    VALUES (p_id_empleado, p_id_proceso);
END//
DELIMITER ;

-- 18.Procedimiento para registrar un pedido
DELIMITER //
CREATE PROCEDURE registrar_pedido(
    IN p_id_cliente INT,
    IN p_id_venta INT,
    IN p_id_insumo INT
)
BEGIN
    INSERT INTO pedido (id_cliente, id_venta, id_insumo)
    VALUES (p_id_cliente, p_id_venta, p_id_insumo);
END//
DELIMITER ;

-- 19.Procedimiento para registrar una nueva finca
DELIMITER //
CREATE PROCEDURE registrar_finca(
    IN p_nombre VARCHAR(100),
    IN p_id_direccion INT
)
BEGIN
    INSERT INTO finca (nombre, id_direccion)
    VALUES (p_nombre, p_id_direccion);
END//
DELIMITER ;

-- 20.Procedimiento para registrar el pago de un empleado
DELIMITER //
CREATE PROCEDURE registrar_pago_empleado(
    IN p_id_empleado INT,
    IN p_fecha_pago DATETIME,
    IN p_estado_pago VARCHAR(50)
)
BEGIN
    INSERT INTO pago_empleados (id_empleado, fecha_pago, estado_pago)
    VALUES (p_id_empleado, p_fecha_pago, p_estado_pago);
END//
DELIMITER ;

