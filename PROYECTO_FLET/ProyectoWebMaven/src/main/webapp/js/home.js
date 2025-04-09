console.log("Script cargado correctamente");

// Menú desplegable
const moreButton = document.getElementById("more-button");
const dropdownMenu = document.getElementById("dropdown-menu");
const navContainer = document.querySelector(".nav-container");
const dropdownItems = document.querySelectorAll(".dropdown-item");
const body = document.body;

moreButton.addEventListener("click", function (event) {
	event.preventDefault();
	const isActive = navContainer.classList.toggle("active");
	dropdownMenu.style.display = isActive ? "flex" : "none";

	if (isActive) {
		body.classList.add("body-expande");
	} else {
		body.classList.remove("body-expande");
	}
});

dropdownItems.forEach(item => {
	item.addEventListener("click", function (event) {
		event.stopPropagation();
		const submenu = this.querySelector(".submenu");
		if (submenu) {
			submenu.style.display = submenu.style.display === "flex" ? "none" : "flex";
		}
	});
});

// 🔍 Motor de búsqueda
const searchInput = document.getElementById("liveSearch");
const clearBtn = document.getElementById("clearSearch");

searchInput.addEventListener("input", function () {
    const query = this.value.toLowerCase();
    resultsContainer.innerHTML = "";

    const filteredResults = searchResults.filter(result =>
        result.title.toLowerCase().includes(query) ||
        result.tags.some(tag => tag.toLowerCase().includes(query))
    );

    if (filteredResults.length === 0) {
        resultsContainer.innerHTML = "<p>No se encontraron resultados.</p>";
        return;
    }

    filteredResults.forEach(result => {
        const resultItem = document.createElement('div');
        resultItem.classList.add('result-item');

        const favicon = document.createElement('img');
        favicon.src = result.image;
        favicon.onerror = () => favicon.src = '../img/default-error.png';
        favicon.alt = "favicon";
        favicon.classList.add('result-icon');

        const resultContent = document.createElement('div');
        resultContent.classList.add('result-content');

        const urlSpan = document.createElement('span');
        urlSpan.classList.add('url');
        urlSpan.textContent = result.url;

        const titleLink = document.createElement('a');
        titleLink.href = result.url;
        titleLink.target = "_self";
        titleLink.textContent = result.title;

        const descriptionParagraph = document.createElement('p');
        descriptionParagraph.textContent = result.description;

        // Crear contenedor de tags debajo de la descripción
        const tagsContainer = document.createElement('div');
        tagsContainer.classList.add('tags');
        
        if (result.tags) {
            result.tags.forEach(tag => {
                const tagSpan = document.createElement('span');
                tagSpan.classList.add('tag');
                tagSpan.textContent = `#${tag}`;
                tagsContainer.appendChild(tagSpan);
            });
        }

        // Añadir todos los elementos
        resultContent.appendChild(urlSpan);
        resultContent.appendChild(document.createElement('br'));
        resultContent.appendChild(titleLink);
        resultContent.appendChild(descriptionParagraph);
        resultContent.appendChild(tagsContainer); // Los tags se colocan al final (debajo de la descripción)

        resultItem.appendChild(favicon);
        resultItem.appendChild(resultContent);

        resultsContainer.appendChild(resultItem);
    });
});

clearBtn.addEventListener("click", function () {
    searchInput.value = "";
    searchInput.dispatchEvent(new Event("input"));
});

// ORDENAR POR TIPOS O TAGS

// Variables para almacenar los filtros seleccionados
let selectedType = null;  // Solo uno por "tipos"
let selectedTag = null;   // Solo uno por "tags"

// Función para filtrar los resultados basados en los filtros seleccionados
function filterResults() {
    const filteredResults = searchResults.filter(result => {
        const matchesType = selectedType ? result.tags.includes(selectedType) : true;
        const matchesTag = selectedTag ? result.tags.includes(selectedTag) : true;
        return matchesType && matchesTag;
    });

    renderResults(filteredResults);
}

