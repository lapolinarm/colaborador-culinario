document.addEventListener('DOMContentLoaded', () => {
  const countdownElements = document.querySelectorAll('.expiration-time');

  countdownElements.forEach(el => {
    const timeRemaining = el.dataset.timeRemaining;

    function updateCountdown() {
      if (timeRemaining === "Oferta expirada") {
        el.innerHTML = "Oferta expirada";
        return;
      }

      try {
        const remainingTime = JSON.parse(timeRemaining);
        const distance = remainingTime.hours * 3600 + remainingTime.minutes * 60 + remainingTime.seconds;

        if (distance < 0) {
          el.innerHTML = "EXPIRED";
          return;
        }

        const hours = Math.floor(distance / 3600);
        const minutes = Math.floor((distance % 3600) / 60);
        const seconds = Math.floor(distance % 60);

        el.innerHTML = `${hours}h ${minutes}m ${seconds}s`;
      } catch (e) {
        el.innerHTML = "Error al calcular el tiempo";
      }
    }

    updateCountdown();
    setInterval(updateCountdown, 1000);
  });
});
