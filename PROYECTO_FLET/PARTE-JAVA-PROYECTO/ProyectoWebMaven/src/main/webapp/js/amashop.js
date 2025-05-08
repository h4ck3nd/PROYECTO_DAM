document.addEventListener("DOMContentLoaded", function () {
	    const cartItemsContainer = document.getElementById("cart-items");
	    const cartTotalElement = document.getElementById("cart-total");
	    const cartSidebar = document.getElementById("cart-sidebar");
	    const openCartBtn = document.getElementById("open-cart-btn");
	    const closeCartBtn = document.getElementById("close-cart-btn");
	    let total = 0;

	    // Función para actualizar el total del carrito
	    function updateTotal() {
	        cartTotalElement.textContent = "Total: " + total.toFixed(2) + "€";
	    }

	    // Función para agregar un producto al carrito
	    function addToCart(button) {
	        // Obtiene el .product-card del botón clicado
	        const productCard = button.closest(".product-card");
	        if (!productCard) return; // Si no encuentra el producto, no hace nada

	        // Clona el producto para agregarlo al carrito
	        const clonedProduct = productCard.cloneNode(true);

	        // Asegurarse de que el botón "Agregar al carrito" esté deshabilitado para evitar múltiples adiciones
	        const addToCartButton = clonedProduct.querySelector(".add-to-cart");
	        addToCartButton.setAttribute("disabled", "true");
	        addToCartButton.textContent = "Ya en el carrito";

	        // Añadimos el botón de eliminar al producto clonado
	        const removeButton = document.createElement("button");
	        removeButton.textContent = "Eliminar";
	        removeButton.classList.add("remove-btn");

	        // Añadimos el evento para eliminar el producto
	        removeButton.addEventListener("click", function () {
	            clonedProduct.remove();
	            const priceText = productCard.querySelector("p").textContent.replace("€", "").trim();
	            const price = parseFloat(priceText);
	            total -= price; // Restamos el precio del total
	            updateTotal();
	        });

	        // Añadimos el botón de eliminar al final de cada producto en el carrito
	        clonedProduct.appendChild(removeButton);

	        // Agrega el producto clonado al carrito
	        cartItemsContainer.appendChild(clonedProduct);

	        // Obtiene el precio del producto y actualiza el total
	        const priceText = productCard.querySelector("p").textContent.replace("€", "").trim();
	        const price = parseFloat(priceText);
	        total += price;
	        updateTotal();
	    }

	    // Agrega un listener a todos los botones "Agregar al carrito"
	    document.querySelectorAll(".add-to-cart").forEach(button => {
	        button.addEventListener("click", function () {
	            addToCart(this); // Pasa el botón que se hizo clic
	        });
	    });

	    // Abrir el carrito lateral
	    openCartBtn.addEventListener("click", function () {
	        cartSidebar.style.right = "0"; // Muestra el carrito desde la derecha
	    });

	    // Cerrar el carrito lateral
	    closeCartBtn.addEventListener("click", function () {
	        cartSidebar.style.right = "-300px"; // Oculta el carrito moviéndolo hacia la derecha
	    });
	});
	
	document.addEventListener("DOMContentLoaded", function () {
	    const searchInput = document.querySelector(".search-bar");
	    const productCards = document.querySelectorAll(".product-card");

	    // Crear contenedor para los resultados simulados de SQLi
	    const sqlResults = document.createElement("div");
	    sqlResults.id = "sql-results";
	    sqlResults.style.marginTop = "20px";
	    sqlResults.style.fontFamily = "monospace";
	    document.body.appendChild(sqlResults); // Lo puedes mover a donde quieras

	    // Base de datos falsa para simulación
	    const mockDB = {
	        databases: ["postgres", "template1", "amashop_db"],
	        tables: {
	            amashop_db: ["users", "flag"]
	        },
	        columns: {
	            users: ["id", "username", "password"],
	            flag: ["flag"]
	        },
	        data: {
	            users: [
	                { username: "admin", password: "admin123" },
	                { username: "user", password: "userpass" }
	            ],
	            flag: [{ flag: "FLAG{amashop_flag}" }]
	        }
	    };

	    // Función para mostrar resultados simulados
	    function showSQLResults(content) {
	        sqlResults.innerHTML = content;
	        sqlResults.style.display = "block"; // Mostrar el div
	        setTimeout(() => {
	            sqlResults.style.display = "none"; // Ocultarlo después de 6 segundos
	        }, 6000);
	    }

	    searchInput.addEventListener("keydown", function (event) {
	        if (event.key === "Enter") {
	            event.preventDefault();
	            const searchTerm = searchInput.value.toLowerCase().trim();
	            sqlResults.innerHTML = ""; // Limpiar resultados SQLi

	            // Simulación de SQL Injection
	            if (searchTerm === `' union select current_database()-- -`) {
	                showSQLResults(`<strong>current_database()</strong>: <code>amashop_db</code>`);
	                productCards.forEach(p => p.style.display = "none");
	                return;
	            }

	            if (searchTerm === `' union select datname from amashop_db-- -`) {
	                const tables = mockDB.tables["amashop_db"];
	                showSQLResults(`<strong>Tablas en <code>amashop_db</code>:</strong><ul>${tables.map(t => `<li>${t}</li>`).join("")}</ul>`);
	                productCards.forEach(p => p.style.display = "none");
	                return;
	            }

	            if (searchTerm === `' union select column_name from information_schema.columns where table_name='users'-- -`) {
	                const columns = mockDB.columns["users"];
	                showSQLResults(`<strong>Columnas de <code>users</code>:</strong><ul>${columns.map(c => `<li>${c}</li>`).join("")}</ul>`);
	                productCards.forEach(p => p.style.display = "none");
	                return;
	            }

	            if (searchTerm === `' union select column_name from information_schema.columns where table_name='flag'-- -`) {
	                const columns = mockDB.columns["flag"];
	                showSQLResults(`<strong>Columnas de <code>flag</code>:</strong><ul>${columns.map(c => `<li>${c}</li>`).join("")}</ul>`);
	                productCards.forEach(p => p.style.display = "none");
	                return;
	            }

	            if (searchTerm === `' union select username || ' - ' || password from users-- -`) {
	                const users = mockDB.data.users;
	                showSQLResults(`<strong>Contenido de <code>users</code>:</strong><ul>${users.map(u => `<li>${u.username} - ${u.password}</li>`).join("")}</ul>`);
	                productCards.forEach(p => p.style.display = "none");
	                return;
	            }

	            if (searchTerm === `' union select flag from flag-- -`) {
	                const flags = mockDB.data.flag;
	                showSQLResults(`<strong>Contenido de <code>flag</code>:</strong><ul>${flags.map(f => `<li>${f.flag}</li>`).join("")}</ul>`);
	                productCards.forEach(p => p.style.display = "none");
	                return;
	            }

	            // Búsqueda normal o SQLi básica
	            const sqlInjectionPattern = "' or 1=1-- -";

	            productCards.forEach(function (productCard) {
	                const title = productCard.querySelector("h4").textContent.toLowerCase();
	                const isHidden = productCard.classList.contains("hidden-product");

	                if (searchTerm === sqlInjectionPattern) {
	                    productCard.style.display = "block"; // Mostrar todos
	                } else if (searchTerm === "") {
	                    productCard.style.display = isHidden ? "none" : "block"; // Solo visibles
	                } else if (title.includes(searchTerm)) {
	                    productCard.style.display = "block";
	                } else {
	                    productCard.style.display = "none";
	                }
	            });
	        }
	    });
	});

