document.addEventListener("DOMContentLoaded", function () {
    document.querySelector("#register-form").addEventListener("submit", function (event) {
        let isValid = true;

        // Limpiar mensajes de error previos
        document.querySelectorAll(".error-message").forEach(el => el.textContent = "");

        // Obtener los valores de los campos
        let fields = [
            { name: "nombre", message: "El campo 'Nombre' es obligatorio." },
            { name: "apellidos", message: "El campo 'Apellidos' es obligatorio." },
            { name: "email", message: "El campo 'Correo' es obligatorio." },
            { name: "usuario", message: "El campo 'Usuario' es obligatorio." },
            { name: "password", message: "El campo 'Contraseña' es obligatorio." },
            { name: "confirm_password", message: "Debes repetir la contraseña." },
            { name: "fecha_nacimiento", message: "El campo 'Fecha de Nacimiento' es obligatorio." }
        ];

        fields.forEach(field => {
            let input = document.querySelector(`input[name="${field.name}"]`);
            let errorDiv = document.getElementById(`${field.name}-error`);

            if (!input.value.trim()) {
                errorDiv.textContent = field.message;
                errorDiv.style.color = "red";
                isValid = false;
            }
        });

        // Validación de contraseña y confirmación
        let password = document.querySelector("input[name='password']").value.trim();
        let confirmPassword = document.querySelector("input[name='confirm_password']").value.trim();
        let confirmPasswordError = document.getElementById("confirm_password-error");

        if (password && confirmPassword && password !== confirmPassword) {
            confirmPasswordError.textContent = "Las contraseñas no coinciden.";
            confirmPasswordError.style.color = "red";
            isValid = false;
        }

        if (!isValid) {
            event.preventDefault(); // Detiene el envío si hay errores
        }
    });
});
