// app/javascript/home.js

// Controla todo lo relacionado al temporizador
function initializeCountdown() {
  const countdownElements = document.querySelectorAll('.expiration-time');

  countdownElements.forEach(el => {
    let timeRemaining = el.dataset.timeRemaining;

    if (timeRemaining === "Oferta expirada") {
      el.innerHTML = "Oferta expirada";
      return;
    }

    try {
      let remainingTime = JSON.parse(timeRemaining);
      let distance = remainingTime.hours * 3600 + remainingTime.minutes * 60 + remainingTime.seconds;

      function updateCountdown() {
        if (distance <= 0) {
          el.innerHTML = "EXPIRED";
          return;
        }

        distance--;

        const days = Math.floor(distance / (3600 * 24));
        const hours = Math.floor((distance % (3600 * 24)) / 3600);
        const minutes = Math.floor((distance % 3600) / 60);
        const seconds = Math.floor(distance % 60);

        let message = "Expira en<br>";

        if (days > 1) {
          message += `${days} días `;
        } else if (days === 1) {
          message += "1 día ";
        }

        if (hours > 0) {
          message += `${hours}h `;
        }

        message += `${minutes}m ${seconds}s`;

        el.innerHTML = message;
      }

      // Inicializar countdown y luego actualizar cada segundo
      updateCountdown();
      setInterval(updateCountdown, 1000);

    } catch (e) {
      el.innerHTML = "Error al calcular el tiempo";
    }
  });
}

// Ejecutar cuando la página cargue por primera vez
document.addEventListener('turbo:load', () => {
  initializeCountdown();
});

// Ejecutar cada vez que el frame de detalles de trabajo cambie
document.addEventListener('turbo:frame-load', () => {
  initializeCountdown();
});


// Muestra el inicio de cada detalle de trabajo, asegurando que se vean siempre desde el inicio.
document.addEventListener('turbo:frame-load', function() {
  const jobListings = document.getElementById('job_listings');
  const jobDetails = document.getElementById('job_details');

  if (jobListings && jobDetails) {
    jobListings.addEventListener('click', function() {
      console.log("Job listings clicked");
      jobDetails.scrollTop = 0;
    });
  }
});


// Bloque el botón de aplicar ahora y ajusta su estilo
document.addEventListener('turbo:load', () => {
  const applyButton = document.getElementById('apply-button');
  const countdownElement = document.getElementById('countdown');
  const overlayContent = document.getElementById('overlay-content');

  if (applyButton) {
    applyButton.addEventListener('click', (event) => {
      event.preventDefault(); // Evitar el envío inmediato del formulario

      // Cambiar el texto y bloquear el botón
      applyButton.value = "Aplicando...";
      applyButton.disabled = true;
      applyButton.style.backgroundColor = "#95d8a6"; // Cambiar el color del botón

      // Reemplazar el temporizador por la animación de Lottie después de 0.5 segundos
      setTimeout(() => {
        applyButton.value = "Aplicado";

        // Eliminar el temporizador
        countdownElement.style.display = "none";

        // Crear el script para cargar el módulo del reproductor de Lottie
        const scriptTag = document.createElement('script');
        scriptTag.src = 'https://unpkg.com/@dotlottie/player-component@latest/dist/dotlottie-player.mjs';
        scriptTag.type = 'module';
        document.body.appendChild(scriptTag); // Incluir el script en el cuerpo del documento

        // Crear el reproductor Lottie y agregarlo al contenido
        const lottiePlayer = document.createElement('dotlottie-player');
        lottiePlayer.src = 'https://lottie.host/2628aa95-9879-434a-9a91-910a0542b458/zR3s5igLJN.json';
        lottiePlayer.style.width = '100px';
        lottiePlayer.style.height = '100px';
        lottiePlayer.setAttribute('background', 'transparent');
        lottiePlayer.setAttribute('speed', '1');
        lottiePlayer.setAttribute('loop', '');
        lottiePlayer.setAttribute('autoplay', '');
        overlayContent.appendChild(lottiePlayer); // Añadir el reproductor al overlay

        // Mantener la animación visible por 1.5 segundos
        setTimeout(() => {
          lottiePlayer.remove(); // Eliminar la animación

          // Crear y mostrar el texto de carga con estilo directo
          const loadingText = document.createElement('span');
          loadingText.innerText = "Cargando nuevo empleo...";

          // Aplicar los estilos directamente desde JS
          loadingText.style.textAlign = "center";
          loadingText.style.lineHeight = "1.5";
          loadingText.style.fontWeight = "bold";
          loadingText.style.fontSize = "18px"; // Ajuste a 18px
          loadingText.style.color = "white"; // Color blanco
          loadingText.style.display = "block"; // Asegura que esté en una sola fila

          overlayContent.appendChild(loadingText); // Agregar el texto de carga al DOM

          // Continuar con el envío del formulario inmediatamente
          applyButton.closest('form').submit();

        }, 2000); // Mantener la animación visible por 1.5 segundos
      }, 500); // Esperar 0.5 segundos antes de cambiar el texto a "Aplicado"
    });
  }
});
