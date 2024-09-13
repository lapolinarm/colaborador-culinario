import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="dashboard"
export default class extends Controller {
  static targets = ["title", "text"]

  connect() {
    console.log("estoy conectado")
    AOS.init();
    console.log("instalado aos")
  }

  showView(event) {
    event.preventDefault()
    console.log("hola");
    const view = event.target.dataset.view;

    if (view === "1") {
      this.titleTarget.innerText = 'Vista del Botón 1';
      this.textTarget.innerText = 'Este es el contenido de la vista del botón 1.';
    } else if (view === "2") {
      this.titleTarget.innerText = 'Vista del Botón 2';
      this.textTarget.innerText = 'Este es el contenido de la vista del botón 2.';
    }
  }


}
