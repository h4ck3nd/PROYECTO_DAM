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

    // Animación del cursor
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
});
