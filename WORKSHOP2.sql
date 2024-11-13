CREATE DATABASE sistemaQA;
USE sistemaQA;

CREATE TABLE Usuario (
    idUsuario INT PRIMARY KEY AUTO_INCREMENT,
    Nombre VARCHAR(100) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    Rol ENUM('QA Tester', 'Desarrollador', 'Product Owner', 'Scrum Master') NOT NULL
);
CREATE TABLE Modulo (
    idModulo INT PRIMARY KEY AUTO_INCREMENT,
    Nombre VARCHAR(100) NOT NULL,
    Descripcion TEXT,
    ModuloCol VARCHAR(100),
    id_Creador INT,
    FOREIGN KEY (id_Creador) REFERENCES Usuario(idUsuario)
);
CREATE TABLE Casos_De_Prueba (
    idCasos_De_Prueba INT PRIMARY KEY AUTO_INCREMENT,
    Nombre VARCHAR(100) NOT NULL,
    Descripcion TEXT,
    Prioridad ENUM('Alta', 'Media', 'Baja') NOT NULL,
    Fecha_Creacion DATE,
    Id_Modulo INT,
    Id_Creador INT,
    FOREIGN KEY (Id_Modulo) REFERENCES Modulo(idModulo),
    FOREIGN KEY (Id_Creador) REFERENCES Usuario(idUsuario)
);
CREATE TABLE Resultado_Prueba (
    idResultado_Prueba INT PRIMARY KEY AUTO_INCREMENT,
    Estado ENUM('Exitoso', 'Fallido', 'En Progreso') NOT NULL,
    Fecha_ejecucion DATE,
    Comentario TEXT,
    Id_caso_prueba INT,
    id_QATester INT,
    FOREIGN KEY (Id_caso_prueba) REFERENCES Casos_De_Prueba(idCasos_De_Prueba),
    FOREIGN KEY (id_QATester) REFERENCES Usuario(idUsuario)
);
CREATE TABLE Error (
    Id_Bug INT PRIMARY KEY AUTO_INCREMENT,
    Descripcion_bug TEXT NOT NULL,
    Severidad ENUM('Alta', 'Media', 'Baja') NOT NULL,
    Estado ENUM('Pendiente', 'En Progreso', 'Resuelto') NOT NULL,
    Fecha_creacion DATE,
    Fecha_resolucion DATE,
    idCasos_De_Prueba INT,  -- Modificado aquí para coincidir con la columna en la tabla Casos_De_Prueba
    Id_asignado_a INT,
    FOREIGN KEY (idCasos_De_Prueba) REFERENCES Casos_De_Prueba(idCasos_De_Prueba),  -- Modificado aquí también
    FOREIGN KEY (Id_asignado_a) REFERENCES Usuario(idUsuario)
);


-- insertar datos de usuarios --
INSERT INTO Usuario (Nombre, Email, Rol) VALUES
('Carlos Gómez', 'carlos.gomez@example.com', 'Desarrollador'),
('Ana Pérez', 'ana.perez@example.com', 'Desarrollador'),
('Luis Martínez', 'luis.martinez@example.com', 'Desarrollador'),
('Sofía Ruiz', 'sofia.ruiz@example.com', 'Desarrollador'),
('Juan López', 'juan.lopez@example.com', 'QA Tester'),
('Marta Fernández', 'marta.fernandez@example.com', 'QA Tester'),
('Pedro Sánchez', 'pedro.sanchez@example.com', 'QA Tester'),
('Lucía Gómez', 'lucia.gomez@example.com', 'QA Tester'),
('Roberto Díaz', 'roberto.diaz@example.com', 'Product Owner'),
('Laura Pérez', 'laura.perez@example.com', 'Scrum Master');

-- insertar datos sobre modulos en los que se trabaja--
INSERT INTO Modulo (Nombre, Descripcion, ModuloCol, id_Creador) VALUES
('Autenticación', 'Módulo para gestionar inicios de sesión, registro y recuperación de contraseñas', 'Login, Signup, Recuperación de Contraseña', 1),
('Carrito de Compras', 'Módulo para agregar y quitar productos del carrito de compras', 'Agregar, Eliminar, Modificar', 2),
('Pago', 'Módulo para procesar pagos a través de tarjetas de crédito y PayPal', 'Pago, Facturación, Transacciones', 3),
('Perfil de Usuario', 'Módulo para gestionar el perfil del usuario', 'Perfil, Configuración, Historial', 4);

