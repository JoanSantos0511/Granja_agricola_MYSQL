-- 1.Trigger para actualizar inventario al registrar una nueva venta
CREATE TRIGGER actualizar_inventario_venta
AFTER INSERT ON ventas
FOR EACH ROW
BEGIN
    UPDATE inventario
    SET cantidad = cantidad - 1
    WHERE id_producto = (SELECT id_producto FROM pedido WHERE id_venta = NEW.id_venta);
END;

-- 2.Trigger para registrar el cambio de salario de empleados
CREATE TRIGGER registrar_historial_cambio_salario
AFTER UPDATE ON empleados
FOR EACH ROW
BEGIN
    IF NEW.salario != OLD.salario THEN
        INSERT INTO historial_salarios (id_empleado, salario_anterior, nuevo_salario, fecha_cambio)
        VALUES (NEW.id_empleado, OLD.salario, NEW.salario, NOW());
    END IF;
END;

-- 3.Trigger para verificar la disponibilidad de maquinaria antes de asignarla
CREATE TRIGGER verificar_disponibilidad_maquinaria
BEFORE INSERT ON procesos_maquinas
FOR EACH ROW
BEGIN
    DECLARE maquinaria_disponible BOOLEAN;
    SET maquinaria_disponible = (SELECT COUNT(*) = 0 FROM procesos_maquinas WHERE id_maquina = NEW.id_maquina);
    IF maquinaria_disponible = FALSE THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La maquinaria ya está asignada a otro proceso.';
    END IF;
END;

-- 4.Trigger para evitar duplicados en la tabla de clientes
CREATE TRIGGER evitar_duplicados_cliente
BEFORE INSERT ON clientes
FOR EACH ROW
BEGIN
    IF EXISTS (SELECT 1 FROM clientes WHERE email_cliente = NEW.email_cliente) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El cliente con este email ya existe.';
    END IF;
END;

-- 5.Trigger para verificar que los insumos no se queden sin stock al realizar un pedido
CREATE TRIGGER verificar_stock_insumos
BEFORE INSERT ON pedido
FOR EACH ROW
BEGIN
    DECLARE stock_disponible INT;
    SET stock_disponible = (SELECT cantidad FROM inventario WHERE id_insumo = NEW.id_insumo);
    IF stock_disponible <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No hay suficiente stock de insumos.';
    END IF;
END;

-- 6.Trigger para registrar un historial de pagos de empleados
CREATE TRIGGER registrar_historial_pagos
AFTER INSERT ON pago_empleados
FOR EACH ROW
BEGIN
    INSERT INTO historial_pagos_empleados (id_empleado, fecha_pago, estado_pago)
    VALUES (NEW.id_empleado, NEW.fecha_pago, NEW.estado_pago);
END;

-- 7.Trigger para asegurar que las vacaciones de los empleados no se superpongan
CREATE TRIGGER verificar_superposicion_vacaciones
BEFORE INSERT ON vacaciones
FOR EACH ROW
BEGIN
    IF EXISTS (SELECT 1 FROM vacaciones WHERE id_empleado = NEW.id_empleado AND fecha_vacaciones = NEW.fecha_vacaciones) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El empleado ya tiene vacaciones en esta fecha.';
    END IF;
END;

-- 8.Trigger para verificar que el total de una compra no sea negativo
CREATE TRIGGER verificar_total_compra
BEFORE INSERT ON compras
FOR EACH ROW
BEGIN
    IF NEW.total < 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El total de la compra no puede ser negativo.';
    END IF;
END;

-- 9.Trigger para registrar el historial de procesos de productos
CREATE TRIGGER registrar_historial_proceso_producto
AFTER INSERT ON producto_proceso
FOR EACH ROW
BEGIN
    INSERT INTO historial_procesos_producto (id_producto, id_proceso, fecha_proceso)
    VALUES (NEW.id_producto, NEW.id_proceso, NOW());
END;

-- 20.Trigger para asegurar que un empleado no esté asignado a más de un proceso al mismo tiempo
CREATE TRIGGER verificar_asignacion_empleado_proceso
BEFORE INSERT ON procesos_empleados
FOR EACH ROW
BEGIN
    IF EXISTS (SELECT 1 FROM procesos_empleados WHERE id_empleado = NEW.id_empleado AND id_proceso = NEW.id_proceso) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El empleado ya está asignado a este proceso.';
    END IF;
