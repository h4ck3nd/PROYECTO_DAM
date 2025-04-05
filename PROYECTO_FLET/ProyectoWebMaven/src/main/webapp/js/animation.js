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