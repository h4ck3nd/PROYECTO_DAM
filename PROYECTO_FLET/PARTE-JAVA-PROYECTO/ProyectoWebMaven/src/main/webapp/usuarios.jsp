<%@ page import="java.util.*" %>
<%@ page import="java.util.Map" %>
<%@ page import="utils.JWTUtils" %>
<%@ page import="utils.UsuarioJWT" %>
<%@ page import="dao.AmistadDAO" %>

<%
    UsuarioJWT usuarioJWT = null;
    
    try {
        usuarioJWT = JWTUtils.obtenerUsuarioDesdeRequest(request);
    } catch (Exception e) {
        response.sendRedirect(request.getContextPath() + "/logout");
        return;
    }

    Object usuariosObj = request.getAttribute("usuarios");

    if (usuariosObj == null) {
        response.sendRedirect(request.getContextPath() + "/usuarios");
        return;
    }

    List<Map<String, String>> usuarios = (List<Map<String, String>>) usuariosObj;
    
    List<Map<String, String>> solicitudesRecibidas = new dao.AmistadDAO().obtenerSolicitudesRecibidas(Integer.parseInt(usuarioJWT.getUserId()));
   
   
%>

<link href="https://fonts.googleapis.com/css2?family=VT323&display=swap" rel="stylesheet">

<style>
   * {
        font-family: 'VT323', monospace !important;
    }

    .usuarios-grid {
        display: flex;
        flex-wrap: wrap;
        gap: 15px;
        justify-content: flex-start;
        padding: 20px;
    }

    .usuario-card {
        display: flex;
        align-items: center;
        background-color: #1f1f1f;
        border: 1px solid #333;
        border-radius: 8px;
        padding: 15px;
        text-align: left;
        color: white;
        transition: 0.3s;
        width: 450px;
        height: 120px;
        justify-content: flex-start;
        box-sizing: border-box;
        align-content: center !important;
        text-align: center !important;
    }

    .usuario-card:hover {
        transform: translateY(-3px);
        background-color: #2c2c2c;
    }

    .usuario-card img {
        width: 60px;
        height: 60px;
        object-fit: cover;
        border-radius: 50%;
        margin-right: 15px;
    }

    .usuario-card h3 {
        font-size: 14px;
        font-weight: bold;
        margin-bottom: 5px;
    }

    .usuario-card p {
        margin: 5px 8px;
        font-size: 14px;
        margin-top: 15px;
        color: #bbb;
    }

    .usuario-card .usuario-info {
        flex: 1;
    }

    .popup {
	    display: none; /* Lo muestras con JS cuando quieras */
	    position: fixed;
	    z-index: 1000;
	    left: 0;
	    top: 0;
	    width: 100%;
	    height: 100%;
	    overflow: auto;
	    background-color: rgba(0, 0, 0, 0.6); /* Fondo oscuro semitransparente */
	}

    .popup-contenido {
	    background-color: #1f1f1f;
	    margin: 10% auto; /* Centrado vertical y horizontal */
	    padding: 20px;
	    border-radius: 10px;
	    width: 400px;
	    max-width: 90%;
	    text-align: center;
	    box-shadow: 0px 5px 15px rgba(0,0,0,0.3);
	    position: relative;
	    color: white;
	}

    .popup-contenido img {
        width: 100px;
        height: 100px;
        object-fit: cover;
        border-radius: 50%;
        margin-bottom: 15px;
    }

    .cerrar {
        color: #aaa;
        float: right;
        font-size: 24px;
        font-weight: bold;
        cursor: pointer;
    }

    .cerrar:hover,
    .cerrar:focus {
        color: #fff;
        text-decoration: none;
        cursor: pointer;
    }
    /* Estilo para el botón de bandeja de entrada */
    .bandeja-btn {
        margin: 20px;
        padding: 10px 20px;
        background-color: #4CAF50;
        color: white;
        font-size: 16px;
        border: none;
        border-radius: 5px;
        cursor: pointer;
    }

    .bandeja-btn:hover {
        background-color: #45a049;
    }

	.usuario-foto {
	    width: 60px;
	    height: 60px;
	    border-radius: 50%;
	    object-fit: cover;
	    margin-right: 20px !important;
	}
	
	.usuario-container {
	    margin-top: 10px;
	    display: flex;
        align-items: center;
        text-align: left;
        justify-content: flex-start;
	}
	
	.usuario-info h3 {
	    margin: 0;
	    font-size: 18px;
	}
	
	.usuario-info p {
	    margin: 5px 0;
	    font-size: 14px;
	}
	
	.aceptar-btn {
	    background-color: green;
	    color: white;
	    padding: 8px 16px;
	    border: none;
	    border-radius: 4px;
	    cursor: pointer;
	}
	
	.aceptar-btn:hover {
	    background-color: darkgreen;
	}
	
	.rechazar-btn {
	    background-color: red;
	    color: white;
	    padding: 8px 16px;
	    border: none;
	    border-radius: 4px;
	    cursor: pointer;
	}
	
	.rechazar-btn:hover {
	    background-color: darkred;
	}
	.spinner {
	    border: 4px solid rgba(0, 0, 0, 0.1);
	    width: 36px;
	    height: 36px;
	    border-radius: 50%;
	    border-left-color: #09f;
	    animation: spin 1s linear infinite;
	    margin: auto;
	    margin-top: 10px;
	    margin-bottom: 10px;
	}
	
	@keyframes spin {
	    to { transform: rotate(360deg); }
	}
