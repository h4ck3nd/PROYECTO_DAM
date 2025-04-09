const commentForm = document.getElementById('comment-form');
  const newComment = document.getElementById('new-comment');
  const forumContainer = document.querySelector('.forum-container');
  const popupMessage = document.getElementById('popup-message');

  // Función para detectar XSS (básica)
  function detectarXSS(texto) {
    const regexXSS = /<script.*?>.*?<\/script>/gi;
    if (regexXSS.test(texto)) {
      popupMessage.style.display = 'block';
      setTimeout(() => { popupMessage.style.display = 'none'; }, 3000);
      throw new Error("XSS detectado");
    }
  }

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