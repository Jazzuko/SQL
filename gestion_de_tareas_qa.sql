CREATE DATABASE gestion_de_tareas_qa;
USE gestion_de_tareas_qa;

CREATE TABLE Usuario (
    idUsuario INT PRIMARY KEY AUTO_INCREMENT,
    Nombre VARCHAR(100) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    Rol ENUM('Admin', 'Tester', 'Desarrollador') NOT NULL
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
    Estado ENUM('Abierto', 'En Progreso', 'Cerrado') NOT NULL,
    Fecha_creacion DATE,
    Fecha_resolucion DATE,
    Id_caso_prueba INT,
    Id_asignado_a INT,
    FOREIGN KEY (Id_caso_prueba) REFERENCES Casos_De_Prueba(idCasos_De_Prueba),
    FOREIGN KEY (Id_asignado_a) REFERENCES Usuario(idUsuario)
);