</style>

<!-- Botón de Bandeja de Entrada -->
<button class="bandeja-btn" onclick="abrirBandeja()">Bandeja de Entrada</button>

<!-- Popup para las solicitudes de amistad -->
<div id="popupSolicitudes" class="popup">
    <div class="popup-contenido">
        <span class="cerrar" onclick="cerrarPopupSolicitudes()">&times;</span>
        <h2>Solicitudes de Amistad</h2>
        <div id="popupSolicitudesContenido"></div>
    </div>
</div>

<div class="usuarios-grid">
<%
    if (usuarios != null && !usuarios.isEmpty()) {
        dao.AmistadDAO amistadDAO = new dao.AmistadDAO(); // Crear el DAO una sola vez
        for (Map<String, String> usuario : usuarios) {
            // Usamos directamente usuarioJWT.getUserId()
            String estadoAmistad = amistadDAO.obtenerEstadoAmistad(Integer.parseInt(usuarioJWT.getUserId()), Integer.parseInt(usuario.get("id")));
            if (estadoAmistad == null) {
                estadoAmistad = "ninguna";
            }
%>
    <div class="usuario-card" onclick="abrirPopup(
        '<%= usuario.get("nombre") %>', 
        '<%= usuario.get("apellidos") %>', 
        '<%= usuario.get("usuario") %>', 
        '<%= usuario.get("email") %>', 
        '<%= usuario.get("rol") %>', 
        '<%= request.getContextPath() %>/<%= usuario.get("photo_path") %>', 
        '<%= usuario.get("id") %>', 
        '<%= estadoAmistad %>'
    )">
        <img src="<%= request.getContextPath() %>/<%= usuario.get("photo_path") %>" alt="Foto de perfil">
        <h3><%= usuario.get("nombre") %> <%= usuario.get("apellidos") %></h3>
        <p>Usuario: <%= usuario.get("usuario") %></p>
        <p>Email: <%= usuario.get("email") %></p>
        <p>Rol: <%= usuario.get("rol") %></p>
    </div>
<%
        }
    } else {
%>
    <h2 style="font-size: 18px;">No se pudieron cargar los usuarios. :(</h2>
<%
    }
%>
</div>

<!-- Popup -->
<div id="popupPerfil" class="popup">
  <div class="popup-contenido">
    <span class="cerrar" onclick="cerrarPopup()">&times;</span>
    <img id="popupFoto" src="" alt="Foto de perfil" />
    <h2 id="popupNombre"></h2>
    <p id="popupUsuario"></p>
    <p id="popupEmail"></p>
    <p id="popupRol"></p>
    <div id="popupAmistadBoton" style="margin-top: 15px;"></div>
  </div>
</div>

<script>
function abrirPopup(nombre, apellidos, usuario, email, rol, foto, idUsuario, estadoAmistad) {
    document.getElementById('popupNombre').innerText = nombre + ' ' + apellidos;
    document.getElementById('popupUsuario').innerText = "Usuario: " + usuario;
    document.getElementById('popupEmail').innerText = "Email: " + email;
    document.getElementById('popupRol').innerText = "Rol: " + rol;
    document.getElementById('popupFoto').src = foto;

    let popupBotonDiv = document.getElementById('popupAmistadBoton');

    // Mostrar un spinner mientras carga
    popupBotonDiv.innerHTML = `
        <div class="spinner"></div>
    `;

    fetch('<%= request.getContextPath() %>/amistadEstado?userId=<%= usuarioJWT.getUserId() %>&userIdDestino=' + idUsuario)
        .then(response => response.json())
        .then(data => {
            let estadoAmistad = data.estado;
            let botonHtml = "";

            if (estadoAmistad === "pendiente") {
                botonHtml = `<button type="button" disabled style="background-color: gray;">Solicitud enviada</button>`;
            } else if (estadoAmistad === "aceptada") {
                botonHtml = `<button type="button" disabled style="background-color: green;">Ya es tu amigo</button>`;
            } else {
                botonHtml = `
                    <form action="<%= request.getContextPath() %>/amistad" method="GET" style="margin-top: 10px;">
                        <input type="hidden" name="accion" value="enviar">
                        <input type="hidden" name="solicitadoId" value="` + idUsuario + `">
                        <input type="hidden" name="userId" value="<%= usuarioJWT.getUserId() %>">
                        <button type="submit">Enviar Solicitud de Amistad</button>
                    </form>
                `;
            }

            popupBotonDiv.innerHTML = botonHtml;
        })
        .catch(error => {
            console.error('Error al obtener el estado de amistad:', error);
            popupBotonDiv.innerHTML = '<p style="color: red;">Error cargando el estado</p>';
        });

    document.getElementById('popupPerfil').style.display = 'block';
}

// Función para cerrar el popup
function cerrarPopup() {
    document.getElementById('popupPerfil').style.display = 'none';
}


//Función para abrir la bandeja de entrada
function abrirBandeja() {
    document.getElementById('popupSolicitudes').style.display = 'block';
    
    var usuarioId = "<%= usuarioJWT.getUserId() %>";  // Variable JSP correcta
    fetch("<%= request.getContextPath() %>/solicitudes?userId=" + usuarioId)
        .then(response => response.json())
        .then(solicitudes => {
            var contenido = document.getElementById('popupSolicitudesContenido');
            contenido.innerHTML = ""; // Limpiar el contenido previo

            if (solicitudes.length > 0) {
                solicitudes.forEach(function(solicitud) {
                    var nombreCompleto = solicitud.nombre + " " + solicitud.apellidos;

                    var solicitudHTML = ''
                        + '<div class="usuario-container">'
                        +     '<img src="<%= request.getContextPath() %>/' + solicitud.photo_path + '" alt="Foto de perfil" class="usuario-foto">'
                        +     '<div class="usuario-info">'
                        +         '<h3>' + nombreCompleto + '</h3>'
                        +         '<p>Usuario: ' + solicitud.usuario + '</p>'
                        +         '<p>Email: ' + solicitud.email + '</p>'
                        +         '<p>Rol: ' + solicitud.rol + '</p>'
                        +         '<form action="<%= request.getContextPath() %>/amistad" method="GET" style="display: inline;">'
                        +             '<input type="hidden" name="accion" value="aceptar">'
                        +             '<input type="hidden" name="idAmistad" value="' + solicitud.idAmistad + '">'
                        +             '<input type="hidden" name="userId" value="<%= usuarioJWT.getUserId() %>">'
                        +             '<button type="submit" class="aceptar-btn">Aceptar</button>'
                        +         '</form>'
                        +         '<form action="<%= request.getContextPath() %>/amistad" method="GET" style="display: inline; margin-left: 10px;">'
                        +             '<input type="hidden" name="accion" value="rechazar">'
                        +             '<input type="hidden" name="idAmistad" value="' + solicitud.idAmistad + '">'
                        +             '<input type="hidden" name="userId" value="<%= usuarioJWT.getUserId() %>">'
                        +             '<button type="submit" class="rechazar-btn">Rechazar</button>'
                        +         '</form>'
                        +     '</div>'
                        + '</div>';

                    var solicitudDiv = document.createElement('div');
                    solicitudDiv.innerHTML = solicitudHTML;
                    contenido.appendChild(solicitudDiv);

                    console.log("ID Amistad: " + solicitud.idAmistad);
                    console.log("Nombre Apellido: " + nombreCompleto);
                    console.log("Usuario: " + solicitud.usuario);
                    console.log("Email: " + solicitud.email);
                    console.log("Rol: " + solicitud.rol);
                    console.log("Imagen: " + "<%= request.getContextPath() %>/" + solicitud.photo_path);
                });
            } else {
                contenido.innerHTML = "<p>No tienes solicitudes de amistad.</p>";
            }
        })
        .catch(error => {
            console.error("Error al obtener las solicitudes:", error);
        });
}

//Función para cerrar el popup de solicitudes
function cerrarPopupSolicitudes() {
    document.getElementById('popupSolicitudes').style.display = 'none';
}

</script>
