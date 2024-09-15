// app/javascript/home.js
document.addEventListener('turbo:frame-load', () => {
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

        // Restar un segundo
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

      // Actualizar el countdown cada segundo
      updateCountdown();
      setInterval(updateCountdown, 1000);

    } catch (e) {
      el.innerHTML = "Error al calcular el tiempo";
    }
  });
});


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
