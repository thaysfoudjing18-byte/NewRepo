USE master
CREATE DATABASE ProyectoIntegrador
GO
USE ProyectoIntegrador 
GO

-- CREACIÓN ENTIDADES INDEPENDIENTES -- 
--Creación Tabla Liga -- 
CREATE TABLE Liga
(
idLiga INT IDENTITY(1,1) NOT NULL,
nombreLiga VARCHAR(30) UNIQUE NOT NULL
);
GO

-- Clave Primaria Liga --
ALTER TABLE Liga
ADD CONSTRAINT PK_Liga_idLiga
PRIMARY KEY (idLiga);
GO

-- Creación Tabla Grupo --
CREATE TABLE Grupo
(
idGrupo INT IDENTITY(1,1) NOT NULL,
nombreGrupo NVARCHAR(20) NOT NULL UNIQUE 
);
GO

-- Clave Primaria Grupo --
ALTER TABLE Grupo 
ADD CONSTRAINT PK_Grupo_idGrupo
PRIMARY KEY (idGrupo);
GO

-- Creación Tabla Fase --
CREATE TABLE Fase
(
idFase INT IDENTITY(1,1) NOT NULL, 
nombreFase VARCHAR(30) NOT NULL UNIQUE
);
GO

-- Clave Primaria Fase --
ALTER TABLE Fase
ADD CONSTRAINT PK_Fase_idFase
PRIMARY KEY (idFase);
GO

-- Creación Tabla Pais -- 
CREATE TABLE Pais
(
idPais INT IDENTITY(1,1) NOT NULL, 
nombrePais NVARCHAR(40) NOT NULL UNIQUE, 
rol NVARCHAR(30) NOT NULL CHECK (rol in ('Anfitrion','Participante')) DEFAULT ('Participante')
)
GO;

-- Clave Primaria Pais -- 
ALTER TABLE Pais 
ADD CONSTRAINT PK_Pais_idPais
PRIMARY KEY (idPais);
GO

-- Creación Tabla Arbitro --
CREATE TABLE Arbitro
(
idArbitro INT IDENTITY(1,1) NOT NULL, 
pasaporte VARCHAR(10) NOT NULL UNIQUE,
nombre1Arbitro NVARCHAR(20) NOT NULL, 
nombre2Arbitro NVARCHAR(20),
apellido1Arbitro NVARCHAR(25) NOT NULL,
apellido2Arbitro NVARCHAR(25), 
pais NVARCHAR(20) NOT NULL, 
anioInicio INT,
idArbitroSupervisor INT,
idArbitroReemplazo INT
);
GO

-- Clave Primaria --
ALTER TABLE Arbitro 
ADD CONSTRAINT PK_Arbitro_idArbitro
PRIMARY KEY (idArbitro);
GO

-- Claves Foraneas Recursividad --
ALTER TABLE Arbitro
ADD CONSTRAINT FK_Arbitro_idArbitro_idArbitroSupervisor
FOREIGN KEY (idArbitroSupervisor) REFERENCES Arbitro(idArbitro);
GO

ALTER TABLE Arbitro
ADD CONSTRAINT FK_Arbitro_idArbitro_idArbitroReemplazo
FOREIGN KEY (idArbitroReemplazo) REFERENCES Arbitro(idArbitro);
GO


