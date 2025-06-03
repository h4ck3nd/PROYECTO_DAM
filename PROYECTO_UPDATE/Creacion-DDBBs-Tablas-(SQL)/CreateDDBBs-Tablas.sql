--============================================================== DDBB appusers ===============================================================================

-- Crea la base de datos
-- CREATE DATABASE appusers;

-- Conéctate a la base de datos
-- \c appusers; -- (Desde Terminal)

-- Crea la tabla de usuarios
DROP TABLE IF EXISTS usuarios;
CREATE TABLE usuarios (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellidos VARCHAR(50) NOT NULL,
    email VARCHAR(120) UNIQUE NOT NULL,
    usuario VARCHAR(128) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    estado BOOLEAN DEFAULT TRUE,
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    rol VARCHAR(10) DEFAULT 'user',
    ultimo_login TIMESTAMP
);

-- Añadir la columna "Cookie" a la tabla usuarios
ALTER TABLE usuarios ADD COLUMN cookie VARCHAR(255) UNIQUE;

--============================================================== DDBB hackend ===============================================================================

-- Crea la base de datos (hackend)
-- CREATE DATABASE hackend_update;

-- Crear Tabla en la DDBB de hackend para el cambio de la foto de perfil

DROP TABLE IF EXISTS profile;
CREATE TABLE profile (
    id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,  -- ID del usuario, que proviene de la validación con el token
    photo_path VARCHAR(255)
);

-- Tabla Laboratorios
DROP TABLE IF EXISTS laboratorios;
CREATE TABLE laboratorios (
    lab_id SERIAL PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    flag VARCHAR(255) NOT NULL,
    puntos INT NOT NULL
);

-- Tabla ValidateFlag (sin clave foránea)
DROP TABLE IF EXISTS validate_flag;
CREATE TABLE validate_flag (
    id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    lab_id INT NOT NULL,
    flag VARCHAR(255) NOT NULL,
    puntos INT NOT NULL
);

-- Insertar LABs en tabla laboratorios

INSERT INTO laboratorios (nombre, flag, puntos) VALUES ('foro-xss', 'FLAG{lo_lograste}', 10); -- ID 1
INSERT INTO laboratorios (nombre, flag, puntos) VALUES ('separo', 'FLAG{separo_flag}', 20); -- ID 2

-- Crear Tabla de Writeups (URL)

DROP TABLE IF EXISTS writeups;
CREATE TABLE writeups (
    id SERIAL PRIMARY KEY,
    lab_id INTEGER NOT NULL,
    user_id INTEGER NOT NULL,
    url_writeup TEXT NOT NULL
);

ALTER TABLE writeups
ADD CONSTRAINT unique_lab_user UNIQUE (lab_id, user_id); -- Esto asegura que para un mismo usuario y lab no existan múltiples entradas.

ALTER TABLE writeups
ADD COLUMN username TEXT NOT NULL DEFAULT 'desconocido';