<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="utils.JWTUtils" %>
<%@ page import="utils.UsuarioJWT" %>

<%
    UsuarioJWT usuarioJWT = null;

	try {
	    usuarioJWT = JWTUtils.obtenerUsuarioDesdeRequest(request);
	} catch (Exception e) {
	    // Redirigir al servlet de logout en vez de al .jsp
	    response.sendRedirect(request.getContextPath() + "/logout");
	    return;
	}
%>
<!DOCTYPE html>
<html lang="en" xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="UTF-8">
    <title>Adrián García - (Curriculum Vitae)</title>

    <!-- Favicon and icons -->
    <link rel="sitemap" type="application/xml" title="Sitemap" href="#">
    <link rel="canonical" href="index.jsp">
    <link rel="apple-touch-icon" sizes="180x180" href="cv/apple-touch-icon.png">
    <link rel="icon" type="image/png" sizes="32x32" href="cv/favicon-32x32.png">
    <link rel="icon" type="image/png" sizes="16x16" href="cv/favicon-16x16.png">
    <link rel="manifest" href="cv/site.webmanifest">
    <link rel="mask-icon" href="cv/safari-pinned-tab.svg" color="#000000">
    <link rel="shortcut icon" href="cv/favicon.ico">
    <meta name="msapplication-TileColor" content="#ffffff">

    <!-- jQuery and Terminal CSS -->
    <script src="https://cdn.jsdelivr.net/npm/jquery"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.terminal/2.33.2/js/jquery.terminal.min.js"></script>
    <script src="https://unpkg.com/jquery.terminal/js/autocomplete_menu.js"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/jquery.terminal/2.33.2/css/jquery.terminal.min.css" rel="stylesheet">

    <style>
        body {
            width: 100%;
            font-size: 18px;
            background-color: black;
            color: white;
        }
    </style>
</head>

<body>
  <script>
