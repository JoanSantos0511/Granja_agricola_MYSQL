-- 1. Actualizar Stock de Insumos Diariamente
DELIMITER //
CREATE EVENT actualizar_stock_insumos
ON SCHEDULE EVERY 1 DAY
DO
BEGIN
    
    UPDATE inventario SET cantidad = cantidad - (SELECT SUM(cantidad) FROM ventas WHERE id_insumo = inventario.id_insumo);
END//
DELIMITER ;

-- 2. Notificación de Vacaciones de Empleados
DELIMITER //
CREATE EVENT notificacion_vacaciones_empleados
ON SCHEDULE EVERY 1 WEEK
DO
BEGIN

    INSERT INTO notificaciones (mensaje, fecha) 
    SELECT CONCAT('Solicitudes de vacaciones pendientes para: ', nombre) AS mensaje, NOW()
    FROM empleados WHERE estado_vacaciones = 'Pendiente';
END//
DELIMITER ;

-- 3. Registro de Compras Mensuales
DELIMITER //
CREATE EVENT registro_compras_mensuales
ON SCHEDULE EVERY 1 MONTH
DO
BEGIN
 
    INSERT INTO informes_compras (total_compras, mes, anio)
    SELECT SUM(total), MONTH(fecha_compra), YEAR(fecha_compra)
    FROM compras WHERE MONTH(fecha_compra) = MONTH(NOW()) AND YEAR(fecha_compra) = YEAR(NOW());
END//
DELIMITER ;

-- 4. Actualizar Precios de Venta Cada Trimestre
DELIMITER //
CREATE EVENT actualizar_precios_venta
ON SCHEDULE EVERY 3 MONTH
DO
BEGIN
  
    UPDATE productos SET precio_venta = precio_venta * 1.05; 
END//
DELIMITER ;

-- 5. Enviar Recordatorios de Pago a Proveedores
DELIMITER //
CREATE EVENT enviar_recordatorios_pago
ON SCHEDULE EVERY 1 WEEK
DO
BEGIN
   
    INSERT INTO notificaciones (mensaje, fecha) 
    SELECT CONCAT('Recordatorio de pago pendiente para el proveedor: ', nombre), NOW()
    FROM proveedores WHERE estado_pago = 'Pendiente';
END//
DELIMITER ;

-- 6. Generar Reporte de Gastos Semanalmente
DELIMITER //
CREATE EVENT generar_reporte_gastos
ON SCHEDULE EVERY 1 WEEK
DO
BEGIN
   
    INSERT INTO informes_gastos (total_gastos, fecha_reporte)
    SELECT SUM(total), NOW() FROM reporte_gastos WHERE fecha_reporte >= NOW() - INTERVAL 7 DAY;
END//
DELIMITER ;

-- 7. Actualizar Estado de Ventas Mensualmente
DELIMITER //
CREATE EVENT actualizar_estado_ventas
ON SCHEDULE EVERY 1 MONTH
DO
BEGIN
 
    UPDATE ventas SET estado = 'Mensual' WHERE MONTH(fecha) = MONTH(NOW()) AND estado = 'Pendiente';
END//
DELIMITER ;

-- 8. Cerrar el Registro de Compras a Fin de Mes
DELIMITER //
CREATE EVENT cerrar_registro_compras
ON SCHEDULE LAST DAY OF MONTH
DO
BEGIN
  
    INSERT INTO informes_cierre_compras (fecha_cierre, total_compras)
    SELECT NOW(), SUM(total) FROM compras WHERE MONTH(fecha_compra) = MONTH(NOW());
END//
DELIMITER ;

-- 9. Enviar Notificaciones de Inventario Bajo
DELIMITER //
CREATE EVENT notificar_inventario_bajo
ON SCHEDULE EVERY 1 DAY
DO
BEGIN
 
    INSERT INTO notificaciones (mensaje, fecha)
    SELECT CONCAT('Inventario bajo para: ', nombre), NOW()
    FROM inventario WHERE cantidad < 10; -- Por ejemplo, umbral de 10
END//
DELIMITER ;

-- 10. Archivar Reportes Anuales de Ventas
DELIMITER //
CREATE EVENT archivar_reportes_anuales
ON SCHEDULE YEARLY
DO
BEGIN
   
    INSERT INTO reportes_archivados (total_ventas, fecha_archivo)
    SELECT SUM(total), NOW() FROM ventas WHERE YEAR(fecha) = YEAR(NOW()) - 1;
