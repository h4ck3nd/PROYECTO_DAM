<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Hackend</title>
<style>
/* GENERAL */
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

html, body {
	height: 100%;
	background-color: #333;
	color: #f5f6f8;
}

body {
	display: flex;
	flex-direction: column;
}

.page-wrapper {
	flex: 1;
	display: flex;
	flex-direction: column;
}

/* HEADER */
.main-header {
	display: flex;
	align-items: center;
	justify-content: space-between;
	border-bottom: 1px solid #222;
	background-color: #333;
	padding: 20px 30px;
	margin-bottom: 40px;
	color: #00ffd5;
	font-family: monospace;
}

.left-text {
	font-size: 1.2rem;
	color: #00ffd5;
	font-weight: bold;
}

.titulo {
	font-size: 1.2rem;
	color: #00ffd5;
	text-transform: uppercase;
	font-weight: 600;
	text-align: center;
	flex: 1;
}

/* Botones tipo ventana */

.window-buttons {
	display: flex;
	gap: 10px;
}

.window-buttons .btn {
	background: #21262d;
	border: none;
	color: #e6edf3;
	width: 30px;
	height: 30px;
	font-size: 1rem;
	cursor: pointer;
	border-radius: 4px;
}

.btn:hover {
	background-color: #30363d;
}

/* GRAFICO SECTORES*/

.grafico-container {
  max-width: 600px;
  margin: 60px auto;
  padding: 20px;
  background: #333;
  border: 1px solid #eaeaea;
  border-radius: 12px;
  text-align: center;
}

.grafico-container h2 {
  margin-bottom: 20px;
  font-size: 1.4rem;
  color: #f5f6f8;
}

/* COLUMNAS DE LABORATORIOS */
.columns-container {
	display: flex;
	justify-content: space-between;
	gap: 20px;
	flex-wrap: wrap;
}

.puntuacion-total {
  font-size: 1rem;
  margin: 8px 0 16px;
  text-align:center;
  color: #007bff;
  font-weight: bold;
}

.lab-column {
	flex: 1;
	min-width: 280px;
}

.lab-column h2 {
	color: #f5f6f8;
	margin-bottom: 16px;
	font-size: 1.5rem;
	border-bottom: 2px solid #eaeaea;
	padding-bottom: 6px;
	text-align: center;
}

/*  TARJETAS */
.lab-card {
	background: #333;
	border: 1px solid #e0e0e0;
	border-radius: 10px;
	padding: 20px;
	margin-bottom: 20px;
	transition: box-shadow 0.2s ease, transform 0.2s ease;
	text-align: center;
}

.lab-card:hover {
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
	transform: translateY(-4px);
}

.lab-card h3 {
	font-size: 1.2rem;
	color: #f5f6f8;
	margin-bottom: 10px;
}

.lab-card p {
	font-size: 0.95rem;
	color: #aaa2a2;
	margin-bottom: 15px;
}

.contenedor-exportar {
  display: flex;
  justify-content: center;
  margin: 40px 0;
}

.btn-exportar {
  width: 75%;
  padding: 14px 0;
  background-color: #007bff;
  color: white;
  border: none;
  border-radius: 8px;
  font-size: 1rem;
  font-weight: bold;
  cursor: pointer;
  transition: background-color 0.3s ease;
}

.btn-exportar:hover {
  background-color: #0056b3;
}

.footer {
	text-align: center;
	padding: 20px 0;
	font-size: 0.9rem;
	color: #777;
	border-top: 1px solid #222;
	background-color: #333;
	margin-top: auto;
}
</style>
</head>
<body>
	<header class="main-header">
	<div class="left-text">PROGRESO</div>
	<h1 class="titulo">HACKEND</h1>
	<div class="window-buttons">
		<button class="btn minimizar">-</button>
			<button class="btn maximizar">O</button>
			<button onclick="window.location.href='/ProyectoWebMaven/home_directory/home.jsp?page=0'" class="btn cerrar">X</button>
	</div>
</header>
	<section class="grafico-container">
		<h2>Progreso en Laboratorios</h2>
		<canvas id="labChart" width="400" height="400"></canvas>
	</section>
	<main class="columns-container">
		<!-- Hacking Web -->
		<section class="lab-column">
			<h2>Hacking Web</h2>
			<div class="puntuacion-total">Puntuación: 40 / 100</div>
			<div class="lab-card">
				<h3>Lab XSS</h3>
				<p>Ejercicio básico de XSS</p>
			</div>
			<div class="lab-card">
				<h3>Lab SQLi</h3>
				<p>Inyección SQL en entorno Docker</p>
			</div>
		</section>

		<!-- DockerPwned -->
		<section class="lab-column">
			<h2>DockerPwned</h2>
			<div class="puntuacion-total">Puntuación: 25 / 100</div>
			<div class="lab-card">
				<h3>Lab RCE</h3>
				<p>Ejecución remota de comandos</p>
			</div>
			<div class="lab-card">
				<h3>Lab File Inclusion</h3>
				<p>Inclusión de archivos en Docker</p>
			</div>
		</section>

		<!-- OvaLabs -->
		<section class="lab-column">
			<h2>OvaLabs</h2>
			<div class="puntuacion-total">Puntuación: 60 / 100</div>
			<div class="lab-card">
				<h3>Lab CSRF</h3>
				<p>Falsificación de peticiones</p>
			</div>
			<div class="lab-card">
				<h3>Lab IDOR</h3>
				<p>Acceso inseguro a objetos</p>
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
  const ctx = document.getElementById('labChart').getContext('2d');
  const labChart = new Chart(ctx, {
    type: 'pie',
    data: {
      labels: [
        'XSS (Hacking Web)',
        'SQLi (Hacking Web)',
        'RCE (DockerPwned)',
        'File Inclusion (DockerPwned)',
        'CSRF (OvaLabs)',
        'IDOR (OvaLabs)'
      ],
      datasets: [{
        label: 'Distribución de Laboratorios',
        data: [15, 15, 20, 20, 15, 15], // Porcentajes
        backgroundColor: [
          '#66bb6a', '#81c784',       // Verde esperanza (Hacking Web)
          '#42a5f5', '#64b5f6',       // Azul (DockerPwned)
          '#ffa726', '#ffb74d'        // Naranja (OvaLabs)
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
            font: {
              size: 14
            }
          }
        },
        tooltip: {
          callbacks: {
            label: function(context) {
              const label = context.label || '';
              const value = context.formattedValue || '';
              return `${label}: ${value}%`;
            }
          }
        }
      }
    }
  });
</script>
	
</body>
</html>
