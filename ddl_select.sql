-- CONSULTAS CON SELECT
--1. Obtener todos los productos disponibles en la granja.
SELECT productos.id_producto, productos.nombre FROM productos 

--2. Mostrar la lista de empleados con su respectivo salario.
SELECT empleados.id_empleado, empleados.nombre, empleados.salario FROM empleados

--3. Obtener todos los clientes con sus números de teléfono.
SELECT clientes.id_cliente, clientes.nombre, clientes.telefono_cliente FROM clientes

--4. Mostrar todas las ventas realizadas en el último mes.
SELECT * FROM ventas

--5. Listar todos los proveedores de insumos agrícolas.
SELECT * FROM proveedores

--6. Obtener toda la informacion de las fincas
SELECT * FROM finca

--7. Mostrar los productos y su precio por unidad de medida
SELECT  productos.nombre, productos.id_unidad_de_medida FROM productos

--8. Obtener los tipos de maquinaria disponibles en la granja.
SELECT * FROM maquinaria

--9. Mostrar las ciudades donde se encuentran las fincas.
SELECT f.nombre AS finca, c.nombre AS ciudad, p.nombre AS pais, co.nombre AS continente
FROM finca f
JOIN direccion d ON f.id_direccion = d.id_direccion
JOIN ciudad c ON d.id_ciudad = c.id_ciudad
JOIN pais p ON c.id_pais = p.id_pais
JOIN continente co ON p.id_continente = co.id_continente;

--10. Listar los empleados que tienen vacaciones pendientes
SELECT e.nombre AS empleado, v.fecha_vacaciones, ev.estado AS estado_vacaciones
FROM empleados e
JOIN vacaciones v ON e.id_empleado = v.id_empleado
JOIN estado_vacaciones ev ON v.id_estado_vacaciones = ev.id_estado_vacaciones
WHERE ev.estado = 'Pendiente';

--11. Obtener las ventas realizadas por un empleado específico
SELECT v.id_venta, v.fecha_venta, v.total
FROM ventas v
JOIN empleados e ON v.id_empleado = e.id_empleado
WHERE e.nombre = 'Nombre del Empleado'; 

--12. Mostrar los insumos utilizados en los procesos de producción

SELECT i.nombre AS insumo, p.nombre AS proceso
FROM insumos i
JOIN producto_proceso pp ON i.id_insumo = pp.id_producto -- Si los insumos están relacionados con los productos
JOIN procesos p ON pp.id_proceso = p.id_proceso;

--13. Listar los tipos de procesos productivos registrados

SELECT nombre AS tipo_proceso
FROM tipo_proceso;

--14. Mostrar los productos con los que trabaja cada proveedor

SELECT pr.nombre_empresa AS proveedor, p.nombre AS producto
FROM proveedores pr
JOIN compras c ON pr.id_proveedor = c.id_proveedor
JOIN insumos i ON c.id_proveedor = i.id_insumo;

--15. Obtener las ventas realizadas a un cliente específico
SELECT v.id_venta, v.fecha_venta, v.total
FROM ventas v
JOIN clientes c ON v.id_cliente = c.id_cliente
WHERE c.nombre = 'Nombre del Cliente'; 

--16. Mostrar las máquinas utilizadas en cada proceso productivo

SELECT p.nombre AS proceso, m.nombre AS maquina
FROM procesos p
JOIN procesos_maquinas pm ON p.id_proceso = pm.id_proceso
JOIN maquinaria m ON pm.id_maquina = m.id_maquina;

--17. Obtener los procesos en los que ha trabajado un empleado específico

SELECT e.nombre AS empleado, p.nombre AS proceso
FROM empleados e
JOIN procesos_empleados pe ON e.id_empleado = pe.id_empleado
JOIN procesos p ON pe.id_proceso = p.id_proceso
WHERE e.nombre = 'Nombre del Empleado'; 

--18. Listar las compras realizadas a un proveedor específico