END//
DELIMITER ;

-- 11. Registrar Cambios de Proveedores
DELIMITER //
CREATE EVENT registrar_cambios_proveedores
ON SCHEDULE EVERY 1 MONTH
DO
BEGIN
    
    INSERT INTO historial_cambios_proveedores (id_proveedor, fecha_cambio)
    SELECT id_proveedor, NOW() FROM proveedores WHERE estado = 'Modificado';
END//
DELIMITER ;

-- 12. Calcular el Promedio de Salario Mensual de Empleados
DELIMITER //
CREATE EVENT calcular_promedio_salario
ON SCHEDULE LAST DAY OF MONTH
DO
BEGIN
   
    INSERT INTO promedios_salarios (promedio, fecha_calculo)
    SELECT AVG(salario), NOW() FROM empleados;
END//
DELIMITER ;

-- 13. Actualizar Estado de Productos Vencidos
DELIMITER //
CREATE EVENT actualizar_productos_vencidos
ON SCHEDULE EVERY 1 DAY
DO
BEGIN
   
    UPDATE productos SET estado = 'Vencido' WHERE fecha_vencimiento < NOW();
END//
DELIMITER ;

-- 14. Notificar a Empleados sobre Cambio de Horarios
DELIMITER //
CREATE EVENT notificar_cambio_horarios
ON SCHEDULE EVERY 1 WEEK
DO
BEGIN
   
    INSERT INTO notificaciones (mensaje, fecha)
    SELECT CONCAT('Cambio de horario para: ', nombre), NOW()
    FROM empleados WHERE horario_modificado = 'Sí';
END//
DELIMITER ;

-- 15. Registrar Asistencia de Empleados Diariamente
DELIMITER //
CREATE EVENT registrar_asistencia
ON SCHEDULE EVERY 1 DAY
DO
BEGIN
   
    INSERT INTO asistencia_empleados (id_empleado, fecha, estado)
    SELECT id_empleado, NOW(), 'Presente' FROM empleados;
END//
DELIMITER ;

-- 16. Enviar Reporte de Ventas a la Gerencia
DELIMITER //
CREATE EVENT enviar_reporte_ventas
ON SCHEDULE EVERY 1 WEEK
DO
BEGIN
   
    INSERT INTO notificaciones (mensaje, fecha)
    SELECT CONCAT('Reporte semanal de ventas: ', SUM(total)), NOW()
    FROM ventas WHERE fecha >= NOW() - INTERVAL 7 DAY;
END//
DELIMITER ;

-- 17. Actualizar Datos de Clientes Inactivos
DELIMITER //
CREATE EVENT actualizar_clientes_inactivos
ON SCHEDULE EVERY 1 MONTH
DO
BEGIN
  
    UPDATE clientes SET estado = 'Inactivo' WHERE ultima_compra < NOW() - INTERVAL 1 YEAR;
END//
DELIMITER ;

-- 18. Generar Alertas de Proyectos en Progreso
DELIMITER //
CREATE EVENT alertas_proyectos_progreso
ON SCHEDULE EVERY 1 WEEK
DO
BEGIN
   
    INSERT INTO notificaciones (mensaje, fecha)
    SELECT CONCAT('Proyecto en progreso: ', nombre), NOW()
    FROM proyectos WHERE estado = 'En Progreso';
END//
DELIMITER ;

-- 19. Eliminar Datos de Insumos Obsoletos
DELIMITER //
CREATE EVENT eliminar_insumos_obsoletos
ON SCHEDULE EVERY 1 MONTH
DO
BEGIN
    
    DELETE FROM insumos WHERE ultima_venta < NOW() - INTERVAL 2 YEAR;
END//
DELIMITER ;

-- 20. Calcular y Actualizar Total de Gastos por Finca
DELIMITER //
CREATE EVENT calcular_total_gastos_finca
ON SCHEDULE LAST DAY OF MONTH
DO
BEGIN
    
    INSERT INTO total_gastos_finca (id_finca, total, fecha_calculo)
    SELECT id_finca, SUM(total), NOW() FROM gastos GROUP BY id_finca;
END//
DELIMITER ;
