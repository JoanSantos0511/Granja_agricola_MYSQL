-- 1.Función para calcular el rendimiento promedio por hectárea de un cultivo
DELIMITER //
CREATE FUNCTION calcular_rendimiento_promedio_por_hectarea(p_id_producto INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE v_rendimiento DECIMAL(10,2);
    SELECT AVG(rendimiento) INTO v_rendimiento
    FROM procesos
    WHERE id_producto = p_id_producto;
    RETURN v_rendimiento;
END//
DELIMITER ;

-- 2.Función para estimar el costo operativo total de la finca en un periodo de tiempo
DELIMITER //
CREATE FUNCTION estimar_costo_operativo(p_fecha_inicio DATE, p_fecha_fin DATE)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE v_total DECIMAL(10,2);
    SELECT SUM(total) INTO v_total
    FROM reporte_gastos
    WHERE fecha_reporte BETWEEN p_fecha_inicio AND p_fecha_fin;
    RETURN v_total;
END//
DELIMITER ;

-- 3.Función para calcular el salario promedio de los empleados
DELIMITER //
CREATE FUNCTION salario_promedio_empleados()
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE v_salario_promedio DECIMAL(10,2);
    SELECT AVG(salario) INTO v_salario_promedio
    FROM empleados;
    RETURN v_salario_promedio;
END//
DELIMITER ;

-- 4.Función para obtener el total de ventas realizadas en un periodo
DELIMITER //
CREATE FUNCTION total_ventas_periodo(p_fecha_inicio DATE, p_fecha_fin DATE)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE v_total_ventas DECIMAL(10,2);
    SELECT SUM(total) INTO v_total_ventas
    FROM ventas
    WHERE fecha_venta BETWEEN p_fecha_inicio AND p_fecha_fin;
    RETURN v_total_ventas;
END//
DELIMITER ;

-- 5.Función para contar el número de empleados activos
DELIMITER //
CREATE FUNCTION contar_empleados_activos()
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE v_numero_empleados INT;
    SELECT COUNT(*) INTO v_numero_empleados
    FROM empleados
    WHERE id_estado_empleado = 1; -- Estado "activo"
    RETURN v_numero_empleados;
END//
DELIMITER ;

-- 6.Función para calcular el inventario total por tipo de producto
DELIMITER //
CREATE FUNCTION calcular_inventario_total_por_tipo(p_id_tipo_inventario INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE v_inventario_total INT;
    SELECT SUM(cantidad) INTO v_inventario_total
    FROM inventario
    WHERE id_tipo_inventario = p_id_tipo_inventario;
    RETURN v_inventario_total;
END//
DELIMITER ;

-- 7.Función para calcular el promedio de ventas por cliente
DELIMITER //
CREATE FUNCTION promedio_ventas_por_cliente(p_id_cliente INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE v_promedio_ventas DECIMAL(10,2);
    SELECT AVG(total) INTO v_promedio_ventas
    FROM ventas
    WHERE id_cliente = p_id_cliente;
    RETURN v_promedio_ventas;
END//
DELIMITER ;

-- 8.Función para calcular el total de pagos realizados a un empleado
DELIMITER //
CREATE FUNCTION total_pagos_empleado(p_id_empleado INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE v_total_pagos DECIMAL(10,2);
    SELECT SUM(estado_pago) INTO v_total_pagos
    FROM pago_empleados
    WHERE id_empleado = p_id_empleado;
    RETURN v_total_pagos;
END//
DELIMITER ;

-- 9.Función para calcular el costo total de maquinaria por proceso
DELIMITER //
CREATE FUNCTION costo_maquinaria_por_proceso(p_id_proceso INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE v_costo_total DECIMAL(10,2);
    SELECT SUM(m.costo) INTO v_costo_total
    FROM procesos_maquinas pm
    JOIN maquinaria m ON pm.id_maquina = m.id_maquina
    WHERE pm.id_proceso = p_id_proceso;
    RETURN v_costo_total;
END//
DELIMITER ;

-- 10.Función para obtener el número de procesos realizados por empleado
DELIMITER //
CREATE FUNCTION contar_procesos_por_empleado(p_id_empleado INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE v_total_procesos INT;
    SELECT COUNT(*) INTO v_total_procesos
    FROM procesos_empleados
    WHERE id_empleado = p_id_empleado;
    RETURN v_total_procesos;
END//
DELIMITER ;

-- 11.Función para calcular el promedio de días de vacaciones por empleado
DELIMITER //
CREATE FUNCTION promedio_vacaciones_empleados()
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE v_promedio_dias DECIMAL(10,2);
    SELECT AVG(DATEDIFF(fecha_fin, fecha_inicio)) INTO v_promedio_dias
    FROM vacaciones;
    RETURN v_promedio_dias;
END//
DELIMITER ;

-- 12.Función para calcular el total de compras realizadas a un proveedor
DELIMITER //
CREATE FUNCTION total_compras_proveedor(p_id_proveedor INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE v_total_compras DECIMAL(10,2);
    SELECT SUM(total) INTO v_total_compras
    FROM compras
    WHERE id_proveedor = p_id_proveedor;
    RETURN v_total_compras;
END//
DELIMITER ;

-- 13.Función para calcular el costo promedio de insumos por compra
DELIMITER //
CREATE FUNCTION costo_promedio_insumos()
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE v_costo_promedio DECIMAL(10,2);
    SELECT AVG(total) INTO v_costo_promedio
    FROM compras;
    RETURN v_costo_promedio;
END//
DELIMITER ;

-- 14.Función para obtener el número de ventas por empleado
DELIMITER //
CREATE FUNCTION contar_ventas_por_empleado(p_id_empleado INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE v_total_ventas INT;
    SELECT COUNT(*) INTO v_total_ventas
    FROM ventas
    WHERE id_empleado = p_id_empleado;
    RETURN v_total_ventas;
END//
DELIMITER ;

-- 15.Función para calcular el total de pagos realizados en un periodo
DELIMITER //
CREATE FUNCTION total_pagos_periodo(p_fecha_inicio DATE, p_fecha_fin DATE)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE v_total_pagos DECIMAL(10,2);
    SELECT SUM(total) INTO v_total_pagos
    FROM pago_empleados
    WHERE fecha_pago BETWEEN p_fecha_inicio AND p_fecha_fin;
    RETURN v_total_pagos;
END//
DELIMITER ;

-- 16.Función para calcular el precio promedio de venta de productos
DELIMITER //
CREATE FUNCTION precio_promedio_venta_productos()
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE v_precio_promedio DECIMAL(10,2);
    SELECT AVG(valor) INTO v_precio_promedio
    FROM precio_venta_u_medida;
    RETURN v_precio_promedio;
END//
DELIMITER ;

-- 17.Función para calcular el inventario disponible de un producto
DELIMITER //
CREATE FUNCTION inventario_disponible_producto(p_id_producto INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE v_inventario_disponible INT;
    SELECT cantidad INTO v_inventario_disponible
    FROM inventario
    WHERE id_producto = p_id_producto;
    RETURN v_inventario_disponible;
END//
DELIMITER ;

-- 18.Función para calcular el total de gastos operativos en un periodo
DELIMITER //
CREATE FUNCTION total_gastos_operativos_periodo(p_fecha_inicio DATE, p_fecha_fin DATE)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE v_total_gastos DECIMAL(10,2);
    SELECT SUM(total) INTO v_total_gastos
    FROM reporte_gastos
    WHERE fecha_reporte BETWEEN p_fecha_inicio AND p_fecha_fin;
    RETURN v_total_gastos;
END//
DELIMITER ;

-- 19.Función para calcular el promedio de cantidad de productos vendidos por venta
DELIMITER //
CREATE FUNCTION promedio_productos_por_venta()
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE v_promedio_productos DECIMAL(10,2);
    SELECT AVG(cantidad) INTO v_promedio_productos
    FROM pedido;
    RETURN v_promedio_productos;
END//
DELIMITER ;

-- 20.Función para contar el número de procesos realizados en la finca
DELIMITER //
CREATE FUNCTION contar_procesos_finca(p_id_finca INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE v_total_procesos INT;
    SELECT COUNT(*) INTO v_total_procesos
    FROM procesos
    WHERE id_finca = p_id_finca;
    RETURN v_total_procesos;
END//
DELIMITER ;
