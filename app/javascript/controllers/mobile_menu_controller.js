import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["menu"]

  toggle() {
    const menu = this.menuTarget
    const isHidden = menu.style.display === "none" || menu.style.display === ""
    menu.style.display = isHidden ? "block" : "none"
  }
}
