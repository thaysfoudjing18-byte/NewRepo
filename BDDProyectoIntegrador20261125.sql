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

-- CREACIÓN ENTIDADES DEPENDIENTES -- 
--Creación Tabla Seleccion--
CREATE TABLE Seleccion
(
idSeleccion INT IDENTITY(1,1) NOT NULL, 
idPais INT NOT NULL,
nombreSeleccion NVARCHAR(100)NOT NULL UNIQUE,
lugarEntrenamiento NVARCHAR(50) 
);
GO

-- Clave Primaria --
ALTER TABLE Seleccion
ADD CONSTRAINT PK_Seleccion_idSeleccion
PRIMARY KEY (idSeleccion);
GO

-- Claves Foráneas --
ALTER TABLE Seleccion
ADD CONSTRAINT FK_Seleccion_Pais_idPais
FOREIGN KEY (idPais) REFERENCES Pais(idPais);
GO

--Creación Tabla MiembroCuerpoTecnico--
CREATE TABLE MiembroCuerpoTecnico
(
idCuerpoTecnico INT IDENTITY(1,1) NOT NULL, 
idSeleccion INT NOT NULL,
nombreMiembro NVARCHAR(50)NOT NULL,
apellidoMiembro NVARCHAR(50)NOT NULL,
cargo VARCHAR(20) 
);
GO

-- Clave Primaria --
ALTER TABLE MiembroCuerpoTecnico
ADD CONSTRAINT PK_MiembroCuerpoTecnico_idCuerpoTecnico
PRIMARY KEY (idCuerpoTecnico);
GO

-- Claves Foráneas --
ALTER TABLE MiembroCuerpoTecnico
ADD CONSTRAINT FK_MiembroCuerpoTecnico_Seleccion_idSeleccion
FOREIGN KEY (idSeleccion) REFERENCES Seleccion(idSeleccion);
GO

--Creación Tabla Club--
CREATE TABLE Club
(
idClub INT IDENTITY(1,1) NOT NULL, 
nombreClub NVARCHAR(100)NOT NULL UNIQUE,
idLiga INT NOT NULL
);
GO

-- Clave Primaria --
ALTER TABLE Club
ADD CONSTRAINT PK_Club_idClub
PRIMARY KEY (idClub);
GO

-- Claves Foráneas --
ALTER TABLE Club
ADD CONSTRAINT FK_Club_Liga_idLiga
FOREIGN KEY (idLiga) REFERENCES Liga(idLiga);
GO

--Creación Tabla Jugador--
CREATE TABLE Jugador
(
numeroCamiseta CHAR(2) NOT NULL,
idSeleccion INT NOT NULL, 
idClub INT NOT NULL,
nombre1Jugador NVARCHAR(50) NOT NULL,
nombre2Jugador NVARCHAR(50),
apellido1Jugador NVARCHAR(50) NOT NULL,
apellido2Jugador NVARCHAR(50),
apodo NVARCHAR(20),
posicion VARCHAR(20) CHECK (posicion in ('Portero','Defensa','Mediocampo','Delantero'))
);
GO

-- Clave Primaria --
ALTER TABLE Jugador
ADD CONSTRAINT PK_Jugador_numeroCamiseta
PRIMARY KEY (numeroCamiseta);
GO

-- Claves Foráneas --
ALTER TABLE Jugador
ADD CONSTRAINT FK_Jugador_Seleccion_idSeleccion
FOREIGN KEY (idSeleccion) REFERENCES Seleccion(idSeleccion);
GO

ALTER TABLE Jugador
ADD CONSTRAINT FK_Jugador_Club_idClub
FOREIGN KEY (idClub) REFERENCES Club(idClub);
GO

--Creación Tabla TablaPosicion--
CREATE TABLE TablaPosicion
(
idTablaPosicion INT IDENTITY(1,1) NOT NULL, 
idSeleccion INT NOT NULL,
idGrupo INT NOT NULL,
partidoJugado NVARCHAR(50) NOT NULL,
partidoGanado NVARCHAR(50),
partidoEmpatado NVARCHAR(50),
partidoPerdido NVARCHAR(50),
golAFavor INT, 
golEnContra INT, 
posicionGrupo INT NOT NULL UNIQUE,
estadoClasificacion VARCHAR(20) CHECK (estadoClasificacion in ('Clasificado','Desclasificado')) DEFAULT('Clasificado')
);
GO

-- Clave Primaria --
ALTER TABLE TablaPosicion
ADD CONSTRAINT PK_TablaPosicion_idTablaPosicion
PRIMARY KEY (idTablaPosicion);
GO

-- Claves Foráneas --
ALTER TABLE TablaPosicion
ADD CONSTRAINT FK_TablaPosicion_Seleccion_idSeleccion
FOREIGN KEY (idSeleccion) REFERENCES Seleccion(idSeleccion);
GO

