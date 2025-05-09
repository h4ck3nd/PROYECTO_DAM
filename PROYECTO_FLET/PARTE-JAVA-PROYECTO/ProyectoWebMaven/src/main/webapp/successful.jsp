<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="utils.JWTUtils" %>
<%@ page import="utils.UsuarioJWT" %>

<%
/**
 * Importación de clases necesarias para:
 * - Decodificación y validación de JWT (JWTUtils)
 * - Representación del usuario autenticado (UsuarioJWT)
 */
%>
<%

   /**
   * Se intenta obtener la información del usuario a partir del token JWT presente en la solicitud.
   * Si falla, se redirige al servlet de logout para cerrar la sesión y evitar acceso no autorizado.
   */

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
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>✅ Pago Exitoso</title>
  <link href="https://fonts.googleapis.com/css2?family=VT323&display=swap" rel="stylesheet">
  <style>
  * {
			font-family: 'VT323', monospace !important;
			font-size: 20px;
		}
    body {
      background-color: #121212;
      font-family: 'Segoe UI', sans-serif;
      color: #ffffff;
      margin: 0;
      padding: 40px;
      display: flex;
      flex-direction: column;
      align-items: center;
      justify-content: flex-start;
      min-height: 100vh;
    }

    .success-box {
      background-color: #1f1f1f;
      padding: 40px 50px;
      border-radius: 16px;
      box-shadow: 0 0 30px rgba(0, 255, 180, 0.2);
      text-align: center;
      max-width: 700px;
      width: 100%;
      animation: fadeIn 0.7s ease-in-out;
    }

    @keyframes fadeIn {
      from {opacity: 0; transform: translateY(20px);}
      to {opacity: 1; transform: translateY(0);}
    }

    h2 {
      color: #00ffaa;
      margin-bottom: 16px;
      font-size: 2rem;
    }

    p.subtext {
      font-size: 1rem;
      color: #cccccc;
      margin-bottom: 30px;
    }

    .info {
      background-color: #2a2a2a;
      padding: 20px;
      border-radius: 12px;
      text-align: left;
    }

    .info p {
      margin: 10px 0;
      font-size: 0.95rem;
    }

    .info strong {
      color: #00ffaa;
    }

    .btns {
      margin-top: 40px;
      display: flex;
      flex-wrap: wrap;
      justify-content: center;
      gap: 15px;
    }

    .btns button,
    .btns a {
      padding: 12px 28px;
      border-radius: 50px;
      font-weight: 600;
      cursor: pointer;
      border: none;
      font-size: 1rem;
      transition: 0.3s ease;
      text-decoration: none;
    }

    .btn-primary {
      background: linear-gradient(to right, #00ffaa, #00ddaa);
      color: #111;
    }

    .btn-primary:hover {
      background: linear-gradient(to right, #00cc88, #00b87a);
    }

    .btn-secondary {
      background-color: #ffffff10;
      color: #00ffaa;
      border: 1px solid #00ffaa;
    }

    .btn-secondary:hover {
      background-color: #00ffaa20;
    }
  </style>
</head>
<body>
  <div class="success-box">
    <h2>✅ ¡Gracias por tu pago!</h2>
    <p class="subtext">Hemos recibido tu donativo con éxito.</p>

    <div class="info" id="payment-details">
      <p><strong>🧾 ID de Transacción:</strong> <span id="tx-id">Cargando...</span></p>
      <p><strong>👤 Comprador:</strong> <span id="buyer-name">Cargando...</span></p>
      <p><strong>📧 Email:</strong> <span id="buyer-email">Cargando...</span></p>
      <p><strong>💵 Monto:</strong> <span id="amount">Cargando...</span></p>
      <p><strong>🕒 Fecha:</strong> <span id="date">Cargando...</span></p>
    </div>

    <div class="btns">
      <button class="btn-primary" onclick="generatePDF()">📄 Descargar Recibo PDF</button>
      <a class="btn-secondary" href="javascript:history.back()">⬅ Volver a la página anterior</a>
    </div>
  </div>

  <!-- jsPDF -->
  <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
  
  <script>
    const paymentData = JSON.parse(localStorage.getItem('paypalDetails')) || {
      id: 'TEMP1234567890',
      buyer: 'Nombre Apellido',
      email: 'comprador@email.com',
      amount: '10.00 USD',
      date: new Date().toLocaleString()
    };

    document.getElementById('tx-id').textContent = paymentData.id;
    document.getElementById('buyer-name').textContent = paymentData.buyer;
    document.getElementById('buyer-email').textContent = paymentData.email;
    document.getElementById('amount').textContent = paymentData.amount;
    document.getElementById('date').textContent = paymentData.date;

    async function generatePDF() {
        const { jsPDF } = window.jspdf;
        const doc = new jsPDF();

        const icons = {
          id: "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAAAKUlEQVR4nO3NMQEAAAjDMED5pGMCvlRA05XUZ/N6BwAAAAAAAAAAAIctrmMBQP8sJyUAAAAASUVORK5CYII=",
          user: "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAAAKUlEQVR4nO3NMQEAAAjDsIF/z2ACvlRAU8nks369AwAAAAAAAAAAgMMWocYBP7wfsd0AAAAASUVORK5CYII=",
          email: "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAAAKUlEQVR4nO3NMQEAAAjDMED5pGMCvlRA06nUZ/N6BwAAAAAAAAAAAIctruMBQPU+BlwAAAAASUVORK5CYII=",
          money: "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAAAKUlEQVR4nO3NMQEAAAjDMEA50jHBvlRA07UVbbJ7AAAAAAAAAAAA8NcBn4kAwO7os6MAAAAASUVORK5CYII=",
          date: "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAAAKklEQVR4nO3NQQEAAATAQPSvIScl+N0C7HI6XqvfPQAAAAAAAAAAALhrAXOSAeTQR2XiAAAAAElFTkSuQmCC"
        };

        const data = {
          id: document.getElementById("tx-id").textContent,
          buyer: document.getElementById("buyer-name").textContent,
          email: document.getElementById("buyer-email").textContent,
          amount: document.getElementById("amount").textContent,
          date: document.getElementById("date").textContent,
        };

        let y = 20;

        // Título
        doc.setFontSize(18);
        doc.setTextColor(40, 180, 150);
        doc.text("Recibo de Donación", 20, y);
        y += 20;
		
     	// Separador inicial
        doc.setDrawColor(200);
        doc.line(20, y, 190, y);
        y += 15;
        
        // Datos con iconos
        const drawLineWithIcon = async (label, value, iconBase64) => {
          const imgWidth = 8;
          const imgHeight = 8;
          await doc.addImage(iconBase64, "PNG", 20, y - 6, imgWidth, imgHeight);
          doc.setFontSize(12);
          doc.setTextColor(50);
          doc.text(label, 30, y);
          doc.setFont("helvetica", "bold");
          doc.text(value, 85, y);
          doc.setFont("helvetica", "normal");
          y += 12;
        };

        await drawLineWithIcon("ID de Transacción:", data.id, icons.id);
        await drawLineWithIcon("Nombre:", data.buyer, icons.user);
        await drawLineWithIcon("Email:", data.email, icons.email);
        await drawLineWithIcon("Monto:", data.amount, icons.money);
        await drawLineWithIcon("Fecha:", data.date, icons.date);
		
     	// Separador final
        doc.setDrawColor(200);
        doc.line(20, y, 190, y);
        y += 15;
        
        // Mensaje final
        doc.setFontSize(10);
        doc.setTextColor(100);
        doc.text("Gracias por apoyar este proyecto <3", 20, y + 20);

        doc.save("recibo_pago.pdf");
      }
  </script>
</body>
</html>