// Función para manejar los clics en los filtros (tipos y tags)
function handleFilterClick(event) {
    event.preventDefault();

    const filterType = event.target.getAttribute('data-filter-type'); // Tipo de filtro (tipo o tag)
    const filterValue = event.target.getAttribute('data-filter-value'); // Valor del filtro (xss, sql, etc.)

    // Cambiar la clase entre unselected y selected
    toggleFilterHighlight(event.target, filterType, filterValue);

    // Filtrar los resultados según los filtros aplicados
    filterResults();
}

// Función para alternar entre selected y unselected
function toggleFilterHighlight(element, filterType, filterValue) {
    // Dependiendo del tipo de filtro (tipo o tag), desmarcamos los demás filtros en el bloque
    const allLinks = document.querySelectorAll(`.filter-item[data-filter-type="${filterType}"]`);
    
    // Si el filtro clickeado está en estado 'selected', se cambia a 'unselected'
    if (element.classList.contains('selected')) {
        element.classList.remove('selected');
        element.classList.add('unselected');
        
        // Desmarcamos la selección (eliminamos el filtro seleccionado en el tipo/tag correspondiente)
        if (filterType === 'tipo') {
            selectedType = null;
        } else if (filterType === 'tag') {
            selectedTag = null;
        }
    } else {
        // Si el filtro clickeado está en estado 'unselected', se cambia a 'selected'
        element.classList.remove('unselected');
        element.classList.add('selected');
        
        // Actualizamos la selección en el tipo/tag correspondiente
        if (filterType === 'tipo') {
            selectedType = filterValue;
        } else if (filterType === 'tag') {
            selectedTag = filterValue;
        }
        
        // Aseguramos que solo haya un filtro seleccionado a la vez en el mismo bloque
        allLinks.forEach(link => {
            if (link !== element) {
                link.classList.remove('selected');
                link.classList.add('unselected');
            }
        });
    }
}

// Asignar los eventos de clic a los enlaces de filtro (tipos y tags)
const filterLinks = document.querySelectorAll('.filter-item');
filterLinks.forEach(link => {
    link.addEventListener('click', handleFilterClick);
});

// ORDENAR POR DIFICULTAD O CREADOR



// La función de renderizado que muestra los resultados
function renderResults(results) {
    const resultsContainer = document.querySelector('.results');
    resultsContainer.innerHTML = ''; // Limpiar los resultados actuales

    if (results.length === 0) {
        resultsContainer.innerHTML = "<p>No se encontraron resultados para los filtros aplicados.</p>";
        return;
    }

    results.forEach(result => {
        const resultItem = document.createElement('div');
        resultItem.classList.add('result-item');

        const favicon = document.createElement('img');
        favicon.src = result.image;
        favicon.onerror = () => favicon.src = '../img/default.png';
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

        // Crear contenedor de tags debajo de la descripción
        const tagsContainer = document.createElement('div');
        tagsContainer.classList.add('tags');
        
        result.tags.forEach(tag => {
            const tagSpan = document.createElement('span');
            tagSpan.classList.add('tag');
            tagSpan.textContent = `#${tag}`;
            tagsContainer.appendChild(tagSpan);
        });

        // Añadir todos los elementos
        resultContent.appendChild(urlSpan);
        resultContent.appendChild(document.createElement('br'));
        resultContent.appendChild(titleLink);
        resultContent.appendChild(descriptionParagraph);
        resultContent.appendChild(tagsContainer); // Los tags se colocan al final (debajo de la descripción)

        resultItem.appendChild(favicon);
        resultItem.appendChild(resultContent);

        resultsContainer.appendChild(resultItem);
    });
}

// Llamada inicial para mostrar todos los resultados cuando se carga la página
document.addEventListener("DOMContentLoaded", function () {
    renderResults(searchResults);
});