ALTER TABLE TablaPosicion
ADD CONSTRAINT FK_TablaPosicion_Grupo_idGrupo
FOREIGN KEY (idGrupo) REFERENCES Grupo(idGrupo);
GO

--Creación Tabla Ciudad--
CREATE TABLE Ciudad
(
idCiudad INT IDENTITY(1,1) NOT NULL,
idPais INT NOT NULL,
nombreCiudad NVARCHAR(50) NOT NULL
);
GO

--Creación Clave Primaria--
ALTER TABLE Ciudad
ADD CONSTRAINT PK_Ciudad_idCiudad
PRIMARY KEY (idCiudad);
GO

--Creación Claver Foráneas--
ALTER TABLE Ciudad
ADD CONSTRAINT FK_Ciudad_Pais_idPais
FOREIGN KEY (idPais) REFERENCES Pais(idPais);
GO

--Creación Tabla Estadio--
CREATE TABLE Estadio
(
idEstadio INT IDENTITY(1,1) NOT NULL,
idCiudad INT NOT NULL,
nombreEstadio NVARCHAR(30) NOT NULL,
capacidadMaxima INT,
asistenciaRegistrada INT
);
GO

--Creación Clave Primaria--
ALTER TABLE Estadio
ADD CONSTRAINT PK_Estadio_idEstadio
PRIMARY KEY (idEstadio);
GO

--Creación Claves Foráneas--
ALTER TABLE Estadio
ADD CONSTRAINT FK_Estadio_Ciudad_idCiudad
FOREIGN KEY(idCiudad) REFERENCES Ciudad(idCiudad);
GO

--Creación Tabla Partido--
CREATE TABLE Partido
(
idPartido INT IDENTITY(1,1) NOT NULL,
idFase INT NOT NULL,
idEstadio INT NOT NULL,
idArbitro INT NOT NULL,
fecha DATETIME NOT NULL,
hora TIME,
duracion TIME
);
GO

--Creación Clave Primaria--
ALTER TABLE Partido
ADD CONSTRAINT PK_Partido_idPartido
PRIMARY KEY (idPartido);
GO

--Creación Claves Foráneas--
ALTER TABLE Partido
ADD CONSTRAINT FK_Partido_Fase_idFase
FOREIGN KEY (idFase) REFERENCES Fase(idFase);
GO

ALTER TABLE Partido
ADD CONSTRAINT FK_Partido_Estadio_idEstadio
FOREIGN KEY (idEstadio) REFERENCES Estadio(idEstadio);
GO

ALTER TABLE Partido
ADD CONSTRAINT FK_Partido_Arbitro_idArbitro
FOREIGN KEY (idArbitro) REFERENCES Arbitro(idArbitro);
GO

--Creacion Tabla Hincha--
CREATE TABLE Hincha
(
idHincha INT IDENTITY(1,1) NOT NULL,
idPartido INT NOT NULL,
vestimenta VARCHAR(20)
);
GO

--Creación Clave Primaria--
ALTER TABLE Hincha
ADD CONSTRAINT PK_Hincha_idHincha
PRIMARY KEY (idHincha);
GO

--Creación Claves Foráneas--
ALTER TABLE Hincha
ADD CONSTRAINT FK_Hincha_Partido_idPartido
FOREIGN KEY(idPartido) REFERENCES Partido(idPartido);
GO

--Creación Tabla Ticket--
CREATE TABLE Ticket
(
idTicket INT IDENTITY(1,1) NOT NULL,
zona VARCHAR(20),
fila INT,
numeroAsiento INT NOT NULL,
idHincha INT NOT NULL,
idPartido INT NOT NULL
);
GO

--CREACIÓN TABLA ASOCIATIVA--
CREATE TABLE SeleccionPartido
(
idSeleccion INT NOT NULL,
idPartido INT NOT NULL,
golDisupta INT NOT NULL,
tarjetaAmarilla INT,
tarjetaRoja INT,
condicion VARCHAR(20)
);
GO

--Creacion Claves Primarias--
ALTER TABLE SeleccionPartido
ADD CONSTRAINT PK_SeleccionPartido_idSeleccion_idPartido
PRIMARY KEY(idSeleccion,idPartido);
GO

--Creación Claves Foráneas--
ALTER TABLE SeleccionPartido
ADD CONSTRAINT FK_SeleccionPartido_Seleccion_idSeleccion
FOREIGN KEY(idSeleccion) REFERENCES Seleccion(idSeleccion);
GO

ALTER TABLE SeleccionPartido
ADD CONSTRAINT FK_SeleccionPartido_Partido_idPartido
FOREIGN KEY(idPartido) REFERENCES Partido(idPartido);
GO
