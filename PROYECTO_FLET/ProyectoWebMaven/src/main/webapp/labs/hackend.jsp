<%@ page import="utils.JWTUtils" %>
<%@ page import="utils.UsuarioJWT" %>

<%
    UsuarioJWT usuarioJWT = null;

	try {
	    usuarioJWT = JWTUtils.obtenerUsuarioDesdeRequest(request);
	} catch (Exception e) {
	    // Redirigir al servlet de logout en vez de al .jsp
	    response.sendRedirect(request.getContextPath() + "/logout");
	    return;
	}
%>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>HACKEND - Aprende Hacking �tico</title>
  <style>
    * {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
  scroll-behavior: smooth;
}

body {
  font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
  background: #0f0f1a;
  color: #f0f0f0;
  line-height: 1.6;
}

.hero {
  background: linear-gradient(145deg, #0f0f1a, #1a1a2e);
  padding: 100px 20px;
  text-align: center;
  color: #00ffe7;
  box-shadow: 0 0 20px #00ffe7;
}

.hero-content h1 {
  font-size: 3em;
  margin-bottom: 10px;
}

.hero-content p {
  font-size: 1.2em;
  margin-bottom: 30px;
}

.btn-cta {
  padding: 12px 25px;
  font-size: 1em;
  background: #00ffe7;
  color: #0f0f1a;
  border: none;
  border-radius: 10px;
  text-decoration: none;
  font-weight: bold;
  transition: 0.3s;
}

.btn-cta:hover {
  background: #00c9ff;
}

section {
  padding: 60px 20px;
  max-width: 1100px;
  margin: auto;
}

.about, .faq {
  background: #1a1a2e;
  border-radius: 10px;
  box-shadow: 0 0 10px #0ff;
  margin-top: 40px;
}

h2 {
  font-size: 2em;
  color: #00ffe7;
  margin-bottom: 20px;
  text-align: center;
}

.lab-grid {
  display: flex;
  flex-wrap: wrap;
  gap: 20px;
  justify-content: center;
}

.lab-card {
  background: #111122;
  border: 1px solid #00ffe7;
  border-radius: 10px;
  padding: 20px;
  width: 300px;
  transition: 0.3s;
  border-radius: 5px 50px;
}

.lab-card:hover {
  transform: scale(1.05);
  box-shadow: 0 0 15px #00ffe7;
}

.faq {
    border-radius: 5px 50px;
}

.faq-item {
  margin-bottom: 15px;
}

.faq-question {
  background: none;
  border: none;
  color: #00ffe7;
  font-size: 1.1em;
  cursor: pointer;
  width: 100%;
  text-align: left;
  padding: 10px;
}

.faq-answer {
  max-height: 0;
  overflow: hidden;
  transition: max-height 0.4s ease;
  padding: 0 10px;
}

.faq-item.active .faq-answer {
  max-height: 200px;
  margin-top: 10px;
  color: #ccc;
}

.cta-final {
  background: #141421;
  padding: 60px 20px;
  text-align: center;
  box-shadow: 0 0 20px #00ffe733;
  margin-top: 80px;
  border-radius: 5px 50px;
}

.cta-final h2 {
  font-size: 2em;
  margin-bottom: 15px;
  color: #00ffe7;
}

.cta-final p {
  font-size: 1.1em;
  color: #ccc;
  margin-bottom: 10px;
  max-width: 800px;
  margin-left: auto;
  margin-right: auto;
}

.cta-final .btn-cta {
  padding: 15px 30px;
  font-size: 1.2em;
  background: #00ffe7;
  color: #0f0f1a;
  border-radius: 10px;
  display: inline-block;
  margin-top: 20px;
  text-decoration: none;
  font-weight: bold;
  box-shadow: 0 0 10px #00ffe7, 0 0 20px #00c9ff;
  transition: 0.3s ease;
}

.cta-final .btn-cta:hover {
  background: #00c9ff;
  box-shadow: 0 0 20px #00ffe7, 0 0 40px #00c9ff;
}

footer {
  text-align: center;
  padding: 20px;
  background: #0a0a14;
  border-top: 2px solid #00ffe7;
  color: #888;
}

  </style>
</head>
<body>
    <header class="hero">
      <div class="hero-content">
        <h1>HACKEND</h1>
        <p>Domina el Hacking Web �tico desde cero hasta experto en entornos CTF controlados.</p>
        <a href="#cursos" class="btn-cta">Ver Cursos</a>
      </div>
    </header>
  
    <section class="about" id="about">
      <h2>�Qu� es el Hacking Web �tico?</h2>
      <p>El hacking �tico web consiste en identificar y solucionar vulnerabilidades en aplicaciones web de forma legal y responsable. Aprender�s t�cnicas utilizadas por profesionales para fortalecer la seguridad de los sistemas.</p>
    </section>
  
    <section class="benefits" id="benefits">
      <h2>�Por qu� aprender Hacking Web �tico?</h2>
      <ul>
        <li>Alta demanda laboral en ciberseguridad.</li>
        <li>Desarrollo de habilidades t�cnicas avanzadas.</li>
        <li>Contribuci�n a un internet m�s seguro.</li>
        <li>Oportunidades de carrera como pentester o analista de seguridad.</li>
      </ul>
    </section>
  
    <section class="courses" id="cursos">
      <h2>Nuestros Cursos</h2>
      <div class="course-grid">
        <div class="course-card">
          <h3>Introducci�n al Hacking Web</h3>
          <p>Curso para principiantes donde aprender�s los fundamentos del hacking web y las herramientas b�sicas.</p>
        </div>
        <div class="course-card">
          <h3>Hacking Web Intermedio</h3>
          <p>Profundiza en t�cnicas como inyecciones SQL, XSS avanzado y explotaci�n de vulnerabilidades complejas.</p>
        </div>
        <div class="course-card">
          <h3>Hacking Web Avanzado</h3>
          <p>Enfrenta desaf�os reales en entornos CTF dise�ados para simular escenarios del mundo real.</p>
        </div>
      </div>
    </section>
  
    <section class="labs" id="laboratorios">
      <h2>Laboratorios Interactivos (CTF)</h2>
      <div class="lab-grid">
        <div class="lab-card">
          <h3>CTF para Principiantes</h3>
          <p>Practica con retos b�sicos para familiarizarte con el entorno y las t�cnicas esenciales.</p>
        </div>
        <div class="lab-card">
          <h3>CTF Intermedio</h3>
          <p>Desaf�os de dificultad media que pondr�n a prueba tus conocimientos adquiridos.</p>
        </div>
        <div class="lab-card">
          <h3>CTF Avanzado</h3>
          <p>Retos complejos que simulan escenarios reales para prepararte para el mundo profesional.</p>
        </div>
      </div>
    </section>
  
    <section class="testimonials" id="testimonios">
      <h2>Testimonios</h2>
      <div class="testimonial">
        <p>"Gracias a CyberHack Lab, ahora trabajo como analista de seguridad en una empresa l�der."</p>
        <h4>- Juan P�rez</h4>
      </div>
      <div class="testimonial">
        <p>"Los laboratorios CTF me ayudaron a mejorar mis habilidades pr�cticas de manera significativa."</p>
        <h4>- Mar�a G�mez</h4>
      </div>
    </section>
  
    <section class="faq" id="faq">
      <h2>Preguntas Frecuentes</h2>
      <div class="faq-item">
        <button class="faq-question">�Necesito experiencia previa?</button>
        <div class="faq-answer">No, ofrecemos cursos desde nivel principiante hasta avanzado.</div>
      </div>
      <div class="faq-item">
        <button class="faq-question">�Qu� herramientas utilizar�?</button>
        <div class="faq-answer">Usar�s herramientas como Burp Suite, SQLmap y navegadores con extensiones especializadas.</div>
      </div>
      <div class="faq-item">
        <button class="faq-question">�Los laboratorios son seguros?</button>
        <div class="faq-answer">S�, est�n dise�ados en entornos controlados para garantizar una pr�ctica segura.</div>
      </div>
    </section>
  
    <section class="cta-final">
        <h2>Tu viaje en el hacking web comienza aqu�</h2>
        <p>No necesitas experiencia previa. Solo curiosidad, ganas de aprender y pasi�n por descubrir lo que otros ocultan. �nete ahora a nuestros laboratorios y convi�rtete en parte de la �lite cibern�tica.</p>
        <p><strong>Haz clic en "Iniciar Curso" y comienza tu transformaci�n hoy.</strong></p>
        <a href="http://localhost:30050/" class="btn-cta">Iniciar Curso</a>
      </section>
      <br><br>
  
    <footer>
      <p>&copy; 2025 HACKEND. Todos los derechos reservados.</p>
    </footer>

  <script>
    // FAQ toggle
document.querySelectorAll('.faq-question').forEach(button => {
  button.addEventListener('click', () => {
    const faqItem = button.parentElement;
    faqItem.classList.toggle('active');
  });
});

  </script>
</body>
</html>