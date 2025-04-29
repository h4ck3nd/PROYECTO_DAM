<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ page import="java.util.*" %>
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

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Usuarios - Sección de Amistades</title>
    <link rel="icon" type="image/png" href="<%= request.getContextPath() %>/img/icono/icono_cinco_hackend.ico">
    <link href="https://fonts.googleapis.com/css2?family=VT323&display=swap" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'VT323', monospace;
        }

        body {
		    background: linear-gradient(135deg, #0f0f0f, #2e2e2e); /* De negro profundo a gris oscuro */
		    min-height: 100vh;
		    color: #e0e0e0; /* Un gris muy claro para que no sea blanco puro */
		    font-family: 'Poppins', 'Segoe UI', 'Roboto', sans-serif; /* Tipografías más modernas */
		    display: flex;
		    flex-direction: column;
		    align-items: center;
		    padding: 40px;
		    margin: 0;
		}

        h1 {
            margin-bottom: 20px;
            font-size: 48px;
            text-shadow: 2px 2px 4px #000;
        }

        .usuarios-grid {
            display: flex;
            flex-wrap: nowrap; /* Para mejor distribucion seria "wrap" */
            gap: 20px;
            justify-content: center;
            width: 100%;
            max-width: 1200px;
        }

        .usuario-card {
        	/*display: flex;*/
            background-color: #292929;
            border: 1px solid #444;
            border-radius: 12px;
            padding: 20px;
            width: 300px;
            text-align: center;
            transition: transform 0.3s, background-color 0.3s;
            cursor: pointer;
        }

        .usuario-card:hover {
            background-color: #383838;
            transform: translateY(-5px);
        }

        .usuario-card img {
            width: 80px;
            height: 80px;
            object-fit: cover;
            border-radius: 50%;
            margin-bottom: 10px;
            border: 2px solid #555;
        }

        .usuario-card h3 {
            font-size: 24px;
            margin-bottom: 8px;
        }

        .usuario-card p {
            font-size: 18px;
            color: #bbb;
            margin: 4px 0;
        }

        .popup, #popupPerfil, #popupSolicitudes {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0; top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0,0,0,0.7);
        }

        .popup-contenido {
            background-color: #2c2c2c;
            margin: 5% auto;
            padding: 20px;
            border-radius: 12px;
            width: 400px;
            max-width: 90%;
            text-align: center;
            color: white;
            box-shadow: 0px 5px 15px rgba(0,0,0,0.5);
            position: relative;
        }

        .popup-contenido img {
            width: 100px;
            height: 100px;
            object-fit: cover;
            border-radius: 50%;
            margin-bottom: 15px;
        }

        .cerrar {
            position: absolute;
            top: 10px;
            right: 20px;
            font-size: 28px;
            color: #ccc;
            cursor: pointer;
        }

        .cerrar:hover {
            color: white;
        }

        .bandeja-btn {
		    position: fixed;
		    top: 0px;
		    right: 20px;
		    width: 140px;
		    height: 100px;
		    background: transparent;
		    border: none;
		    border-radius: 10px;
		    cursor: pointer;
		    display: flex;
		    align-items: center;
		    justify-content: center;
		    z-index: 1001;
		    transition: transform 0.2s;
		    flex-direction: column;
		}
		
		.bandeja-contenido {
		    display: flex;
		    flex-direction: column;
		    align-items: center;
		    justify-content: center;
		}
		
		.bandeja-texto {
		    font-size: 18px;
		    color: white;
		    margin-bottom: 5px;
		}
		
		.bandeja-icono {
		    font-size: 30px;
		}
		
		.bandeja-btn:hover {
		    transform: scale(1.1);
		}

        .spinner {
            border: 4px solid rgba(0, 0, 0, 0.1);
            width: 40px;
            height: 40px;
            border-radius: 50%;
            border-left-color: #09f;
            animation: spin 1s linear infinite;
            margin: auto;
            margin-top: 10px;
        }

        @keyframes spin {
            to { transform: rotate(360deg); }
        }

        .usuario-container {
            margin-top: 10px;
            display: flex;
            align-items: center;
        }

        .usuario-info {
            margin-left: 10px;
            text-align: left;
        }

        .aceptar-btn, .rechazar-btn {
            margin-top: 10px;
            padding: 8px 16px;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
        }

        .aceptar-btn {
            background-color: green;
            color: white;
        }

        .rechazar-btn {
            background-color: red;
            color: white;
        }

        .aceptar-btn:hover {
            background-color: darkgreen;
        }

        .rechazar-btn:hover {
            background-color: darkred;
        }
		.logo {
		    font-size: 32px;
		    color: #09f;
		    font-family: 'VT323', monospace;
		    text-shadow: 2px 2px 4px #000;
		}
		
		.contenido-principal {
		    margin-top: 120px; /* Para que no tape el header */
		    width: 100%;
		    display: flex;
		    flex-direction: column;
		    align-items: center;
		}
		
		.contenido-principal h2 {
		    font-size: 40px;
		    margin-bottom: 20px;
		}
		
		/* Header fijo en la parte superior */
		.site-header {
		    width: 100%;
		    background: linear-gradient(90deg, #222, #333);
		    padding: 20px;
		    text-align: center;
		    position: fixed;
		    top: 0;
		    left: 0;
		    box-shadow: 0px 2px 10px rgba(0, 0, 0, 0.5);
		    color: #09f; /* Color de texto para mejor visibilidad */
		}
		
		/* Footer fijo en la parte inferior */
		.site-footer {
		    width: 100%;
		    background: linear-gradient(90deg, #222, #333);
		    padding: 15px;
		    text-align: center;
		    color: #aaa;
		    font-size: 16px;
		    position: fixed;
		    bottom: 0;
		    left: 0;
		    box-shadow: 0px -2px 10px rgba(0, 0, 0, 0.5);
		}
		 /* Estilo general para el estado de conexión */
		    .estado-conexion {
		        font-size: 1.1rem;
		        font-weight: bold;
		        padding: 10px;
		        border-radius: 5px;
		        margin-top: 10px;
		        text-align: center;
		        transition: background-color 0.3s, color 0.3s;
		        max-width: 300px; /* Limitar el ancho */
		        margin-left: auto;
		        margin-right: auto;
		    }
		
		    /* Estilo para cuando el usuario está Conectado */
		    .estado-conexion.conectado {
		        background-color: #4CAF50; /* Verde */
		        color: white;
		    }
		
		    /* Estilo para cuando el usuario está Desconectado */
		    .estado-conexion.desconectado {
		        background-color: #f44336; /* Rojo */
		        color: white;
		    }
		
		    /* Estilo cuando hay un estado desconocido o en espera */
		    .estado-conexion.cargando {
		        background-color: #ff9800; /* Naranja */
		        color: white;
		    }
    </style>
</head>
<body>

<header class="site-header">
    <h1 class="logo"><a href="<%= request.getContextPath() %>/profile.jsp" style="text-decoration: none; color: #09f;">🌟 Zona de Usuarios</a></h1>
    <!-- Botón de Bandeja de Entrada (actualizado) -->
	<button class="bandeja-btn" onclick="abrirBandeja()" title="Bandeja de Entrada">
	    <div class="bandeja-contenido">
	        <span class="bandeja-texto">BANDEJA DE ENTRADA</span>
	        <span class="bandeja-icono">📩</span>
	    </div>
	</button>
</header>

<main class="contenido-principal">
<h1>Usuarios Disponibles</h1>

<!-- Botón de Bandeja de Entrada (actualizado) -->
<!-- <button class="bandeja-btn" onclick="abrirBandeja()" title="Bandeja de Entrada">
    <div class="bandeja-contenido">
        <span class="bandeja-texto">BANDEJA DE ENTRADA</span>
        <span class="bandeja-icono">📩</span>
    </div>
</button> -->

<!-- Grid de usuarios -->
<div class="usuarios-grid">
<%
    if (usuarios != null && !usuarios.isEmpty()) {
        dao.AmistadDAO amistadDAO = new dao.AmistadDAO();
        for (Map<String, String> usuario : usuarios) {
            String estadoAmistad = amistadDAO.obtenerEstadoAmistad(Integer.parseInt(usuarioJWT.getUserId()), Integer.parseInt(usuario.get("id")));
            if (estadoAmistad == null) {
                estadoAmistad = "ninguna";
            }
%>
    <div class="usuario-card" data-user-id="<%= usuario.get("id") %>" onclick="abrirPopup(
        '<%= usuario.get("nombre") %>', 
        '<%= usuario.get("apellidos") %>', 
        '<%= usuario.get("usuario") %>', 
        '<%= usuario.get("email") %>', 
        '<%= usuario.get("rol") %>', 
        '<%= request.getContextPath() %>/<%= usuario.get("photo_path") %>', 
        '<%= usuario.get("id") %>', 
        '<%= estadoAmistad %>')">
        
        <img src="<%= request.getContextPath() %>/<%= usuario.get("photo_path") %>" alt="Foto de perfil">
        <h3><%= usuario.get("nombre") %> <%= usuario.get("apellidos") %></h3>
        <p>Usuario: <%= usuario.get("usuario") %></p>
        <p>Email: <%= usuario.get("email") %></p>
        <p>Rol: <%= usuario.get("rol") %></p>
        <br>
        <!-- Nuevo elemento para mostrar el estado de conexión -->
    	<p id="estado-conexion-<%= usuario.get("id") %>" class="estado-conexion">Cargando estado...</p>
    </div>
<%
        }
    } else {
%>
    <h2>No se pudieron cargar los usuarios. :(</h2>
<%
    }
%>
</div>

<!-- Popup de Perfil -->
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

<!-- Popup de Solicitudes -->
<div id="popupSolicitudes" class="popup">
    <div class="popup-contenido">
        <span class="cerrar" onclick="cerrarPopupSolicitudes()">&times;</span>
        <br>
        <h2>Solicitudes de Amistad</h2>
        <br>
        <div id="popupSolicitudesContenido"></div>
    </div>
</div>

</main>
<br><br><br><br>
<footer class="site-footer">
    <p>&copy; <%= Calendar.getInstance().get(Calendar.YEAR) %> - Conoce y conecta con gente.</p>
</footer>

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

//Función para obtener el estado de conexión y actualizar la tarjeta del usuario
function obtenerEstadoConexion(userId) {
    var url = "http://localhost:5000/estado_conexion/" + userId;
    console.log("Realizando solicitud GET a: " + url);  // Depuración

    fetch(url)
        .then(response => {
            if (!response.ok) {
                throw new Error("Error al obtener el estado de conexión: " + response.statusText);
            }
            return response.json();
        })
        .then(data => {
            console.log("Respuesta de servidor:", data);  // Depuración
            if (data.estado) {
                // Encuentra el elemento con el id correspondiente
                var estadoElemento = document.getElementById('estado-conexion-' + userId);
                if (estadoElemento) {
                    console.log("Elemento encontrado con id estado-conexion-" + userId);  // Depuración
                    
                    // Cambiar el texto del estado y la clase CSS según el estado
                    if (data.estado === 'Conectado') {
                        estadoElemento.textContent = data.estado;
                        estadoElemento.classList.remove('desconectado', 'cargando');
                        estadoElemento.classList.add('conectado');
                    } else if (data.estado === 'Desconectado') {
                        estadoElemento.textContent = data.estado;
                        estadoElemento.classList.remove('conectado', 'cargando');
                        estadoElemento.classList.add('desconectado');
                    } else {
                        estadoElemento.textContent = data.estado;
                        estadoElemento.classList.remove('conectado', 'desconectado');
                        estadoElemento.classList.add('cargando');
                    }
                }
            }
        })
        .catch(error => {
            console.error("Error al obtener el estado de conexión:", error);
        });
}

// Llamar a la función para cada tarjeta de usuario al cargar la página
document.addEventListener('DOMContentLoaded', function() {
    // Obtener todas las tarjetas de usuario
    let usuarioCards = document.querySelectorAll('.usuario-card');
    
    // Obtener el estado de conexión de cada usuario
    usuarioCards.forEach(function(card) {
        let userId = card.getAttribute('data-user-id');
        console.log("Obteniendo estado para el usuario con ID: " + userId);  // Depuración
        if (userId) {
            obtenerEstadoConexion(userId);
        }
    });
});
</script>
</body>
</html>
