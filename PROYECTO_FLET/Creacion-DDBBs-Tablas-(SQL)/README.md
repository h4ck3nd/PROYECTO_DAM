# Proyecto Web Maven – Aplicación Full Stack con Java

Este proyecto representa un entorno completo de desarrollo web utilizando **Java (Servlets + JSP)** para el backend y **HTML, CSS, JavaScript** para el frontend. La autenticación se maneja por separado mediante un script Python (`main.py`) conectado a una base de datos propia. Todo esto se ejecuta sobre un servidor Apache Tomcat local.

---

## 📁 Estructura de Bases de Datos (PostgreSQL)

Este proyecto requiere **dos bases de datos separadas** en PostgreSQL para funcionar correctamente:

### 1. `appusers` – Autenticación

Esta base de datos contiene los datos de los usuarios que pueden iniciar sesión.

#### Uso:

- Consultada únicamente desde `main.py` para login y registro de usuarios.
- Separada de la lógica Java para mantener mayor seguridad y control.

---

### 2. `hackend` – Lógica Java

Contiene los datos relacionados con el funcionamiento de la aplicación web en Java. Aquí es donde se gestionan flags, writeups, logs, laboratorios, etc.

---

### 📄 Archivo SQL Recomendado: `estructura_bases.sql`

Te recomiendo tener un único archivo `.sql` con la estructura que se encuentra en dicho archivo.

## 🧪 ¿Cómo importar el .sql en PostgreSQL?

Abre tu terminal (o pgAdmin si prefieres entorno gráfico).

Ejecuta:

```
psql -U postgres -f estructura_bases.sql
```

Verifica que se han creado ambas bases de datos con \l y luego con \dt dentro de cada una.

⚠️ Posibles Errores y Soluciones

Error	Posible Causa	Solución
psql: FATAL: database "usuarios_db" does not exist	No se creó correctamente	Asegúrate de que el script .sql se ejecutó sin errores
duplicate key value violates unique constraint	Estás intentando insertar un usuario con el mismo correo	Usa correos únicos
relation "usuarios" does not exist	Estás en la base de datos equivocada	Cambia con \c usuarios_db antes de crear tablas
python can't connect to PostgreSQL	Malas credenciales o puerto incorrecto	Verifica host, puerto, usuario y contraseña en main.py
📝 Recomendaciones
Usa contraseñas hasheadas (con bcrypt, por ejemplo) en la tabla de usuarios.

Crea un usuario PostgreSQL dedicado para la app, con permisos limitados.

Usa variables de entorno para manejar tus credenciales (en vez de ponerlas en código plano).

¿Querés que te prepare el archivo .sql listo para descargar o incluso que te genere ejemplos de inserciones dummy (de prueba)? También te puedo hacer una validación de seguridad para las tablas si querés orientarlo a producción 🔐
