-- Crea la base de datos
CREATE DATABASE appusers;

-- Conéctate a la base de datos
\c appusers;

-- Crea la tabla de usuarios
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

-- Crear Tabla en la DDBB de hackend para el cambio de la foto de perfil

CREATE TABLE profile (
    id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,  -- ID del usuario, que proviene de la validación con el token
    photo_path VARCHAR(255)
);
