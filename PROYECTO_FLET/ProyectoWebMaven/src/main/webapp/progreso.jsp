<%@ page import="dao.FotoDAO" %>
<%@ page import="utils.JWTUtils" %>
<%@ page import="utils.UsuarioJWT" %>
<%@ page import="javax.servlet.http.HttpSession" %>

<%
    UsuarioJWT usuarioJWT = null;

	try {
	    usuarioJWT = JWTUtils.obtenerUsuarioDesdeRequest(request);
	} catch (Exception e) {
	    // Redirigir al servlet de logout en vez de al .jsp
	    response.sendRedirect(request.getContextPath() + "/logout");
	    return;
	}

    // Validar que userId no sea null ni vac�o
    if (usuarioJWT.getUserId() == null || usuarioJWT.getUserId().isEmpty()) {
        out.println("<p>Error: El ID de usuario no est� disponible en el token.</p>");
        return;
    }

    // Crear una instancia del DAO y obtener la foto de perfil
    FotoDAO fotoDAO = new FotoDAO();
    String photoPath = fotoDAO.obtenerRutaFotoPerfil(usuarioJWT.getUserId());

    // Si no tiene foto de perfil, establecer una imagen por defecto
    if (photoPath == null || photoPath.isEmpty()) {
        photoPath = "img/Profile.png";  // Ruta de la imagen por defecto
    }
    
%>
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="icon" type="image/png" href="<%= request.getContextPath() %>/img/icono/icono_cinco_hackend.ico">
<title>HACKEND - PROGRESO PERFIL</title>
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/progreso.css">
</head>
<body>
	<header class="main-header">
	<img src="<%= request.getContextPath() %>/<%= photoPath %>" alt="Foto de perfil" class="profile-image-update">
	<div class="left-text">PROGRESO</div>
	<h1 class="titulo">HACKEND</h1>
	<div class="window-buttons">
		<button class="btn minimizar">-</button>
			<button class="btn maximizar">O</button>
			<button onclick="window.location.href='/ProyectoWebMaven/profile.jsp'" class="btn cerrar">X</button>
	</div>
</header>
	<!-- Formulario oculto para enviar el ID del usuario -->
	<form id="autoSubmitForm" action="<%= request.getContextPath() %>/obtener-puntos" method="post">
	    <input type="hidden" name="userId" value="<%= usuarioJWT.getUserId() %>" />
	    <button type="submit" class="btn-update">ACTUALIZAR PAGINA</button>
	</form>
	<section class="grafico-container">
		<h2>Progreso en Laboratorios</h2>
		<canvas id="labChart" width="400" height="400"></canvas>
	</section>
	<main class="columns-container">
		<!-- Hacking Web -->
		<section class="lab-column">
			<h2>Hacking Web</h2>
			<p id="puntos-hacking" class="puntuacion-total">
			  Puntuaci�n: ${puntosHackingWeb} / ${puntosTotalesLab1}
			</p>
			<div class="lab-card">
				<h3>Hacking Web</h3>
				<p>Pagina Hacking Web</p>
			</div>
		</section>

		<!-- DockerPwned -->
		<section class="lab-column">
			<h2>DockerPwned</h2>
			<p id="puntos-docker" class="puntuacion-total">
			  Puntuaci�n: ${puntosDockerPwned} / ${puntosTotalesLab2}
			</p>
			<div class="lab-card">
				<h3>DockerPwned</h3>
				<p>Pagina DockerPwned</p>
			</div>
		</section>

		<!-- OvaLabs -->
		<section class="lab-column">
			<h2>OvaLabs</h2>
			<p id="puntos-ova" class="puntuacion-total">
			  Puntuaci�n: ${puntosOvaLabs} / ${puntosTotalesLab3}
			</p>
			<div class="lab-card">
				<h3>OvaLabs</h3>
				<p>Pagina OvaLabs</p>
			</div>
		</section>
	</main>
	<div class="contenedor-exportar">
  <button class="btn-exportar">Exportar PDF</button>
</div>
	<footer class="footer"> &copy; 2025 Hackend. Todos los
		derechos reservados. 
	</footer>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
	//QUESO ESTADISTICAS
	const puntosPorLaboratorio = [
	  "${puntosXSS1}",  // Foro-xss (Hacking Web)
	  "${puntosSQLi1}", // Amashop (Hacking Web)
	  "${puntosOR1}", // Separo (Hacking Web)
	  "${puntosBAC1}",  // Hacking_community (Hacking Web)
	  "${puntosRCE1}",  // RCE (DockerPwned)
	  "${puntosLFI1}",  // LFI (DockerPwned)
	  "${puntosIDOR1}"  // IDOR (OvaLabs)
	].map(Number); // Convertimos a n�meros
	
	const ctx = document.getElementById('labChart').getContext('2d');
	const labChart = new Chart(ctx, {
	  type: 'pie',
	  data: {
	    labels: [
	      'foro-xss (Hacking Web)',
	      'amashop (Hacking Web)',
	      'separo (Hacking Web)',
	      'hacking_community (Hacking Web)',
	      'RCE (DockerPwned)',
	      'LFI (DockerPwned)',
	      'IDOR (OvaLabs)'
	    ],
	    datasets: [{
	      label: 'Distribuci�n de Laboratorios',
	      data: puntosPorLaboratorio,
	      backgroundColor: [
	        '#66bb6a', '#81c784', '#a5d6a7', '#48e05f',   // Hacking Web - VERDE
	        '#64b5f6', '#24a5d5',             			// DockerPwned - AZUL
	        '#ffb74d'               						// OvaLabs - NARANJA
	      ],
	      borderColor: '#ffffff',
	      borderWidth: 2
	    }]
	  },
	  options: {
	    responsive: true,
	    plugins: {
	      legend: {
	        position: 'bottom',
	        labels: {
	          color: '#f5f6f8',
	          font: { size: 14 }
	        }
	      },
	      tooltip: {
	        callbacks: {
	          label: function(context) {
	            const label = context.label || '';
	            const index = context.dataIndex; // Obtener el �ndice de cada laboratorio
	            const valor = puntosPorLaboratorio[index]; // Obtener el valor correcto de puntos
	            return `${label}: ${valor} puntos`; // Muestra el nombre y los puntos
	          }
	        }
	      }
	    }
	  }
	});
</script>
<script src="<%= request.getContextPath() %>/js/progreso.js"></script>
</body>
</html>