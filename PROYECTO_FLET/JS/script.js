async function validateLogin() {
    const user = document.getElementById('username').value.trim();
    const pass = document.getElementById('password').value.trim();
    const errorDiv = document.getElementById('error');

    const response = await fetch('/login', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
        body: new URLSearchParams({ username: user, password: pass })
    });

    if (response.redirected) {
        window.location.href = response.url;  // Si Flask redirige, seguimos la redirección
    } else {
        const text = await response.text();
        errorDiv.textContent = text.includes('incorrectos') ? 'Usuario o contraseña incorrectos' : 'Error desconocido';
    }
}

function startAnimation() {
    const cursor = document.getElementById('cursor');
    const icon = document.getElementById('icono-navegador');
    const browser = document.getElementById('navegador');
  
    const iconRect = icon.getBoundingClientRect();
    const targetX = iconRect.left + 32;
    const targetY = iconRect.top + 32;
  
    cursor.style.left = '50%';
    cursor.style.top = '50%';
    cursor.style.display = 'block';
  
    cursor.animate([
      { top: '50%', left: '50%' },
      { top: `${targetY}px`, left: `${targetX}px` }
    ], {
      duration: 2000,
      fill: 'forwards'
    });
  
    setTimeout(() => {
      browser.style.display = 'block';
    }, 2200);
  
    setTimeout(() => {
      window.location.href = '/home'; // Redirigir a /home (ruta de Flask)
    }, 4000);
}