END;

-- 11.Trigger para evitar que el total de ventas sea menor al costo de producción
CREATE TRIGGER verificar_total_venta
BEFORE INSERT ON ventas
FOR EACH ROW
BEGIN
    DECLARE total_produccion DECIMAL;
    SET total_produccion = (SELECT SUM(precio_venta_u_medida.valor) FROM productos WHERE id_producto = NEW.id_venta);
    IF NEW.total < total_produccion THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El total de la venta no puede ser menor al costo de producción.';
    END IF;
END;

-- 12.Trigger para actualizar el stock del inventario al realizar una compra
CREATE TRIGGER actualizar_inventario_compra
AFTER INSERT ON compras
FOR EACH ROW
BEGIN
    UPDATE inventario
    SET cantidad = cantidad + 1
    WHERE id_producto = (SELECT id_producto FROM insumos WHERE id_proveedor = NEW.id_proveedor);
END;

-- 13.Trigger para bloquear la eliminación de un cliente si tiene pedidos pendientes
CREATE TRIGGER bloquear_eliminacion_cliente_pedido
BEFORE DELETE ON clientes
FOR EACH ROW
BEGIN
    IF EXISTS (SELECT 1 FROM pedido WHERE id_cliente = OLD.id_cliente) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No se puede eliminar el cliente con pedidos pendientes.';
    END IF;
END;

-- 14.Trigger para registrar cualquier modificación en la información de clientes
CREATE TRIGGER registrar_modificacion_cliente
AFTER UPDATE ON clientes
FOR EACH ROW
BEGIN
    INSERT INTO historial_modificaciones_cliente (id_cliente, cambio, fecha)
    VALUES (NEW.id_cliente, CONCAT('Modificación: ', OLD.nombre, ' a ', NEW.nombre), NOW());
END;

-- 15.Trigger para verificar la capacidad de la finca antes de asignarle un inventario adicional
CREATE TRIGGER verificar_capacidad_finca
BEFORE INSERT ON inventario
FOR EACH ROW
BEGIN
    DECLARE capacidad_actual INT;
    SET capacidad_actual = (SELECT COUNT(*) FROM inventario WHERE id_finca = NEW.id_finca);
    IF capacidad_actual >= 100 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La finca no puede almacenar más inventario.';
    END IF;
END;

-- 16.Trigger para evitar la inserción de registros duplicados en la tabla de maquinaria
CREATE TRIGGER evitar_duplicados_maquinaria
BEFORE INSERT ON maquinaria
FOR EACH ROW
BEGIN
    IF EXISTS (SELECT 1 FROM maquinaria WHERE nombre = NEW.nombre AND id_tipo_maquina = NEW.id_tipo_maquina) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La maquinaria ya está registrada.';
    END IF;
END;

-- 17.Trigger para actualizar el estado de pago de un empleado después de realizar un pago
CREATE TRIGGER actualizar_estado_pago_empleado
AFTER INSERT ON pago_empleados
FOR EACH ROW
BEGIN
    UPDATE empleados
    SET estado_pago = 'Pagado'
    WHERE id_empleado = NEW.id_empleado;
END;

-- 18.Trigger para prevenir que se inserten fechas de reporte de gastos en el futuro
CREATE TRIGGER verificar_fecha_reporte_gastos
BEFORE INSERT ON reporte_gastos
FOR EACH ROW
BEGIN
    IF NEW.fecha_reporte > NOW() THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La fecha del reporte no puede estar en el futuro.';
    END IF;
END;

-- 19.Trigger para registrar el historial de compras de proveedores
CREATE TRIGGER registrar_historial_compras_proveedor
AFTER INSERT ON compras
FOR EACH ROW
BEGIN
    INSERT INTO historial_compras_proveedor (id_proveedor, total_compra, fecha_compra)
    VALUES (NEW.id_proveedor, NEW.total, NEW.fecha_compra);
END;

-- 20.Trigger para validar que el total de un pedido no sea negativo
CREATE TRIGGER verificar_total_pedido
BEFORE INSERT ON pedido
FOR EACH ROW
BEGIN
    IF NEW.total < 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El total del pedido no puede ser negativo.';
    END IF;
END;
