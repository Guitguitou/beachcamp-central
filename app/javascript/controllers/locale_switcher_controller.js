import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["menu"]

  toggle(event) {
    event.stopPropagation()
    const menu = this.menuTarget
    const isHidden = menu.style.display === "none" || menu.style.display === ""
    menu.style.display = isHidden ? "block" : "none"
  }

  connect() {
    this._outsideClick = (event) => {
      if (!this.element.contains(event.target)) {
        this.menuTarget.style.display = "none"
      }
    }
    document.addEventListener("click", this._outsideClick)
  }

  disconnect() {
    document.removeEventListener("click", this._outsideClick)
  }
}
