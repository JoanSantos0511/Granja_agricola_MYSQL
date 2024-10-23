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
WHERE e.nombre = 'José Pérez'; 

--12. Mostrar los insumos utilizados en los procesos de producción

SELECT i.nombre AS insumo, p.nombre AS proceso
FROM insumos i
JOIN producto_proceso pp ON i.id_insumo = pp.id_producto 
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
WHERE c.nombre = 'Luis González'; 

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
WHERE e.nombre = 'Raúl Castro'; 

--18. Listar las compras realizadas a un proveedor específico

SELECT c.id_compra, c.fecha_compra, c.total
FROM compras c
JOIN proveedores p ON c.id_proveedor = p.id_proveedor
WHERE p.nombre_empresa = 'Productores Locales';

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
WHERE p.fecha_pago BETWEEN 'YYYY-MM-DD' AND 'YYYY-MM-DD'; 

--22. Mostrar los procesos realizados por una máquina específica

SELECT m.nombre AS maquina, p.nombre AS proceso
FROM maquinaria m
JOIN procesos_maquinas pm ON m.id_maquina = pm.id_maquina
JOIN procesos p ON pm.id_proceso = p.id_proceso
WHERE m.nombre = 'Planta de Compostaje'; 


--23. Obtener el inventario de un tipo específico (por ejemplo, maquinaria o productos)

SELECT i.nombre AS inventario, ti.nombre AS tipo_inventario
FROM inventario i
JOIN tipo_inventario ti ON i.id_tipo_inventario = ti.id_tipo_inventario
WHERE ti.nombre = 'Combustible'; 

--24. Mostrar los pedidos realizados por un cliente específico

SELECT p.id_pedido, c.nombre AS cliente, p.id_insumo
FROM pedido p
JOIN clientes c ON p.id_cliente = c.id_cliente
WHERE c.nombre = 'Carlos Ramírez';


--25. Listar los proveedores que suministran un insumo específico
SELECT p.nombre_empresa AS proveedor, i.nombre AS insumo
FROM proveedores p
JOIN compras c ON p.id_proveedor = c.id_proveedor
JOIN insumos i ON c.id_proveedor = i.id_insumo 
WHERE i.nombre = 'Abono de nitrógeno'; 

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
WHERE p.nombre_empresa = 'Cosechas Locales'; 


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

--46. Listar las máquinas que se utilizan en exactamente dos procesos

SELECT m.nombre AS nombre_maquina, COUNT(pm.id_proceso) AS total_procesos
FROM maquinaria m
JOIN procesos_maquinas pm ON m.id_maquina = pm.id_maquina
GROUP BY m.nombre
HAVING COUNT(pm.id_proceso) = 2;

--47. Mostrar los productos que no han sido procesados aún
SELECT p.nombre AS nombre_producto
FROM productos p
LEFT JOIN producto_proceso pp ON p.id_producto = pp.id_producto
WHERE pp.id_proceso IS NULL;

--48. Obtener las compras realizadas en el último mes
SELECT co.id_compra, p.nombre_empresa AS proveedor, co.fecha_compra, co.total
FROM compras co
JOIN proveedores p ON co.id_proveedor = p.id_proveedor
WHERE co.fecha_compra >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH);

--49. Listar los empleados que han procesado más de 1 productos
SELECT e.nombre AS nombre_empleado, COUNT(pp.id_proceso_producto) AS total_procesos
FROM empleados e
JOIN procesos_empleados pe ON e.id_empleado = pe.id_empleado
JOIN producto_proceso pp ON pe.id_proceso = pp.id_proceso
GROUP BY e.nombre
HAVING COUNT(pp.id_proceso_producto) > 1;

--50. Obtener los empleados que tienen un salario mayor al promedio
SELECT e.nombre AS nombre_empleado, e.salario
FROM empleados e
WHERE e.salario > (SELECT AVG(salario) FROM empleados);

--51. Mostrar los insumos más comprados
SELECT i.nombre AS nombre_insumo, COUNT(p.id_pedido) AS total_pedidos
FROM insumos i
JOIN pedido p ON i.id_insumo = p.id_insumo
GROUP BY i.nombre
ORDER BY total_pedidos DESC;

--52. Obtener las fincas que tienen inventarios registrados
SELECT f.nombre AS nombre_finca, i.nombre AS nombre_inventario
FROM finca f
JOIN inventario i ON f.id_finca = i.id_finca;

