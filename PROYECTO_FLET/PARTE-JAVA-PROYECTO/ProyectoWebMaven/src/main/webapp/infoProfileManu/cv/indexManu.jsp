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
    <title>Manuel Arcos - (Curriculum Vitae)</title>

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
    var commands = ["all", "whois", "social", "work", "education", "skills", "softskills", "languages", "projects", "exit", "force"];

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
                .echo("[[b;grey;]Name:] 			Manuel Arcos")
                .echo("[[b;grey;]Profession:] 	Tecnico en Sistemas Microinformático y Redes | Desarrollador web (FrontEnd)")
                .echo("[[b;grey;]Location:] 		ESPAÑA")
                .echo("[[b;grey;]Email:] 			yta-manuelarcos@gmail.com")
                .echo("[[b;grey;]Homepage:] 		https://github.com/ManuDev664")
                .echo("")
                .echo("Cuento con experiencia en el ambito de diseño y programacion de paginas web, me enfoco mas en el diseño frontend.")
                .echo("")
                .echo("He adquirido experiencia trabajando con tecnologías clave como JavaScript, virtualización (Proxmox, VMware), y la gestión de redes y servidores. Ademas cuento con una comprensión sólida en el manejo de servidores y entornos de red como por ejemplo servidores DNS,FTP,SSH o DHCP.")
                .echo("")
                .echo("Desde mis inicios en la infórmatica, he aprendido Python y Java a través de mis estudios, y continúo ampliando mis conocimientos para mantenerme al día con las constantes evoluciones de este campo. Me gustaria aprender mas y avanzar en mis conocimientos de Frontend y en la automatizacion de procesos mediante IA")
                .echo("")
                .echo("Mi enfoque profesional siempre está orientado a mejorar mi capacidad de trabajo y mis habilidades de programacion en el frontend y en el SEO de paginas web, queriendo profundizar en las optimizaciones de motores de búsqueda de Google y contribuyendo con ideas y soluciones que sean de utilidad para las empresas que quieran llevar sus paginas web a la primera posicion de busqueda en Google.")
                .echo("")
                .echo("También soy activo en otras comunidades relacionadas con el frontend, y me esfuerzo por mantenerme al tanto de las últimas tendencias y mejores prácticas en el campo del desarrollo web.")
                .echo("")
                .echo("Soy una persona sociable, optimista y alegre, siempre buscando encontrar el lado positivo de cualquier situación, me gusta llevar mis conocimientos a mas personas y aprendiendo de cada desafío.")
                .echo("")
                .echo("Soy una persona la cual le gusta mucho las tecnologias digitales de automatizacion de procesos como Make y Zapier. Tambien me gusta saber como crear chat bots con IA para WhatsAPP o para paginas web.")
                .echo("");
            },
            social: function () {
                term.echo("")
                    .echo("Github:   https://github.com/ManuDev664")
                    .echo("");
            },
            work: function () {
                term.echo("---------------EXPERIENCIA LABORAL---------------------")
                .echo("[[b;red;]Técnico Informático]")
                .echo("Tienda de informática")
                .echo("15/09/2023-25/01/2024")
                .echo("- Reparación de equipos informáticos y resolución de problemas de hardware/software.")
                .echo("- Atención al cliente y asesoramiento en soluciones tecnológicas.")
                .echo("- Instalación y configuración de sistemas operativos y programas.")
                .echo("- Mantenimiento preventivo y correctivo de equipos.")
                .echo("- Creacion de paginas web con Woordpress (Elementor y WooComerce).")
            },
            education: function () {
                term.echo("----------------------EDUCACIÓN-------------")
                .echo("[[b;red;]Grado Medio en Sistemas Microinformáticos y Redes]")
                .echo("Fecha no especificada")
                .echo("-------------------- ")
                .echo("[[b;red;]Educación Secundaria Obligatoria (ESO)]")
                .echo("Fecha no especificada")
                .echo("-------------------- ");
            },
            skills: function () {
                term.echo("[[b;grey;]Lenguajes de programación:]")
                .echo("Java, Javascript, CSS3, SQL, PL/SQL, Bash, Python, SAAS")
                .echo("[[b;grey;]Plataformas de virtualización:]")
                .echo("VMware, VirtualBox")
                .echo("[[b;grey;]Gestores de contenidos (CMS):]")
                .echo("Wordpress, Joomla, Moodle, Notion")
                .echo("[[b;grey;]Hardware de red:]")
                .echo("Cisco")
                .echo("[[b;grey;]Cloud computing:]")
                .echo("Azure de MicroSoft")
                .echo("[[b;grey;]Sistemas operativos:]")
                .echo("Linux y Windows")
                .echo("");
            },
            softskills: function () {
                term.echo("[[b;grey;]Soft skills:]")
                    .echo("Trabajo en equipo, comunicación, gestión del tiempo, resolución de problemas y con mentalidad de pensar a futuro para pensar en mejorar a futuro");
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
                .echo("[[b;red;]Proyecto DAM] - https://github.com/h4ck3nd/PROYECTO_DAM/tree/main/PROYECTO_FLET")
                .echo("Proyecto de desarrollo de aplicaciones como parte del ciclo formativo.")
                .echo("-----------------------")
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