console.log("Script cargado correctamente");

document.addEventListener("DOMContentLoaded", function() {
	console.log("DOM completamente cargado");

	const resultsContainer = document.querySelector('.results');
	if (!resultsContainer) {
		console.error("No se encontró el contenedor .results");
		return;
	} else {
		console.log("Contenedor .results encontrado");
	}

	const searchResults = [
		{ url: "http://xss.com", title: "Curso de Hacking Web", description: "Conoce las bases del hacking web, los principales ataques y cómo prevenirlos.", image: "../img/xss.png" },
		{ url: "http://sqlinjection.com", title: "Curso Advanced Web Hacking", description: "Curso de nivel avanzado con laboratorios de hacking y vulnerabilidades reales.", image: "../img/sqlinjection.png" },
		{ url: "http://csrf.com", title: "Hacking Web Technologies 3ª Silver Edition", description: "Libro sobre fuzzing en aplicaciones web y detección de vulnerabilidades.", image: "../img/csrf.png" },
		{ url: "http://bac.com", title: "Pack Hacking Web", description: "Formación avanzada en hacking contra API REST y aplicaciones web.", image: "../img/bac.png" },
		{ url: "https://udemy.com", title: "Curso de Pentesting Web", description: "Aprende técnicas de pentesting y explotación de vulnerabilidades web.", image: "../img/udemy.png" },
		{ url: "https://hackthebox.com", title: "Hack The Box Web Challenges", description: "Resuelve desafíos reales de hacking web en un entorno seguro.", image: "../img/hackthebox.png" },
		{ url: "https://tryhackme.com", title: "Web Hacking en TryHackMe", description: "Plataforma de aprendizaje con laboratorios de hacking web.", image: "../img/tryhackme.png" },
		{ url: "https://mozilla.org", title: "Guía de Seguridad Web - Mozilla", description: "Buenas prácticas de desarrollo seguro para aplicaciones web.", image: "../img/mozilla.png" }
	];

	console.log("Total de resultados:", searchResults.length);

	searchResults.forEach((result, index) => {
		console.log(`Procesando resultado ${index + 1}: ${result.title}`);

		const resultItem = document.createElement('div');
		resultItem.classList.add('result-item');

		// Asignar la imagen específica para cada URL
		const favicon = document.createElement('img');
		favicon.src = result.image;  // Ruta específica de la imagen
		favicon.onerror = function() {
			favicon.src = '../img/default.png'; // Imagen por defecto en caso de error
		};
		favicon.alt = "favicon";
		favicon.classList.add('result-icon');

		const resultContent = document.createElement('div');
		resultContent.classList.add('result-content');

		const urlSpan = document.createElement('span');
		urlSpan.classList.add('url');
		urlSpan.textContent = result.url;

		const titleLink = document.createElement('a');
		titleLink.href = result.url;
		titleLink.target = "_blank";
		titleLink.textContent = result.title;

		const descriptionParagraph = document.createElement('p');
		descriptionParagraph.textContent = result.description;

		resultContent.appendChild(urlSpan);
		resultContent.appendChild(document.createElement('br'));
		resultContent.appendChild(titleLink);
		resultContent.appendChild(descriptionParagraph);

		resultItem.appendChild(favicon);
		resultItem.appendChild(resultContent);

		resultsContainer.appendChild(resultItem);
	});

	console.log("Todos los resultados fueron agregados al DOM");
});

const moreButton = document.getElementById("more-button");
const dropdownMenu = document.getElementById("dropdown-menu");
const navContainer = document.querySelector(".nav-container");
const dropdownItems = document.querySelectorAll(".dropdown-item");
const body = document.body; // Selecciona el cuerpo del documento

// Mostrar / ocultar menú principal con clic y hacer espacio en el diseño
moreButton.addEventListener("click", function(event) {
	event.preventDefault();
	const isActive = navContainer.classList.toggle("active");
	dropdownMenu.style.display = isActive ? "flex" : "none";

	// Agregar o quitar la clase .body-expande al body
	if (isActive) {
		body.classList.add("body-expande");
	} else {
		body.classList.remove("body-expande");
	}
});

// Mostrar / ocultar submenús dentro del menú desplegable al hacer clic
dropdownItems.forEach(item => {
	item.addEventListener("click", function(event) {
		event.stopPropagation(); // Evita que el evento se propague al padre
		const submenu = this.querySelector(".submenu");
		if (submenu) {
			submenu.style.display = submenu.style.display === "flex" ? "none" : "flex";
		}
	});
});