-- insercion de casos de prueba--
INSERT INTO Casos_De_Prueba (Nombre, Descripcion, Prioridad, Fecha_Creacion, Id_Modulo, Id_Creador) VALUES
('Login exitoso', 'Verificar que un usuario puede iniciar sesión correctamente con credenciales válidas', 'Alta', '2024-11-09', 1, 5),
('Login fallido', 'Verificar que un usuario no puede iniciar sesión con credenciales incorrectas', 'Alta', '2024-11-09', 1, 6),
('Editar perfil', 'Verificar que un usuario puede editar su perfil correctamente', 'Media', '2024-11-09', 2, 7),
('Cambiar contraseña', 'Verificar que un usuario puede cambiar su contraseña correctamente', 'Alta', '2024-11-09', 2, 8),
('Agregar al carrito', 'Verificar que un usuario puede agregar productos al carrito de compras', 'Alta', '2024-11-09', 3, 9),
('Eliminar del carrito', 'Verificar que un usuario puede eliminar productos del carrito de compras', 'Media', '2024-11-09', 3, 10),
('Verificar total del carrito', 'Verificar que el total del carrito es calculado correctamente', 'Media', '2024-11-09', 3, 5),
('Pagar con tarjeta', 'Verificar que un usuario puede pagar con tarjeta de crédito', 'Alta', '2024-11-09', 4, 6),
('Pagar con PayPal', 'Verificar que un usuario puede pagar con PayPal', 'Alta', '2024-11-09', 4, 7),
('Método de pago fallido', 'Verificar que el sistema muestra error cuando el pago no se puede procesar', 'Alta', '2024-11-09', 4, 8);

-- insercion de resultados--
INSERT INTO Resultado_Prueba (Estado, Fecha_ejecucion, Comentario, Id_caso_prueba, id_QATester) VALUES
('Exitoso', '2024-11-10', 'El login fue exitoso con credenciales válidas', 1, 5),
('Fallido', '2024-11-10', 'El login falló con credenciales incorrectas', 2, 6),
('Exitoso', '2024-11-10', 'El perfil fue editado correctamente', 3, 7),
('Exitoso', '2024-11-10', 'La contraseña fue cambiada correctamente', 4, 8),
('Exitoso', '2024-11-10', 'El producto se agregó al carrito correctamente', 5, 9),
('Exitoso', '2024-11-10', 'El producto se eliminó del carrito correctamente', 6, 10),
('Exitoso', '2024-11-10', 'El total del carrito fue calculado correctamente', 7, 5),
('Fallido', '2024-11-10', 'El pago con tarjeta no se procesó correctamente', 8, 6),
('Exitoso', '2024-11-10', 'El pago con PayPal fue exitoso', 9, 7),
('Fallido', '2024-11-10', 'El pago con método de pago no se procesó correctamente', 10, 8);

-- insercion de errores--
INSERT INTO Error (Descripcion_bug, Severidad, Estado, Fecha_creacion, Fecha_resolucion, idCasos_De_Prueba, Id_asignado_a) VALUES
('Error en el login con credenciales válidas', 'Alta', 'Pendiente', '2024-11-09', NULL, 1, 5),
('Error en la validación del login con credenciales incorrectas', 'Alta', 'En Progreso', '2024-11-09', NULL, 2, 6),
('Error al guardar cambios en el perfil de usuario', 'Media', 'Resuelto', '2024-11-09', '2024-11-10', 3, 7),
('Error al cambiar contraseña en perfil', 'Alta', 'Pendiente', '2024-11-09', NULL, 4, 8),
('Error al agregar producto al carrito', 'Alta', 'Resuelto', '2024-11-09', '2024-11-10', 5, 9),
('Error al eliminar producto del carrito', 'Media', 'En Progreso', '2024-11-09', NULL, 6, 10),
('Error al calcular total del carrito', 'Alta', 'Pendiente', '2024-11-09', NULL, 7, 5),
('Error al procesar pago con tarjeta', 'Alta', 'En Progreso', '2024-11-09', NULL, 8, 6),
('Error al procesar pago con PayPal', 'Alta', 'Pendiente', '2024-11-09', NULL, 9, 7),
('Error al procesar método de pago fallido', 'Alta', 'Resuelto', '2024-11-09', '2024-11-10', 10, 8);

