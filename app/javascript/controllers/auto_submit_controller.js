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
      console.log('primera!');


    }, 300);

    this.element.addEventListener("change", (event) => {
      const selectValue = event.target.value;
      console.log('segunda!');
      console.log(event.target);
      for (const option of event.target.option) {
        option.selected = false;
        console.log('for 1');
        if (option.value === selectValue) {
          console.log('for 2');
          option.selected = true;
        }
      }

    })


  }
}
