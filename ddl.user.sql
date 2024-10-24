-- Active: 1729309147950@@127.0.0.1@3306@granja_agricolamysql
--1. Administrador
CREATE USER 'admin'@'localhost' IDENTIFIED BY 'contraseña_admin';
GRANT ALL PRIVILEGES ON granja_agricolaMYSQL.* TO 'admin'@'localhost';
FLUSH PRIVILEGES;

--2. Vendedor
CREATE USER 'vendedor'@'localhost' IDENTIFIED BY 'contraseña_vendedor';
GRANT SELECT, INSERT, UPDATE ON granja_agricolaMYSQL.ventas TO 'vendedor'@'localhost';
GRANT SELECT ON granja_agricolaMYSQL.inventario TO 'vendedor'@'localhost';
FLUSH PRIVILEGES;

--3. Contador
CREATE USER 'contador'@'localhost' IDENTIFIED BY 'contraseña_contador';
GRANT SELECT ON granja_agricolaMYSQL.reportes TO 'contador'@'localhost';
GRANT SELECT ON granja_agricolaMYSQL.ventas TO 'contador'@'localhost';
FLUSH PRIVILEGES;

--4. Encargado de Inventario
CREATE USER 'encargado_inventario'@'localhost' IDENTIFIED BY 'contraseña_encargado';
GRANT SELECT, INSERT, UPDATE, DELETE ON granja_agricolaMYSQL.inventario TO 'encargado_inventario'@'localhost';
FLUSH PRIVILEGES;

--5. Empleado

CREATE USER 'empleado'@'localhost' IDENTIFIED BY 'contraseña_empleado';
GRANT SELECT ON granja_agricolaMYSQL.ventas TO 'empleado'@'localhost';
GRANT SELECT ON granja_agricolaMYSQL.inventario TO 'empleado'@'localhost';
FLUSH PRIVILEGES;