--53. Listar los empleados que han estado de vacaciones en el último año
SELECT e.nombre AS nombre_empleado, v.fecha_vacaciones
FROM empleados e
JOIN vacaciones v ON e.id_empleado = v.id_empleado
WHERE YEAR(v.fecha_vacaciones) = YEAR(CURDATE());

--54. Mostrar los productos y su respectiva categoría de inventario
SELECT p.nombre AS nombre_producto, ti.nombre AS tipo_inventario
FROM productos p
JOIN inventario i ON p.id_producto = i.id_inventario
JOIN tipo_inventario ti ON i.id_tipo_inventario = ti.id_tipo_inventario;

--55. Obtener los empleados cuyo pago está pendiente

SELECT e.nombre AS nombre_empleado, pe.estado_pago
FROM empleados e
JOIN pago_empleados pe ON e.id_empleado = pe.id_empleado
WHERE pe.estado_pago = 'Pendiente';

----------------------------------------------------
--CONSULTAS CON SUBCONSULTAS
----------------------------------------------------

--56. Obtener los productos cuyo precio es mayor al precio promedio por tipo de producto
SELECT p.nombre, p.tipo_producto, pm.valor AS precio
FROM productos p
JOIN precio_venta_u_medida pm ON p.id_precio_venta_u_medida = pm.id_precio_venta_u_medida
WHERE pm.valor > (SELECT AVG(pm2.valor) 
                  FROM productos p2 
                  JOIN precio_venta_u_medida pm2 ON p2.id_precio_venta_u_medida = pm2.id_precio_venta_u_medida 
                  WHERE p.tipo_producto = p2.tipo_producto);

--57. Mostrar los proveedores que han realizado compras con un valor total superior al promedio de compras realizadas por todos los proveedores
SELECT p.nombre_empresa, SUM(c.total) AS total_compras
FROM proveedores p
JOIN compras c ON p.id_proveedor = c.id_proveedor
GROUP BY p.nombre_empresa
HAVING SUM(c.total) > (SELECT AVG(total) FROM compras);

--58. Contar cuántos clientes han hecho compras mayores al promedio
SELECT COUNT(*) AS total_clientes
FROM clientes c
WHERE EXISTS (SELECT 1 
              FROM ventas v 
              WHERE v.id_cliente = c.id_cliente AND v.total > (SELECT AVG(total) FROM ventas));

--59. Mostrar las fincas que tienen al menos 3 empleados asignados a ellas

SELECT f.nombre, COUNT(e.id_empleado) AS total_empleados
FROM finca f
JOIN empleados e ON f.id_finca = e.id_empleado
GROUP BY f.nombre
HAVING COUNT(e.id_empleado) >= 3;

--60. Obtener el total de compras realizadas por cada proveedor durante el último año
SELECT p.nombre_empresa, SUM(c.total) AS total_compras
FROM proveedores p
JOIN compras c ON p.id_proveedor = c.id_proveedor
WHERE c.fecha_compra >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR)
GROUP BY p.nombre_empresa;

--61. Listar las ciudades que tienen al menos una finca con más de 5 compras realizadas
SELECT ci.nombre AS ciudad, COUNT(c.id_compra) AS total_compras
FROM ciudad ci
JOIN direccion d ON ci.id_ciudad = d.id_ciudad
JOIN finca f ON d.id_direccion = f.id_direccion
JOIN proveedores p ON f.id_finca = p.id_finca
JOIN compras c ON p.id_proveedor = c.id_proveedor
GROUP BY ci.nombre
HAVING COUNT(c.id_compra) > 5;

--62. Obtener los empleados que han recibido el salario más alto en los últimos 3 meses:
SELECT e.nombre, MAX(pe.fecha_pago) AS ultima_fecha_pago, e.salario
FROM empleados e
JOIN pago_empleados pe ON e.id_empleado = pe.id_empleado
WHERE pe.fecha_pago >= DATE_SUB(CURDATE(), INTERVAL 3 MONTH)  
GROUP BY e.nombre, e.salario
ORDER BY e.salario DESC
LIMIT 5;  


--63:Obtener el total de productos comprados por cada proveedor en el último año:
SELECT p.nombre_empresa AS proveedor, COUNT(c.id_compra) AS total_compras
FROM proveedores p
JOIN compras c ON p.id_proveedor = c.id_proveedor
WHERE c.fecha_compra >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR)  
GROUP BY p.id_proveedor, p.nombre_empresa
HAVING COUNT(c.id_compra) > 0  
ORDER BY total_compras DESC;


--64. Obtener los clientes que han realizado al menos una compra de más de $1000

