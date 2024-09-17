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

  if (applyButton) {
    applyButton.addEventListener('click', (event) => {
      event.preventDefault(); // Evitar el envío inmediato del formulario

      // Cambiar el texto y bloquear el botón
      applyButton.value = "Aplicando...";
      applyButton.disabled = true;

      // Cambiar el color del botón
      applyButton.style.backgroundColor = "#95d8a6";

      // Opcional: Enviar el formulario después de un pequeño retraso para simular una acción real
      setTimeout(() => {
        applyButton.closest('form').submit(); // Enviar el formulario
      }, 500); // Puedes ajustar este tiempo según lo necesites
    });
  }
});
