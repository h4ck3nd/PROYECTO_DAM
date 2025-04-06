// xss_script.js
window.onload = function() {
    // Buscar el enlace oculto con la flag
    const link = document.querySelector('#link-inocente');
    if (link) {
        alert(link.dataset.flag); // Muestra la flag cuando se detecta XSS
    }
};
