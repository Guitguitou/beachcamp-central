import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["toggle"]

  connect() {
    this._mq = window.matchMedia("(min-width: 1024px)")
    this._onMql = () => this.applyMql()
    this._mq.addEventListener("change", this._onMql)
    this.applyMql()
  }

  disconnect() {
    this._mq.removeEventListener("change", this._onMql)
  }

  applyMql() {
    if (this._mq.matches) {
      this.element.classList.add("camps-search-panel--open")
      if (this.hasToggleTarget) {
        this.toggleTarget.setAttribute("aria-expanded", "true")
      }
    } else {
      this.element.classList.remove("camps-search-panel--open")
      if (this.hasToggleTarget) {
        this.toggleTarget.setAttribute("aria-expanded", "false")
      }
    }
  }

  toggle() {
    if (this._mq.matches) return

    this.element.classList.toggle("camps-search-panel--open")
    const open = this.element.classList.contains("camps-search-panel--open")
    if (this.hasToggleTarget) {
      this.toggleTarget.setAttribute("aria-expanded", open ? "true" : "false")
    }
  }
}
