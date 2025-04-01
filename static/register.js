async function registerUser() {
    const nombre = document.getElementById('nombre').value.trim();
    const apellidos = document.getElementById('apellidos').value.trim();
    const email = document.getElementById('email').value.trim();
    const username = document.getElementById('username').value.trim();
    const password = document.getElementById('password').value.trim();
    const password2 = document.getElementById('password2').value.trim();
    const fechaNacimiento = document.getElementById('fecha_nacimiento').value.trim();  // Obtener la fecha de nacimiento
    const errorDiv = document.getElementById('error');

    if (password !== password2) {
        errorDiv.textContent = "Las contraseñas no coinciden";
        return;
    }

    // Validar que la fecha de nacimiento no esté vacía
    if (!fechaNacimiento) {
        errorDiv.textContent = "La fecha de nacimiento es requerida";
        return;
    }

    // Enviar los datos al servidor
    const response = await fetch('/register', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
        body: new URLSearchParams({
            nombre, 
            apellidos, 
            email, 
            usuario: username, 
            password, 
            confirm_password: password2, 
            fecha_nacimiento: fechaNacimiento  // Incluir la fecha de nacimiento en la solicitud
        })
    });

    const text = await response.text();

    if (text.includes('Registro exitoso')) {
        window.location.href = '/login';  // Redirigir al login después del registro
    } else {
        errorDiv.textContent = text;
    }
}

