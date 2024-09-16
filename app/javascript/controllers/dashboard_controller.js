import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="dashboard"
export default class extends Controller {
  static targets = ["content1", "content2", "content3"]

  connect() {
    console.log("estoy conectado")
    AOS.init();
    console.log("instalado aos")
  }

  showView(event) {
    event.preventDefault()
    console.log("hola");

    this.hideAllContents();


    const view = event.currentTarget.dataset.view;

    if (view === "1") {
      document.getElementById('content1').style.display = 'block';
    } else if (view === "2") {
      document.getElementById('content2').style.display = 'block';
    } else if (view === "3") {
      document.getElementById('content3').style.display = 'block';
    }

    AOS.refresh()
  }

  hideAllContents() {
    // Selecciona todos los elementos con los IDs que deseas ocultar
    const contents = ['content1', 'content2', 'content3'];

    // Oculta todos los contenidos
    contents.forEach(id => {
      const element = document.getElementById(id);
      if (element) {
        element.style.display = 'none';
      }
    });
  }


}
