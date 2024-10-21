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
