//Este código implementa un sistema básico de comentarios en una página web,
	 //donde los usuarios pueden escribir y publicar comentarios, ver otros comentarios, 
	 //dar "me gusta" y detectar posibles ataques de tipo XSS (Cross Site Scripting).
	 
	 //Vamos a desglosar paso a paso lo que hace cada parte del código.
	 
	 //1. **Selección de elementos del DOM:**
	 // Se seleccionan los elementos de la página para poder interactuar con ellos:
    // `commentForm`: Selecciona el formulario donde los usuarios escriben y envían sus comentarios.
    // `newComment`: Selecciona el campo de texto donde el usuario escribe su comentario.
    // `forumContainer`: Es el contenedor donde se agregan los comentarios que los usuarios publican.
    // `popupMessage`: Este elemento muestra un mensaje emergente (popup) cuando se detecta un ataque XSS.
  
  	//2. **Función detectarXSS (Prevención de ataques XSS):**
    // Esta función se usa para detectar si el texto que el usuario quiere publicar contiene código JavaScript malicioso (XSS).
    // Se utiliza una expresión regular (regexXSS) que busca las etiquetas `<script>...<script>`, que es el tipo común de ataque XSS.
    // Si se detecta código malicioso, se muestra un mensaje emergente (`popupMessage`) que advierte al usuario, y se detiene el proceso de publicación del comentario.
    
    //3. **Función escapeHTML (Escapando caracteres especiales):**
    // Esta función toma el texto del comentario y lo convierte a un formato seguro para evitar que se ejecute como código HTML.
    // Los caracteres especiales como `&`, `<`, `>`, `"`, y `'` son reemplazados por sus representaciones de entidad HTML correspondientes, como `&amp;`, `&lt;`, `&gt;`, etc.
    // Esto es importante para evitar que los usuarios puedan insertar código malicioso que se ejecute en el navegador de otros usuarios.
    
    //4. **Manejo del envío del comentario:**
    // Se escucha el evento `submit` del formulario. Esto significa que cuando el usuario hace clic en el botón para enviar su comentario, se ejecutará esta parte del código.
    // El evento `e.preventDefault()` evita que la página se recargue al enviar el formulario (comportamiento por defecto en los formularios HTML).
    // El texto del comentario se obtiene de `newComment.value.trim()`, y `trim()` elimina los espacios innecesarios al principio y al final del texto.
    // Si el texto del comentario no está vacío, el código pasa a crear un nuevo bloque de comentario en la página.
    
    // 5. **Creación dinámica de un comentario:**
    // Se crea un nuevo `section` (etiqueta HTML) que representará el comentario. Este `section` tiene una clase llamada 'comment-box' para que se pueda estilizar con CSS.
    // Luego, se crea una estructura HTML que incluye:
    //   - **Información del usuario:** Una imagen de avatar, el nombre de usuario (`Tú`) y el tiempo de publicación (en este caso, 'hace pocos segundos').
    //   - **Texto del comentario:** El contenido del comentario, que se inserta usando `textContent` para asegurar que se muestra como texto simple y no como código HTML.
    //   - **Acciones del comentario:** Un par de botones, uno para dar "me gusta" y otro para responder.
    // Todos estos elementos se añaden a la estructura del comentario y luego se inserta dentro de `forumContainer`, que es donde se muestran los comentarios en la página.
  
    // 6. **Incremento del contador de "me gusta":**
    // Cada vez que un usuario hace clic en el botón de "me gusta" (representado por un pulgar hacia arriba `👍`), el contador de "me gusta" aumenta en 1.
    // Esto se logra con un `eventListener` en el `forumContainer`, que escucha si se hace clic en algún botón.
    // Si el clic es en el botón de "me gusta", el código obtiene el número actual de "me gusta" (de la etiqueta `span` que contiene la clase `like-count`), lo incrementa y lo actualiza en la interfaz.
  
    // 7. **Mostrar y cerrar el popup de solución:**
    // Hay dos funciones adicionales (`showPopup` y `closePopup`) que se usan para mostrar y ocultar el popup con la solución de un ejercicio.
    // El popup se muestra al quitar la clase `hidden` y se oculta al agregarla nuevamente.
  
    // 8. **Función de "me gusta" repetida:**
    // Al final del código, se agrega una segunda función para incrementar el contador de "me gusta". 
    // Esta parte también usa un `eventListener` para detectar el clic en los botones, pero parece ser redundante ya que ya está implementada antes. 
    // Esta parte podría ser eliminada para evitar duplicación de código.
    
   // **Resumen:**
  // Este código permite a los usuarios publicar comentarios de manera segura, incrementando la interactividad con los botones de "me gusta" y "responder".
  // Además, el código implementa medidas de seguridad para evitar ataques XSS y asegura que los comentarios no contengan contenido malicioso.
  // Los comentarios se crean dinámicamente en la página sin necesidad de recargarla, y el contador de "me gusta" se actualiza en tiempo real.
  
  const commentForm = document.getElementById('comment-form');
  const newComment = document.getElementById('new-comment');
  const forumContainer = document.querySelector('.forum-container');
  const popupMessage = document.getElementById('popup-message');

