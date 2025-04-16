//ACTUALIZAR DATOS DDBB PUNTOS
	window.onload = function () {
	    const form = document.getElementById("autoSubmitForm");
	
	    // Detectar si el tipo de navegación fue recarga (reload)
	    const navigationEntries = performance.getEntriesByType("navigation");
	    const isReload = navigationEntries.length > 0 && navigationEntries[0].type === "reload";
	
	    if (isReload && form) {
	        form.submit();
	    }
	};
	
	