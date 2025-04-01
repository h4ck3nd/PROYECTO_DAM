function validateRegisterForm() {
    let valid = true;

    // Limpiar errores previos
    document.querySelectorAll('.error-container').forEach(container => container.innerHTML = '');

    // Obtener los valores de los campos
    const nombre = document.getElementById('nombre').value;
    const apellidos = document.getElementById('apellidos').value;
    const email = document.getElementById('email').value;
    const usuario = document.getElementById('usuario').value;
    const password = document.getElementById('password').value;
    const confirmPassword = document.getElementById('confirm_password').value;
    const fechaNacimiento = document.getElementById('fecha_nacimiento').value;

    // Validación de los campos y mostrar errores
    if (!nombre) {
        showError('nombre', 'El campo Nombre es obligatorio.');
        valid = false;
    }

    if (!apellidos) {
        showError('apellidos', 'El campo Apellidos es obligatorio.');
        valid = false;
    }

    if (!email) {
        showError('email', 'El campo Correo es obligatorio.');
        valid = false;
    } else if (!validateEmail(email)) {
        showError('email', 'El correo electrónico no es válido.');
        valid = false;
    }

    if (!usuario) {
        showError('usuario', 'El campo Usuario es obligatorio.');
        valid = false;
    }

    if (!password) {
        showError('password', 'El campo Contraseña es obligatorio.');
        valid = false;
    }

    if (!confirmPassword) {
        showError('confirm_password', 'El campo Confirmar Contraseña es obligatorio.');
        valid = false;
    } else if (password !== confirmPassword) {
        showError('confirm_password', 'Las contraseñas no coinciden.');
        valid = false;
    }

    if (!fechaNacimiento) {
        showError('fecha_nacimiento', 'El campo Fecha de nacimiento es obligatorio.');
        valid = false;
    }

    return valid;
}

// Mostrar mensaje de error debajo del campo
function showError(fieldId, message) {
    document.getElementById(fieldId + '-error').innerHTML = `<span style="color: red;">${message}</span>`;
}

// Función para validar correo electrónico
function validateEmail(email) {
    const regex = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/;
    return regex.test(email);
}