jQuery(document).ready(function ($) {
    var isLoading = false;
    var commands = ["all", "whois", "social", "work", "education", "skills", "softskills", "languages", "certifications", "publications", "projects", "exit", "force"];

    function progress(percent, width) {
        var size = Math.round(width * percent / 100);
        var left = "";
        var taken = "";
        for (var i = size; i--;) taken += "=";
        if (taken.length > 0) taken = taken.replace(/=$/, ">");
        for (var i = width - size; i--;) left += " ";
        return "[" + taken + left + "] " + percent + "%";
    }

    function simulateExit(term) {
        var prompt = term.get_prompt();
        var width = 30;
        var percent = 0;
        var str = progress(0, width);
        term.set_prompt(str);
        isLoading = true;
        (function loop() {
            str = progress(percent++, width);
            term.set_prompt(str);
            if (percent < 100) {
                setTimeout(loop, 10);
            } else {
                term.echo(progress(percent, width) + " [[b;green;]OK]").set_prompt(prompt);
                isLoading = false;
            }
        })();
    }

    $("body").terminal(function (command, term) {
        if (!command) return;
        var cmd = command.trim().split(/\s+/)[0];

        const commandsObj = {
            whois: function () {
                term.echo("")
                .echo("[[b;grey;]Name:] 			Adrián García López")
                .echo("[[b;grey;]Profession:] 	Tecnico en Ciberseguridad")
                .echo("[[b;grey;]Location:] 		Seseña (Toledo)")
                .echo("[[b;grey;]Email:] 			ciberseguridad12345@gmail.com")
                .echo("[[b;grey;]Homepage:] 		https://github.com/D1se0")
                .echo("")
                .echo("Cuento con experiencia en ciberseguridad y certificación en esta área, lo que me permite abordar la seguridad informática desde diversas perspectivas, como Red Team y Blue Team.")
                .echo("")
                .echo("He adquirido experiencia trabajando con tecnologías clave como Docker, virtualización (Proxmox, VMware ESXi, KVM), y la gestión de redes y servidores. Además, tengo un buen manejo de herramientas de automatización y scripting (Bash, Batch, Python) y una comprensión sólida en el manejo de servidores y entornos de red.")
                .echo("")
                .echo("Desde mis inicios en la ciberseguridad, he aprendido de forma autodidacta y a través de mis estudios, y continúo ampliando mis conocimientos para mantenerme al día con las constantes evoluciones de este campo.")
                .echo("")
                .echo("Mi enfoque profesional siempre está orientado a mejorar mi capacidad de trabajo, profundizando en las complejidades del entorno corporativo y contribuyendo con ideas y soluciones que sean de utilidad para las empresas.")
                .echo("")
                .echo("Fuera de mi tiempo de trabajo, contribuyo activamente a la comunidad de ciberseguridad, colaborando con iniciativas como Hacking_Community, en la que soy fundador del canal de YT Hacking Community.")
                .echo("")
                .echo("También soy activo en otras comunidades relacionadas con la ciberseguridad, y me esfuerzo por mantenerme al tanto de las últimas tendencias y mejores prácticas en el campo.")
                .echo("")
                .echo("Soy una persona sociable, optimista y alegre, siempre buscando encontrar el lado positivo de cualquier situación y aprendiendo de cada desafío.")
                .echo("");
            },
            social: function () {
                term.echo("")
                    .echo("Github:   https://github.com/D1se0")
                    .echo("YouTube:  https://www.youtube.com/channel/UCTYFCMrN3NLa70bmpjRB--g")
                    .echo("Linkedin: https://www.linkedin.com/in/adriaangaarcialopez")
                    .echo("");
            },
            work: function () {
                term.echo("---------------EXPERIENCIA LABORAL---------------------")
                .echo("[[b;red;]Técnico en Ciberseguridad]")
                .echo("UNITEL CIBERSEGURIDAD")
                .echo("12/06/2024-28/06/2024")
                .echo("- Soporte y administración de sistemas orientado a la ciberseguridad.")
                .echo("- Realización de tareas relacionadas con análisis, protección y auditoría de sistemas.")
                .echo("- Participación en proyectos tanto de Red Team como de Blue Team.")
                .echo("- Documentación técnica y gestión de incidencias de seguridad.")
                .echo("-------------------- ")
                .echo("[[b;red;]Técnico Informático]")
                .echo("Tienda de informática")
                .echo("07/03/2023-15/06/2023")
                .echo("- Reparación de equipos informáticos y resolución de problemas de hardware/software.")
                .echo("- Atención al cliente y asesoramiento en soluciones tecnológicas.")
                .echo("- Instalación y configuración de sistemas operativos y programas.")
                .echo("- Mantenimiento preventivo y correctivo de equipos.")
                .echo("-------------------- ")
                .echo("[[b;red;]Oficial Administrativo]")
                .echo("12/09/2023-22/09/2023")
                .echo("- Gestión de documentación y tareas administrativas.")
                .echo("- Soporte a procesos internos en oficina.")
                .echo("- Uso de herramientas ofimáticas y plataformas de gestión.")
                .echo("- Coordinación con diferentes departamentos para tareas organizativas.")
                .echo("-------------------- ");
            },
            education: function () {
                term.echo("----------------------EDUCACIÓN-------------")
                .echo("[[b;red;]Certificado de Profesionalidad Nivel 3 en Ciberseguridad]")
                .echo("Fecha no especificada")
                .echo("Formación especializada en protección de sistemas y redes, análisis de amenazas y respuesta ante incidentes de ciberseguridad.")
                .echo("-------------------- ")
                .echo("[[b;red;]Grado Medio en Sistemas Microinformáticos y Redes]")
                .echo("Fecha no especificada")
                .echo("-------------------- ")
                .echo("[[b;red;]Grado Básico en Informática de Oficina y Redes]")
                .echo("Fecha no especificada")
                .echo("-------------------- ")
                .echo("[[b;red;]Educación Secundaria Obligatoria (ESO)]")
                .echo("Fecha no especificada")
                .echo("-------------------- ");
            },
            certifications: function () {
                term.echo("----------------------CERTIFICACIONES-------------")
                .echo("[[b;red;]eJPT - eLearnSecurity Junior Penetration Tester - INE Security]")
                .echo("Fecha no especificada")
                .echo("-------------------- ")
                .echo("[[b;red;]Certificado de Profesionalidad Nivel 3 en Ciberseguridad]")
                .echo("Fecha no especificada")
                .echo("-------------------- ")
                .echo("[[b;red;]Curso de Ciberseguridad Nivel Básico]")
                .echo("Fecha no especificada")
                .echo("-------------------- ")
                .echo("[[b;red;]Curso de Ciberseguridad: Hacking Ético y Nivel Avanzado]")
                .echo("Fecha no especificada")
                .echo("-------------------- ");
            },
            skills: function () {
                term.echo("[[b;grey;]Lenguajes de programación:]")
                .echo("Java, Javascript, PHP, CSS3, SQL, PL/SQL, Bash, Python")
                .echo("[[b;grey;]Plataformas de virtualización:]")
                .echo("VMware, VirtualBox")
                .echo("[[b;grey;]Gestores de contenidos (CMS):]")
                .echo("Wordpress, Joomla, Drupal, Moodle")
                .echo("[[b;grey;]Hardware de red:]")
                .echo("Cisco")
                .echo("[[b;grey;]Cloud computing:]")
                .echo("AWS, Azure y Google Cloud")
                .echo("[[b;grey;]Contenedores:]")
                .echo("Docker")
                .echo("[[b;grey;]Sistemas operativos:]")
                .echo("Linux y Windows")
                .echo("");
            },
            softskills: function () {
                term.echo("[[b;grey;]Soft skills:]")
                    .echo("Trabajo en equipo, comunicación, gestión del tiempo, resolución de problemas");
            },
            languages: function () {
                term.echo("[[b;grey;]English:]")
                .echo("▋▋▋░░░░░░░░░░░░░ 30%")
                .echo("[[b;grey;]Castellano:]")
                .echo("▋▋▋▋▋▋▋▋▋▋ 100%")
                .echo("");
            },
            projects: function () {
                term.echo("----------------------PROYECTOS-------------")
                .echo("[[b;red;]Hacking Community] - https://d1se0.github.io/hacklab.github.io/")
                .echo("Plataforma orientada a la divulgación de conocimientos en hacking ético y ciberseguridad.")
                .echo("-----------------------")
                .echo("[[b;red;]HackerLabs] - https://d1se0.github.io/hackerlabs/")
                .echo("Laboratorio virtual de pruebas y prácticas de ciberseguridad.")
                .echo("-----------------------")
                .echo("[[b;red;]Proyecto DAM] - https://github.com/h4ck3nd/PROYECTO_DAM/tree/main/PROYECTO_FLET")
                .echo("Proyecto de desarrollo de aplicaciones como parte del ciclo formativo.")
                .echo("-----------------------")
                .echo("[[b;red;]Página IP Pública] - https://h4ck3nd.github.io/TU_IP_PUBLICA/")
                .echo("Página web que muestra la IP pública del visitante.")
                .echo("-----------------------")
                .echo("[[b;red;]Compresor de Carpetas ZIP (GitHub)] - https://h4ck3nd.github.io/COMPRESOR_CARPETAS_GITHUB/")
                .echo("Aplicación web para comprimir carpetas directamente desde el navegador.")
                .echo("-----------------------")
                .echo("[[b;red;]Clonador de Páginas Web] - https://github.com/h4ck3nd/PROYECT_CLONE_PAGE")
                .echo("Herramienta para clonar sitios web con fines educativos y de análisis de seguridad.")
                .echo("-----------------------")
                .echo("");
            },
            publications: function () {
                term.echo("----------------------PUBLICACIONES-------------")
                .echo("[[b;red;]H4cker B00k - GitBook personal]") 
                .echo("https://dise0.gitbook.io/h4cker_b00k")
                .echo("Libro digital donde recopilo y explico conocimientos sobre hacking ético, herramientas, técnicas y conceptos clave de ciberseguridad.")
                .echo("-----------------------")
                .echo("[[b;red;]Canal de YouTube - Hacking Community]") 
                .echo("https://www.youtube.com/@Hacking_Community")
                .echo("Canal donde comparto contenido formativo, demostraciones prácticas y divulgación sobre hacking ético y ciberseguridad.")
                .echo("-----------------------")
                .echo("");
            },
            force: function () {
                term.echo(`[[b;white;]                 _--~~--_\n               /~/_|  |_~ \n              |____________|                    ¡Ayúdame, Obi Wan Kenobi!\n              |[][][][][][]|:=  .               ¡Eres mi única esperanza!\n            __| __         |__   ' .          /\n           |  ||. |   ==   |  |      ' .     /\n          (|  ||__|   ==   |  |)         '<\n           |  |[] []  ==   |  |          |\n           |  |____________|  |          |\n           /__            /__           /\n\n[[;red;]Que la fuerza te acompañe]`);
            },
            help: function () {
                term.echo(`[[b;white;]Available commands:]\n\n` + commands.join(" ") + `\n`);
            },
            all: function () {
                commandsObj.whois();
                commandsObj.social();
                commandsObj.work();
                commandsObj.education();
                commandsObj.skills();
                commandsObj.softskills();
                commandsObj.languages();
                commandsObj.projects();
                commandsObj.force();
            },
            exit: function () {
                term.echo("terminating ...");
                simulateExit(term);
                setTimeout(function () {
                    window.location = "<%= request.getContextPath() %>/infoProfile/index.jsp";
                }, 2000);
            }
        };

        if (commandsObj[cmd]) {
            commandsObj[cmd]();
        } else {
            term.echo(`unknown command: ${command}\nplease type 'help' for a list of available commands`);
        }
    }, {
        prompt: "[[;green;]cristian@4z4z3l][[;blue;]:~$] ",
        greetings: `[[b;white;]This is 4z4z3l\n\nType 'help' for a list of available commands]`,
        keydown: function (event, term) {
            if (isLoading && event.which === 68 && event.ctrlKey) {
                clearTimeout();
                isLoading = false;
                term.echo("[[b;red;]FAIL]").set_prompt("[[;green;]cristian@4z4z3l][[;blue;]:~$] ");
                return false;
            }
        },
        autocompleteMenu: true,
        completion: commands
    });
});
</script>

</body>
</html>