//Función para escapar los caracteres especiales
  function escapeHTML(str) {
    return str.replace(/[&<>"']/g, function (match) {
      const escapeChars = {
        '&': '&amp;',
        '<': '&lt;',
        '>': '&gt;',
        '"': '&quot;',
        "'": '&#39;'
      };
      return escapeChars[match];
    });
  }

//Función para manejar la creación del comentario
commentForm.addEventListener('submit', function (e) {
  e.preventDefault();
  const text = newComment.value.trim();

  console.log('Comentario:', text);  // Verifica el valor del comentario

  if (text !== "") {
    try {
      // Crear el comentario y agregarlo al contenedor
      const commentDiv = document.createElement('section');
      commentDiv.className = 'comment-box';

      // Crear la estructura HTML del comentario
      const userInfoDiv = document.createElement('div');
      userInfoDiv.className = 'user-info';
      const avatarImg = document.createElement('img');
      avatarImg.src = "https://i.imgur.com/1X4R6Yt.png";
      avatarImg.className = 'avatar';
      const usernameSpan = document.createElement('span');
      usernameSpan.className = 'username';
      usernameSpan.textContent = 'Tú';
      const timeSpan = document.createElement('span');
      timeSpan.className = 'time';
      timeSpan.textContent = 'hace pocos segundos';

      userInfoDiv.appendChild(avatarImg);
      userInfoDiv.appendChild(usernameSpan);
      userInfoDiv.appendChild(document.createTextNode(' • '));
      userInfoDiv.appendChild(timeSpan);

      const commentTextP = document.createElement('p');
      commentTextP.className = 'comment-text';
      commentTextP.innerHTML = text;  // Usamos textContent para asegurar que el texto se muestre correctamente (<img src=x onerror="alert('XSS')">)

      const commentActionsDiv = document.createElement('div');
      commentActionsDiv.className = 'comment-actions';
      const likeButton = document.createElement('button');
      likeButton.type = 'button';
      likeButton.innerHTML = '👍 <span class="like-count">0</span>';
      const replyButton = document.createElement('button');
      replyButton.type = 'button';
      replyButton.textContent = 'Responder';

      commentActionsDiv.appendChild(likeButton);
      commentActionsDiv.appendChild(replyButton);

      commentDiv.appendChild(userInfoDiv);
      commentDiv.appendChild(commentTextP);
      commentDiv.appendChild(commentActionsDiv);

      forumContainer.appendChild(commentDiv);  // Añadir el comentario al contenedor
      newComment.value = ""; // Limpiar campo de texto
    } catch (error) {
      console.warn("Comentario bloqueado:", error.message);
    }
  } else {
    console.warn("El comentario está vacío.");
  }
});

  // Incrementar contador de likes
  forumContainer.addEventListener('click', function (e) {
    if (e.target.closest('button')) {
      const button = e.target.closest('button');
      const likeSpan = button.querySelector('.like-count');
      if (likeSpan) {
        let likeCount = parseInt(likeSpan.textContent);
        likeCount++;
        likeSpan.textContent = likeCount;
      }
    }
  });

// Mostrar el popup de solución
function showPopup() {
document.getElementById("popup-solution").classList.remove("hidden");
}

//Cerrar el popup de solución
function closePopup() {
document.getElementById("popup-solution").classList.add("hidden");
}

//Agregar la funcionalidad para aumentar el contador de "me gusta"
document.addEventListener('DOMContentLoaded', () => {
        const forumContainer = document.querySelector('.forum-container');

        forumContainer.addEventListener('click', function (e) {
            if (e.target.closest('button')) {
                const button = e.target.closest('button');
                const likeSpan = button.querySelector('.like-count');
                let likeCount = parseInt(likeSpan.textContent);

                likeCount++;
                likeSpan.textContent = likeCount;
            }
        });
    });