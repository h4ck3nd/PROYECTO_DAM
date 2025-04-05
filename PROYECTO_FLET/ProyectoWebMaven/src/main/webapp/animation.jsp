<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<title>Animación</title>
<style>
* {
          font-family: 'JetBrains Mono', monospace;
          /*font-family: 'console', monospace;*/
    	}
body {
	font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
	background: url('img/DesktopWINXP.jpg') no-repeat center center fixed;
	background-size: cover;
	margin: 0;
	display: flex;
	justify-content: center;
	align-items: center;
	height: 100vh;
}

/* Estilo para el video de fondo */
video.background-video {
	position: absolute;
	top: 0px;
	left: 0;
	width: 100%;
	height: 100%;
	object-fit: cover;
	z-index: -1;
}

.desktop-icon {
	position: absolute;
	bottom: 40px;
	left: 40px;
	text-align: center;
	color: white;
}

.desktop-icon img {
	width: 64px;
	height: 64px;
	cursor: default;
}

.cursor {
	width: 32px;
	height: 32px;
	background:
		url('https://png.pngtree.com/png-vector/20220513/ourmid/pngtree-3d-vector-arrow-cursor-png-image_4606160.png')
		no-repeat;
	background-size: contain;
	position: absolute;
	top: 100%;
	left: -100%;
	pointer-events: none;
	z-index: 1000;
}

.browser-window {
	position: absolute;
	top: 50px;
	left: 100px;
	width: 600px;
	height: 400px;
	background: white;
	border: 2px solid #555;
	display: none;
	z-index: 999;
	box-shadow: 0 0 10px #000;
}

.browser-header {
	background: #0078d7;
	color: white;
	padding: 5px;
	font-weight: bold;
}
</style>
</head>
<body>

	<!-- Video de fondo -->
	<!--<video class="background-video" autoplay loop muted>
		<source src="img/WINXPANIMATED.mp4" type="video/mp4">
		Tu navegador no soporta este tipo de archivo de video.
	</video>-->


	<div class="desktop-icon" id="icono-navegador">
		<img
			src="https://aprendelibvrefiles.blob.core.windows.net/aprendelibvre-container/course/como_usar_internet/image/i_03_04_l.png"
			alt="Icono navegador">
		<div>Navegador</div>
	</div>

	<div class="cursor" id="cursor"></div>

	<div class="browser-window" id="navegador">
		<div class="browser-header">Mi Navegador</div>
		<div style="padding: 20px;">Cargando...</div>
	</div>
	 
	<script>
    document.addEventListener('DOMContentLoaded', function () {
        const cursor = document.getElementById('cursor');
        const icon = document.getElementById('icono-navegador');
        const browser = document.getElementById('navegador');

        // Posicionar y animar el cursor
        const iconRect = icon.getBoundingClientRect();
        const targetX = iconRect.left + 32 + 'px';
        const targetY = iconRect.top + 32 + 'px';

        cursor.style.left = '50%';
        cursor.style.top = '50%';
        cursor.style.display = 'block';

        cursor.animate([
            { top: '50%', left: '50%' },
            { top: targetY, left: targetX }
        ], {
            duration: 2000,
            fill: 'forwards'
        });

        // Mostrar el navegador tras la animación
        setTimeout(() => {
            browser.style.display = 'block';
        }, 2200);

        // Función para obtener token de la URL
        function getParameterByName(name) {
            const urlParams = new URLSearchParams(window.location.search);
            return urlParams.get(name);
        }

        // Redirigir después de la animación
        setTimeout(() => {
            const token = getParameterByName('token');
            if (token) {
                // Construir nueva URL con el token
                const newUrl = window.location.href.replace("animation.jsp", "home_directory/home.jsp");
                const finalUrl = newUrl.split("?")[0] + "?token=" + token + "&page=0";

                window.location.href = finalUrl;
            } else {
                console.error("Token no encontrado en la URL");
            }
        }, 4000);
    });
</script>

</body>
</html>