-- Vistas --
-- Esta vista podría ser útil para ver todos los casos de prueba asociados a un módulo específico--
CREATE VIEW Vista_Casos_Prueba_Por_Modulo AS
SELECT 
    cp.idCasos_De_Prueba,
    cp.Nombre AS Caso_De_Prueba,
    cp.Descripcion,
    cp.Prioridad,
    cp.Fecha_Creacion,
    m.Nombre AS Modulo,
    u.Nombre AS Creador
FROM 
    Casos_De_Prueba cp
JOIN 
    Modulo m ON cp.Id_Modulo = m.idModulo
JOIN 
    Usuario u ON cp.Id_Creador = u.idUsuario;

-- Una vista que muestre todos los errores o bugs que están pendientes o en progreso, con información sobre su severidad, estado y el caso de prueba asociado--

CREATE VIEW Vista_Errores_Pendientes AS
SELECT 
    e.Id_Bug,
    e.Descripcion_bug,
    e.Severidad,
    e.Estado AS Estado_Bug,
    e.Fecha_creacion,
    e.Fecha_resolucion,
    cp.Nombre AS Caso_De_Prueba,
    u.Nombre AS Asignado_A
FROM 
    Error e
JOIN 
    Casos_De_Prueba cp ON e.idCasos_De_Prueba = cp.idCasos_De_Prueba
JOIN 
    Usuario u ON e.Id_asignado_a = u.idUsuario
WHERE 
    e.Estado IN ('Pendiente', 'En Progreso');
    
  -- Esta permitirá ver un resumen de los casos de prueba con su respectivo estado de ejecución y los resultados obtenidos --  
    
    
CREATE VIEW Vista_Resumen_Casos_Resultados AS
SELECT 
    cp.idCasos_De_Prueba,
    cp.Nombre AS Caso_De_Prueba,
    cp.Prioridad,
    rp.Estado AS Resultado,
    rp.Fecha_ejecucion,
    rp.Comentario
FROM 
    Casos_De_Prueba cp
LEFT JOIN 
    Resultado_Prueba rp ON cp.idCasos_De_Prueba = rp.Id_caso_prueba;


-- Esta vista muestra todos los casos de prueba junto con los bugs que están asociados a ellos, clasificados por estado de los bugs (pendiente, en progreso, resuelto)--

CREATE VIEW Vista_Casos_Bugs_Estado AS
SELECT 
    cp.idCasos_De_Prueba,
    cp.Nombre AS Caso_De_Prueba,
    e.Id_Bug,
    e.Descripcion_bug,
    e.Estado AS Estado_Bug,
    e.Severidad
FROM 
    Casos_De_Prueba cp
LEFT JOIN 
    Error e ON cp.idCasos_De_Prueba = e.idCasos_De_Prueba;
    
SELECT * FROM Vista_Casos_Prueba_Por_Modulo;
SELECT * FROM Vista_Resumen_Casos_Resultados;
SELECT * FROM Vista_Casos_Bugs_Estado;

-- FUNCIONES ALMACENADAS-- 
-- Esta función toma como parámetro el idUsuario y devuelve el rol correspondiente a ese usuario --
DELIMITER $$

CREATE FUNCTION ObtenerRolDeUsuario(idUsuario INT)
RETURNS VARCHAR(100)
DETERMINISTIC
BEGIN
    DECLARE rolUsuario VARCHAR(100);

    -- Obtener el rol del usuario
    SELECT Rol INTO rolUsuario
    FROM Usuario
    WHERE idUsuario = idUsuario;

    RETURN rolUsuario;
END$$

DELIMITER ;
SELECT ObtenerRolDeUsuario(1);
-- Esta función toma como parámetro el casoDePruebaId y devuelve el número de errores (bugs) asociados a ese caso de prueba--
DELIMITER $$