SELECT c.id_compra, c.fecha_compra, c.total
FROM compras c
JOIN proveedores p ON c.id_proveedor = p.id_proveedor
WHERE p.nombre_empresa = 'Nombre del Proveedor';

-- 19. Mostrar el inventario disponible en una finca específica
SELECT i.nombre AS inventario, f.nombre AS finca
FROM inventario i
JOIN finca f ON i.id_finca = f.id_finca
WHERE f.nombre = 'Finca El Roble'; 

--20. Listar los empleados y su salario, ordenado por el salario de mayor a menor

SELECT nombre, salario
FROM empleados
ORDER BY salario DESC;

--21. Obtener el estado de pago de los empleados en un rango de fechas

SELECT e.nombre AS empleado, p.fecha_pago, p.estado_pago
FROM pago_empleados p
JOIN empleados e ON p.id_empleado = e.id_empleado
WHERE p.fecha_pago BETWEEN 'YYYY-MM-DD' AND 'YYYY-MM-DD'; -- Reemplazar por el rango de fechas deseado

--22. Mostrar los procesos realizados por una máquina específica

SELECT m.nombre AS maquina, p.nombre AS proceso
FROM maquinaria m
JOIN procesos_maquinas pm ON m.id_maquina = pm.id_maquina
JOIN procesos p ON pm.id_proceso = p.id_proceso
WHERE m.nombre = 'Nombre de la Máquina'; -- Reemplazar 'Nombre de la Máquina' por el nombre específico


--23. Obtener el inventario de un tipo específico (por ejemplo, maquinaria o productos)

SELECT i.nombre AS inventario, ti.nombre AS tipo_inventario
FROM inventario i
JOIN tipo_inventario ti ON i.id_tipo_inventario = ti.id_tipo_inventario
WHERE ti.nombre = 'Tipo de Inventario'; -- Reemplazar 'Tipo de Inventario' por el tipo específico (e.g., 'maquinaria', 'productos')

--24. Mostrar los pedidos realizados por un cliente específico

SELECT p.id_pedido, c.nombre AS cliente, p.id_insumo
FROM pedido p
JOIN clientes c ON p.id_cliente = c.id_cliente
WHERE c.nombre = 'Nombre del Cliente'; -- Reemplazar 'Nombre del Cliente' por el nombre específico


--25. Listar los proveedores que suministran un insumo específico
SELECT p.nombre_empresa AS proveedor, i.nombre AS insumo
FROM proveedores p
JOIN compras c ON p.id_proveedor = c.id_proveedor
JOIN insumos i ON c.id_proveedor = i.id_insumo -- Si existe una relación directa, ajustar esta parte
WHERE i.nombre = 'Nombre del Insumo'; -- Reemplazar 'Nombre del Insumo' por el nombre específico

--26. Contar cuántos productos están registrados en la base de datos

SELECT COUNT(*) AS total_productos
FROM productos;

--27. Obtener el total de ventas realizadas en un año

SELECT SUM(total) AS total_ventas
FROM ventas
WHERE YEAR(fecha_venta) = 2024; 

--28. Mostrar el número de empleados en la granja
SELECT COUNT(*) AS total_empleados
FROM empleados;

--29. Calcular el salario promedio de los empleados
SELECT AVG(salario) AS salario_promedio
FROM empleados;

--30. Obtener la venta más alta realizada en el último mes

SELECT MAX(total) AS venta_maxima
FROM ventas
WHERE MONTH(fecha_venta) = MONTH(CURDATE()) AND YEAR(fecha_venta) = YEAR(CURDATE());

--31. Contar cuántos clientes han realizado compras en el último año

SELECT COUNT(DISTINCT id_cliente) AS clientes_activos
FROM ventas
WHERE YEAR(fecha_venta) = YEAR(CURDATE());


--32. Calcular el total de insumos comprados por proveedor
SELECT p.nombre_empresa AS proveedor, SUM(c.total) AS total_compras
FROM compras c
JOIN proveedores p ON c.id_proveedor = p.id_proveedor
GROUP BY p.nombre_empresa;

