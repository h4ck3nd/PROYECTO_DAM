<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Contacto | Hacking Community</title>
  <style>
    * {
  box-sizing: border-box;
  margin: 0;
  padding: 0;
}

body, html {
  font-family: 'Inter', sans-serif;
  background-color: #1e212d;
  color: #fff;
  line-height: 1.6;
  min-height: 100vh;
  display: flex;
  flex-direction: column;
}

.container {
  max-width: 800px;
  margin: 0 auto;
  padding: 20px;
  flex: 1;
}

header {
  background-color: #0a0c11;
  padding: 20px 0;
  border-bottom: 1px solid #212430;
  text-align: center;
}

.logo {
  font-size: 1.8rem;
  font-weight: 800;
  color: #00ffae;
}

nav ul {
  list-style: none;
  display: flex;
  gap: 30px;
  justify-content: center;
}

nav a {
  color: #fff;
  text-decoration: none;
  font-weight: 600;
  transition: color 0.3s ease-in-out;
}

nav a:hover {
  color: #00ffae;
}

h1 {
  font-size: 2rem;
  margin: 30px 0 10px;
  text-align: center;
}

.intro-text {
  margin-bottom: 30px;
  font-size: 1.1rem;
  color: #ccc;
  text-align: center;
}

.contact-form {
  display: flex;
  flex-direction: column;
  gap: 20px;
}

.contact-form label {
  font-weight: 600;
  color: #00ffae;
  text-align: center;
}

.contact-form input,
.contact-form textarea {
  background-color: #2e323d;
  border: 1px solid #444;
  padding: 12px;
  border-radius: 5px;
  color: #fff;
  font-size: 1rem;
  transition: border 0.3s ease;
}

.contact-form input:focus,
.contact-form textarea:focus {
  border-color: #00ffae;
  outline: none;
}

.contact-form button {
  background-color: #00ffae;
  color: #000;
  padding: 12px;
  font-weight: bold;
  border: none;
  border-radius: 5px;
  cursor: pointer;
  transition: background 0.3s ease;
}

.contact-form button:hover {
  background-color: #00e3a0;
}

footer {
  background-color: #0a0c11;
  padding: 20px;
  text-align: center;
  color: #888;
}

  </style>
</head>
<body>
  <header>
    <div class="container">
      <div class="logo">HACKING COMMUNITY</div>
      <nav>
        <ul>
          <li><a href="hacking_community.jsp">Inicio</a></li>
          <li><a href="contacto.jsp">Contacto</a></li>
        </ul>
      </nav>
    </div>
  </header>

  <main class="container">
    <h1>Contacto</h1>
    <p class="intro-text">¿Tienes dudas, sugerencias o quieres colaborar con nosotros? Rellena el formulario y nos pondremos en contacto contigo lo antes posible.</p>

    <form class="contact-form">
      <label for="nombre">Nombre</label>
      <input type="text" id="nombre" name="nombre" required />

      <label for="email">Correo electrónico</label>
      <input type="email" id="email" name="email" required />

      <label for="mensaje">Mensaje</label>
      <textarea id="mensaje" name="mensaje" rows="6" required></textarea>

      <button type="submit">Enviar mensaje</button>
    </form>
  </main>

  <footer>
    <p>&copy; 2025 Hacking Community. Todos los derechos reservados.</p>
  </footer>
  <script>
  const form = document.querySelector('.contact-form');

  form.addEventListener('submit', function (e) {
    e.preventDefault(); // Evita que se recargue la página

    // Opcional: puedes resetear los campos si quieres
    form.reset();

    // Crear y mostrar el mensaje de confirmación
    const mensaje = document.createElement('p');
    mensaje.textContent = '¡Gracias por contactar! Te responderemos pronto.';
    mensaje.style.color = '#00ffae';
    mensaje.style.marginTop = '20px';
    mensaje.style.fontWeight = '600';
    mensaje.style.textAlign = 'center';

    // Insertar el mensaje debajo del formulario
    form.parentNode.insertBefore(mensaje, form.nextSibling);
  });
  </script>
</body>
</html>
