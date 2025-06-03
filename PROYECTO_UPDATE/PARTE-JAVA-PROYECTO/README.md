# Proyecto Web Maven – Aplicación Full Stack con Java

Este es un proyecto web desarrollado en **Eclipse IDE for Enterprise Java Developers**, con una arquitectura basada en **Java para el backend** y tecnologías como **HTML, CSS y JavaScript para el frontend**. Se ha denominado `ProyectoWebMaven`, y está construido como una aplicación dinámica que integra **autenticación, lógica de negocio y presentación**.

## 🧠 Descripción General

Este proyecto representa un entorno completo de desarrollo web basado en Java. Combina tanto la capa de presentación (frontend) como la de lógica de negocio (backend) y gestión de sesiones de usuario. 

La autenticación de usuarios está manejada mediante un archivo Python (`main.py`) que se comunica con una base de datos independiente dedicada exclusivamente a la validación de credenciales. Por otro lado, la lógica de la aplicación principal y las operaciones internas están gestionadas desde el entorno Java, utilizando una segunda base de datos separada. Esta separación favorece la seguridad y modularidad del proyecto.

---

## 🛠 Tecnologías Utilizadas

- **Backend**: Java (Servlets, JSP)
- **Frontend**: HTML, CSS, JavaScript
- **Bases de Datos**: PostgreSQL (recomendado), pero puedes adaptarlo a MySQL o SQLite
- **Servidor Web**: Apache Tomcat v9.0
- **IDE Recomendado**: Eclipse Web Developer Edition
- **Autenticación**: Python (`main.py`)
- **Control de Dependencias**: Apache Maven

---

## 📦 Estructura del Proyecto

ProyectoWebMaven/ 

├── src/ 

│ 

└── main/ 

│ 

├── java/ # Servlets y lógica backend 

│ └── webapp/ 

│ 

├── WEB-INF/ # Configuración del proyecto 

│ 

├── css/ # Estilos personalizados 

│ 

├── js/ # Funcionalidad en JavaScript 

│ 

├── img/ # Recursos gráficos 

│ 

└── *.jsp # Páginas JSP 

├── main.py # Script de autenticación 

├── pom.xml # Archivo de Maven 

└── README.md # Este archivo

---

## 🚀 Instalación Paso a Paso

### 1. Requisitos Previos

- **Java JDK 11 o superior**
- **Eclipse IDE for Enterprise Java and Web Developers**
- **Apache Tomcat 9.0**
- **Python 3.10+**
- **PostgreSQL o base de datos equivalente**
- **Maven instalado (opcional, Eclipse puede manejarlo automáticamente)**

---

### 2. Configuración en Eclipse

1. **Clona o descarga** el repositorio.
2. Abre Eclipse y ve a `File > Import > Existing Maven Projects`.
3. Selecciona la carpeta `ProyectoWebMaven`.
4. Espera a que Maven descargue las dependencias.
5. Instala y configura Apache Tomcat:
   - Ve a `Servers > New > Server > Apache Tomcat v9.0`.
   - Elige el directorio de instalación de Tomcat.
6. Arrastra el proyecto al servidor para desplegarlo.
7. Ejecuta el proyecto y accede desde `http://localhost:8080/ProyectoWebMaven`.

---

### 3. Configuración de la Autenticación Python

### 1. Asegúrate de tener `Python 3.10+` instalado.

### 2. Instala las dependencias necesarias con:

```bash
pip install flet flask psycopg2-binary flask_cors jwt requests
```
Configura las credenciales de la base de datos en `main.py`.

Ejecuta el script con:

```
python main.py
```

La `API` debería estar disponible en ``http://localhost:5000``.

---

## 🐞 Errores Comunes y Soluciones

Error	Causa Posible	Solución

`HTTP` Status `404`	El proyecto no se desplegó correctamente	Asegúrate de arrastrar el proyecto al servidor de `Tomcat` en Eclipse
Connection Refused (desde `Python`)	Python o la `API` no están corriendo	Asegúrate de ejecutar main.py antes de usar la app
Database connection failed	Malas credenciales o base de datos no activa	Verifica tu conexión a `PostgreSQL` y revisa los datos de acceso
Could not load main class	Maven no ha construido el proyecto
Ejecuta un clean y install desde Maven o reconstruye el proyecto

---

## 🧪 Consejos para Nuevos Usuarios

Asegúrate de tener las variables de entorno del JDK bien configuradas (JAVA_HOME).

Lee sobre cómo funcionan los Servlets y JSP si no estás familiarizado.

No mezcles lógica de autenticación directamente en el backend Java; mantenerlo separado en Python es una buena práctica.

Revisa el pom.xml si necesitas agregar más dependencias como JSTL, Hibernate, etc.

---

## 📩 Contacto y Créditos

Este proyecto ha sido creado por D1seo y Manu con fines educativos y de aprendizaje.

Si deseas contribuir, reportar errores o dar sugerencias, no dudes en abrir un issue o crear un pull request.

¡Esperamos que te sea útil y aprendas mucho en el proceso! 🚀

---
