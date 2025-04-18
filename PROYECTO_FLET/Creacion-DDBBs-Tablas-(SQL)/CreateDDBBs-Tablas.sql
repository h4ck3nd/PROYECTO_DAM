--============================================================== DDBB appusers ===============================================================================

-- Crea la base de datos
CREATE DATABASE appusers;

-- Conéctate a la base de datos
-- \c appusers; -- (Desde Terminal)

-- Crea la tabla de usuarios
DROP TABLE usuarios;
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
CREATE DATABASE hackend;

-- Crear Tabla en la DDBB de hackend para el cambio de la foto de perfil

DROP TABLE profile;
CREATE TABLE profile (
    id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,  -- ID del usuario, que proviene de la validación con el token
    photo_path VARCHAR(255)
);

-- Tabla Laboratorios
DROP TABLE laboratorios;
CREATE TABLE laboratorios (
    lab_id SERIAL PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    flag VARCHAR(255) NOT NULL,
    puntos INT NOT NULL
);

-- Tabla ValidateFlag (sin clave foránea)
DROP TABLE validate_flag;
CREATE TABLE validate_flag (
    id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    lab_id INT NOT NULL,
    flag VARCHAR(255) NOT NULL,
    puntos INT NOT NULL
);

-- Insertar LABs en tabla laboratorios

INSERT INTO laboratorios (nombre, flag, puntos) VALUES ('foro-xss', 'FLAG{lo_lograste}', 10); -- ID 1
INSERT INTO laboratorios (nombre, flag, puntos) VALUES ('amashop', 'FLAG{amashop_flag}', 20); -- ID 2
INSERT INTO laboratorios (nombre, flag, puntos) VALUES ('hacking_community', 'FLAG{flag_bac}', 10); -- ID 3
INSERT INTO laboratorios (nombre, flag, puntos) VALUES ('separo', 'FLAG{separo_flag}', 15); -- ID 4

-- Crear Tablas para DockerPwned y OvaLabs

DROP TABLE laboratorios_dockerpwned;
CREATE TABLE laboratorios_dockerpwned (
    lab_id SERIAL PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    flag VARCHAR(255) NOT NULL,
    puntos INT NOT NULL
);

DROP TABLE laboratorios_ovalabs;
CREATE TABLE laboratorios_ovalabs (
    lab_id SERIAL PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    flag VARCHAR(255) NOT NULL,
    puntos INT NOT NULL
);

DROP TABLE validate_flag_dockerpwned;
CREATE TABLE validate_flag_dockerpwned (
    id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    lab_id INT NOT NULL,
    flag VARCHAR(255) NOT NULL,
    puntos INT NOT NULL
);

DROP TABLE validate_flag_ovalabs;
CREATE TABLE validate_flag_ovalabs (
    id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    lab_id INT NOT NULL,
    flag VARCHAR(255) NOT NULL,
    puntos INT NOT NULL
);

-- Insertar Datos en "laboratorios" de Dockerpwned y Ovalabs (CTFs)

-- Dockerpwned

INSERT INTO laboratorios_dockerpwned (nombre, flag, puntos) VALUES ('r00tless', 'FLAG{r00tless_flag}', 50); -- ID 1
INSERT INTO laboratorios_dockerpwned (nombre, flag, puntos) VALUES ('crackoff', 'FLAG{crackoff_flag}', 55); -- ID 2

-- Ovalabs

INSERT INTO laboratorios_ovalabs (nombre, flag, puntos) VALUES ('goodness', 'FLAG{goodness_flag}', 25); -- ID 1

-- Inserts de prueba para testeo

INSERT INTO validate_flag_dockerpwned (user_id, lab_id, flag, puntos) VALUES (1, 1, 'FLAG{r00tless_flag}', 50); -- No hace falta añadir (Solamente testeo Dockerpwned)
INSERT INTO validate_flag_ovalabs (user_id, lab_id, flag, puntos) VALUES (1, 1, 'FLAG{goodness_flag}', 25); -- No hace falta añadir (Solamente testeo Ovalabs)

-- Crear Tabla de Writeups (URL)

DROP TABLE writeups;
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

-- Crear Tabla de Writeups Dockerpwned (URL)

DROP TABLE writeups_dockerpwned;
CREATE TABLE writeups_dockerpwned (
    id SERIAL PRIMARY KEY,
    lab_id INTEGER NOT NULL,
    user_id INTEGER NOT NULL,
    url_writeup TEXT NOT NULL
);

ALTER TABLE writeups_dockerpwned
ADD CONSTRAINT unique_lab_user_dockerpwned UNIQUE (lab_id, user_id); -- Esto asegura que para un mismo usuario y lab no existan múltiples entradas.

ALTER TABLE writeups_dockerpwned
ADD COLUMN username TEXT NOT NULL DEFAULT 'desconocido';

-- Crear Tabla de Writeups Ovalabs (URL)

DROP TABLE writeups_ovalabs;
CREATE TABLE writeups_ovalabs (
    id SERIAL PRIMARY KEY,
    lab_id INTEGER NOT NULL,
    user_id INTEGER NOT NULL,
    url_writeup TEXT NOT NULL
);

ALTER TABLE writeups_ovalabs
ADD CONSTRAINT unique_lab_user_ovalabs UNIQUE (lab_id, user_id); -- Esto asegura que para un mismo usuario y lab no existan múltiples entradas.

ALTER TABLE writeups_ovalabs
ADD COLUMN username TEXT NOT NULL DEFAULT 'desconocido';