CREATE FUNCTION ObtenerErroresPorCasoDePrueba(casoDePruebaId INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE numErrores INT;

    -- Contar el número de errores asociados al caso de prueba
    SELECT COUNT(*) INTO numErrores
    FROM Error
    WHERE idCasos_De_Prueba = casoDePruebaId;

    RETURN numErrores;
END$$

DELIMITER ;

SELECT ObtenerErroresPorCasoDePrueba(1);


-- Procedimiento utilizado para obtener una lista de casos de prueba asociados a un módulo específico--
DELIMITER $$

CREATE PROCEDURE ObtenerCasosDePruebaPorModulo (IN moduloId INT)
BEGIN
    SELECT 
        c.idCasos_De_Prueba,
        c.Nombre,
        c.Descripcion,
        c.Prioridad,
        c.Fecha_Creacion,
        c.Id_Creador
    FROM Casos_De_Prueba c
    WHERE c.Id_Modulo = moduloId;
END$$

DELIMITER ;


-- Procedimiento diseñada para recuperar todos los errores (o bugs) asociados a un caso de prueba específico --
DELIMITER $$

CREATE PROCEDURE ObtenerErroresPorCasoDePrueba(IN casoDePruebaId INT)
BEGIN
    SELECT 
        e.Id_Bug,
        e.Descripcion_bug,
        e.Severidad,
        e.Estado,
        e.Fecha_creacion,
        e.Fecha_resolucion,
        e.Id_asignado_a
    FROM Error e
    WHERE e.idCasos_De_Prueba = casoDePruebaId;
END$$

DELIMITER ;

CALL ObtenerCasosDePruebaPorModulo(1);
CALL ObtenerErroresPorCasoDePrueba(5);

-- Procedimiento almacenado para obtener todos los usuarios con su rol --

DELIMITER $$

CREATE PROCEDURE ObtenerUsuariosConRol()
BEGIN
    -- Seleccionar todos los usuarios con su nombre, email y rol
    SELECT 
        idUsuario,
        Nombre,
        Email,
        Rol
    FROM Usuario;
END$$

DELIMITER ;

-- Procedimiento almacenado para actualizar el estado de un error (bug)  -- 


DELIMITER $$

CREATE PROCEDURE ActualizarEstadoError(IN idBug INT, IN nuevoEstado ENUM('Pendiente', 'En Progreso', 'Resuelto'))
BEGIN
    -- Actualizar el estado de un error específico
    UPDATE Error
    SET Estado = nuevoEstado
    WHERE Id_Bug = idBug;
    
    -- Confirmación de la actualización
    SELECT 'Estado del error actualizado correctamente' AS mensaje;
END$$

DELIMITER ;


CALL ObtenerUsuariosConRol();
CALL ActualizarEstadoError(1, 'Resuelto');

-- Este trigger se ejecutará antes de insertar un nuevo registro en la tabla Usuario y validará que el Rol sea uno de los valores válidos --

DELIMITER $$

CREATE TRIGGER VerificarRolUsuario
BEFORE INSERT ON Usuario
FOR EACH ROW
BEGIN
    IF NEW.Rol NOT IN ('QA Tester', 'Desarrollador', 'Product Owner', 'Scrum Master') THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El rol asignado no es válido.';
    END IF;
END$$

DELIMITER ;

-- Este trigger se ejecutará antes de insertar un registro en la tabla Modulo y asegurará que el campo Descripcion no esté vacío o nulo--
DELIMITER $$

CREATE TRIGGER VerificarDescripcionModulo
BEFORE INSERT ON Modulo
FOR EACH ROW
BEGIN
    IF NEW.Descripcion IS NULL OR NEW.Descripcion = '' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'La descripcion no puede ser nula o vacía.';
    END IF;
END$$

DELIMITER ;


INSERT INTO Modulo (Nombre, Descripcion, ModuloCol, id_Creador)
VALUES ('Modulo 1', '', 'Columna 1', 1);
INSERT INTO Usuario (Nombre, Email, Rol)
VALUES ('Juan Perez', 'juan@example.com', 'Desarrollador');