SELECT c.nombre
FROM clientes c
WHERE EXISTS (SELECT 1 
              FROM ventas v 
              WHERE v.id_cliente = c.id_cliente AND v.total > 1000);


--65. Obtener el total de compras realizadas por cada proveedor y el monto total gastado en cada uno

SELECT p.nombre_empresa AS proveedor, 
       COUNT(c.id_compra) AS total_compras, 
       SUM(c.total) AS total_gastado
FROM proveedores p
JOIN compras c ON p.id_proveedor = c.id_proveedor
GROUP BY p.id_proveedor, p.nombre_empresa
HAVING COUNT(c.id_compra) > 0  
ORDER BY total_gastado DESC;

--66. Mostrar los empleados que ganan más que el salario promedio de la granja
SELECT nombre, salario
FROM empleados
WHERE salario > (
    SELECT AVG(salario) 
    FROM empleados
);

--67. Obtener los empleados que han trabajado en más de 1 procesos distintos
SELECT e.nombre AS empleado, COUNT(pe.id_proceso) AS total_procesos
FROM empleados e
JOIN procesos_empleados pe ON e.id_empleado = pe.id_empleado
GROUP BY e.id_empleado
HAVING COUNT(pe.id_proceso) > 1;


--68. Obtener los productos que han sido utilizados en procesos que involucran 2 o mas máquinas diferentes
SELECT p.nombre AS producto, COUNT(DISTINCT pm.id_maquina) AS total_maquinas
FROM productos p
JOIN producto_proceso pp ON p.id_producto = pp.id_producto
JOIN procesos pr ON pp.id_proceso = pr.id_proceso
JOIN procesos_maquinas pm ON pr.id_proceso = pm.id_proceso
GROUP BY p.id_producto
HAVING COUNT(DISTINCT pm.id_maquina) >= 2;

--69. Listar los empleados que han realizado más de 2 ventas en total

SELECT e.nombre AS empleado, COUNT(v.id_venta) AS total_ventas
FROM empleados e
JOIN ventas v ON e.id_empleado = v.id_empleado
GROUP BY e.id_empleado
HAVING COUNT(v.id_venta) >= 2;

--70. Mostrar las ventas cuyo total es superior al promedio de todas las ventas
SELECT id_venta, total
FROM ventas
WHERE total > (
    SELECT AVG(total)
    FROM ventas
);

--71. Listar los productos que tienen el precio más alto
SELECT nombre, valor
FROM productos p
JOIN precio_venta_u_medida pv ON p.id_precio_venta_u_medida = pv.id_precio_venta_u_medida
WHERE pv.valor = (
    SELECT MAX(valor)
    FROM precio_venta_u_medida
);

--72. Obtener los clientes que han realizado la mayor cantidad de compras
SELECT nombre, total_compras
FROM clientes c
JOIN (
    SELECT id_cliente, COUNT(id_venta) AS total_compras
    FROM ventas
    GROUP BY id_cliente
) v ON c.id_cliente = v.id_cliente
ORDER BY total_compras DESC
LIMIT 1;

--73. Mostrar las máquinas utilizadas en procesos específicos
SELECT m.nombre AS maquina, p.nombre AS proceso
FROM maquinaria m
JOIN procesos_maquinas pm ON m.id_maquina = pm.id_maquina
JOIN procesos p ON pm.id_proceso = p.id_proceso
WHERE p.id_proceso IN (
    SELECT id_proceso 
    FROM procesos 
    WHERE nombre = 'Control de Plagas con Pesticidas'
);

--74. Listar los insumos más utilizados en los procesos de producción

SELECT i.nombre AS insumo, COUNT(pp.id_proceso_producto) AS cantidad_usada
FROM insumos i
JOIN producto_proceso pp ON i.id_insumo = pp.id_producto
GROUP BY i.id_insumo
ORDER BY cantidad_usada DESC;

--75. Mostrar las ventas realizadas por empleados que tienen un salario mayor al salario promedio

SELECT v.id_venta, v.total, e.nombre AS empleado
FROM ventas v
JOIN empleados e ON v.id_empleado = e.id_empleado
WHERE e.salario > (
    SELECT AVG(salario) 
    FROM empleados
);

--76. Listar los empleados cuyo salario está entre el 10% superior de los salarios
SELECT e.nombre AS empleado, e.salario
FROM empleados e
WHERE e.salario > (
    SELECT PERCENTILE_CONT(0.9) WITHIN GROUP (ORDER BY salario)
    FROM empleados
);

