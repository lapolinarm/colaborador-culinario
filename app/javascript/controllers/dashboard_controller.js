import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="dashboard"
export default class extends Controller {
  connect() {
    console.log("estoy conectado")
    AOS.init();
    console.log("instalado aos")
  }
}
