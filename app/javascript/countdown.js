document.addEventListener('DOMContentLoaded', () => {
  const countdownElement = document.getElementById('countdown');
  let timeRemaining = parseInt(countdownElement.getAttribute('data-time-remaining'), 10);

  if (isNaN(timeRemaining)) {
    console.error('El valor de data-time-remaining no es un número válido');
    return;
  }

  function updateCountdown() {
    if (timeRemaining <= 0) {
      countdownElement.textContent = 'Expirado';
      return;
    }

    const hours = Math.floor(timeRemaining / 3600);
    const minutes = Math.floor((timeRemaining % 3600) / 60);
    const seconds = timeRemaining % 60;

    countdownElement.textContent = `Expira en ${hours.toString().padStart(2, '0')}:${minutes.toString().padStart(2, '0')}:${seconds.toString().padStart(2, '0')}`;

    timeRemaining -= 1;
  }

  updateCountdown(); // Llama a la función una vez para mostrar el tiempo inicial
  setInterval(updateCountdown, 1000); // Actualiza el contador cada segundo
});
