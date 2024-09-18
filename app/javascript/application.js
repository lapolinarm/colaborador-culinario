// Turbo (para mejorar la navegación de las páginas sin recargar)
import "@hotwired/turbo-rails"

// Controladores de Stimulus
import "controllers"

// Importar Bootstrap y Popper.js
import "@popperjs/core"
import "bootstrap"

// Importar Chartkick y Chart.bundle (para gráficos)
import "chartkick"
import "Chart.bundle"

// Si usas tooltips o popovers de Bootstrap, necesitas inicializarlos manualmente
document.addEventListener("DOMContentLoaded", () => {
  // Inicializar tooltips de Bootstrap
  const tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
  tooltipTriggerList.map(function (tooltipTriggerEl) {
    return new bootstrap.Tooltip(tooltipTriggerEl)
  })

  // Inicializar popovers de Bootstrap
  const popoverTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="popover"]'))
  popoverTriggerList.map(function (popoverTriggerEl) {
    return new bootstrap.Popover(popoverTriggerEl)
  })
})
