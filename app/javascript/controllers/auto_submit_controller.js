import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="auto-submit"
export default class extends Controller {
  static targets = ['form']

  connect(){
    console.log(this.formTarget);
  }

  filter(event) {
    event.preventDefault();
    clearTimeout(this.timeout);
    this.timeout = setTimeout(() => {
      this.formTarget.requestSubmit()
    }, 300);

    this.element.addEventListener("change", (event) => {
      const selectValue = event.target.value;
      for (const option of event.target.option) {
        option.selected = false;
        if (option.value === selectValue) {
          option.selected = true;
        }
      }

    })


  }
}