--33. Mostrar la cantidad de productos vendidos por cada cliente

SELECT c.nombre AS cliente, COUNT(v.id_venta) AS cantidad_productos
FROM ventas v
JOIN clientes c ON v.id_cliente = c.id_cliente
GROUP BY c.nombre;

--34. Calcular el total de compras realizadas a un proveedor específico
SELECT SUM(c.total) AS total_compras
FROM compras c
JOIN proveedores p ON c.id_proveedor = p.id_proveedor
WHERE p.nombre_empresa = 'Nombre del Proveedor'; -- Reemplazar 'Nombre del Proveedor' por el nombre específico


--35. Obtener el total de ventas por empleado
SELECT e.nombre AS empleado, SUM(v.total) AS total_ventas
FROM ventas v
JOIN empleados e ON v.id_empleado = e.id_empleado
GROUP BY e.nombre;

--36. Obtener las ventas realizadas por cada empleado
SELECT e.nombre AS nombre_empleado, COUNT(v.id_venta) AS total_ventas
FROM empleados e
JOIN ventas v ON e.id_empleado = v.id_empleado
GROUP BY e.nombre;

--37. Listar los productos vendidos junto con la unidad de medida
SELECT p.nombre AS nombre_producto, u.nombre AS unidad_medida
FROM productos p
JOIN unidad_medida u ON p.id_unidad_de_medida = u.id_unidad_de_medida;

--38. Obtener los clientes y las ciudades donde se encuentran
SELECT c.nombre AS nombre_cliente, ci.nombre AS nombre_ciudad
FROM clientes c
JOIN direccion d ON c.id_cliente = d.id_direccion
JOIN ciudad ci ON d.id_ciudad = ci.id_ciudad;

--39. Mostrar los empleados y las máquinas que utilizan en los procesos
SELECT e.nombre AS nombre_empleado, m.nombre AS nombre_maquina
FROM empleados e
JOIN procesos_empleados pe ON e.id_empleado = pe.id_empleado
JOIN procesos_maquinas pm ON pe.id_proceso = pm.id_proceso
JOIN maquinaria m ON pm.id_maquina = m.id_maquina;

--40. Listar las compras y el proveedor correspondiente
SELECT co.id_compra, p.nombre_empresa AS proveedor, co.fecha_compra, co.total
FROM compras co
JOIN proveedores p ON co.id_proveedor = p.id_proveedor;

--41. Mostrar los empleados que han realizado más de 1 ventas
SELECT e.nombre AS nombre_empleado, COUNT(v.id_venta) AS total_ventas
FROM empleados e
JOIN ventas v ON e.id_empleado = v.id_empleado
GROUP BY e.nombre
HAVING COUNT(v.id_venta) > 1;

--42. Obtener los clientes que no han realizado compras en el último año
SELECT c.nombre AS nombre_cliente
FROM clientes c
LEFT JOIN ventas v ON c.id_cliente = v.id_cliente AND YEAR(v.fecha_venta) = 2023
WHERE v.id_venta IS NULL;

--43. Listar los productos cuyo precio es mayor al promedio
SELECT p.nombre AS nombre_producto, pv.valor AS precio
FROM productos p
JOIN precio_venta_u_medida pv ON p.id_precio_venta_u_medida = pv.id_precio_venta_u_medida
WHERE pv.valor > (SELECT AVG(valor) FROM precio_venta_u_medida);

--44. Mostrar las fincas que tienen más de 3 proveedores
SELECT f.nombre AS nombre_finca, COUNT(p.id_proveedor) AS total_proveedores
FROM finca f
JOIN proveedores p ON f.id_finca = p.id_finca
GROUP BY f.nombre
HAVING COUNT(p.id_proveedor) > 3;

--45. Obtener las ventas cuyo total es superior al promedio de todas las ventas
SELECT v.id_venta, v.total
FROM ventas v
WHERE v.total > (SELECT AVG(total) FROM ventas);

