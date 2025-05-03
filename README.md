📄 README.md

# Plataforma CTF para Laboratorios de Hacking

Este repositorio contiene un proyecto web completo orientado a la creación de una **plataforma CTF (Capture The Flag)**, diseñada para entornos de laboratorio donde los usuarios pueden poner en práctica sus habilidades en hacking web, retos con Docker, máquinas virtuales (OVAs) y más.

## 🧩 Características principales

- **Sistema de login seguro** mediante **autenticación por token JWT**
- **Frontend moderno** con [Flet](https://flet.dev/)
- Backend híbrido:
  - **Python (Flask)** para autenticación, login y gestión de usuarios
  - **Java (Tomcat + JSP/Servlets)** para la lógica web de los retos y la interfaz principal
- **Gestión de usuarios**: perfil, progreso, writeups, validación de flags, subida de imágenes, etc.
- **Soporte para entornos de laboratorio**: retos en Docker y OVAs
- **Separación de responsabilidades** entre backend Python y backend Java
- **Base de datos doble**:
  - Una exclusiva para **autenticación y tokens (Python)**
  - Otra para la **aplicación principal (Java)**

---

## 🧪 Arquitectura general

┌────────────┐     Token JWT      ┌──────────────┐

│ Flask API  │ ─────────────────▶ │  Backend Java│

│ (Python)   │                    │ (Tomcat)     │

└────┬───────┘                    └────┬─────────┘

│  DB usuarios (tokens)           │ DB app: retos, perfiles, flags

    ▼                                  ▼

┌──────────┐                     ┌─────────────┐

│ SQLite / │                     │  MySQL /    │

│ Postgre  │                     │ PostgreSQL  │

└──────────┘                     └─────────────┘

---

## 🔐 Autenticación

1. El usuario inicia sesión desde el frontend (Flet) y envía sus credenciales al backend en Flask.
2. Flask valida el usuario contra su base de datos y, si es correcto, genera un **token JWT**.
3. Ese token se envía al backend Java, que lo valida para permitir navegación, acceso a retos, escritura de writeups, etc.

---

## 🧱 Tecnologías utilizadas

- **Backend Python**:
  - Python 3
  - Flask
  - SQLite o PostgreSQL
  - JWT (PyJWT)
  - Pycharm

- **Backend Java**:
  - Java EE con Servlets y JSP
  - Tomcat 9+
  - JDBC
  - Eclipse IDE

- **Frontend**:
  - [Flet](https://flet.dev/) (Python)

- **Bases de datos**:
  - DB usuarios: SQLite/PostgreSQL (manejada por Python)
  - DB retos/perfiles: MySQL/PostgreSQL (manejada por Java)

---

## 🧪 Funcionalidades principales

- Registro e inicio de sesión seguro con validación por token
- Visualización y edición de perfil de usuario
- Subida de avatar e imágenes
- Envío de writeups por reto
- Validación automática de flags
- Seguimiento de progreso en el dashboard
- Backend Python completamente desacoplado del de Java
- Control de acceso por token a todos los endpoints de Java

---

## 🚀 Cómo ejecutar el proyecto

1. **Python backend (Flask)**:

```bash
pip install -r requirements.txt
python3.11 main.py
```

2. **Java backend (Tomcat)**:

  - Importar el proyecto en Eclipse
  - Configurar conexión a la base de datos
  - Ejecutar en servidor Tomcat

3. **Frontend (Flet)**:

```bash
python3.11 main.py
```

## 🧪 Requisitos

- Python 3.10+
- Java JDK 11+
- Tomcat 9+
- Pycharm y Eclipse recomendados para desarrollo
- PostgreSQL o MySQL para bases de datos

## 🤝 Contribuciones

Este proyecto está abierto a mejoras, sugerencias y contribuciones. Puedes enviar pull requests o abrir issues si encuentras algún problema o tienes ideas para nuevas funcionalidades.

## 📜 Licencia

Este proyecto se publica bajo la licencia MIT.

## 🧠 Autor

Desarrollado como parte de un laboratorio educativo para retos de seguridad informática y plataformas CTF personalizadas.
