import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["step", "indicator"]
  static values = { current: { type: Number, default: 1 }, total: { type: Number, default: 4 } }

  connect() {
    this.showStep()
  }

  next() {
    if (this.currentValue < this.totalValue) {
      this.currentValue++
      this.showStep()
    }
  }

  prev() {
    if (this.currentValue > 1) {
      this.currentValue--
      this.showStep()
    }
  }

  goTo(event) {
    const step = parseInt(event.currentTarget.dataset.step)
    if (step >= 1 && step <= this.totalValue) {
      this.currentValue = step
      this.showStep()
    }
  }

  showStep() {
    this.stepTargets.forEach((el, index) => {
      el.style.display = (index + 1 === this.currentValue) ? "block" : "none"
    })
    this.indicatorTargets.forEach((el, index) => {
      const step = index + 1
      el.classList.remove("ds-stepper__step--active", "ds-stepper__step--completed")
      if (step === this.currentValue) {
        el.classList.add("ds-stepper__step--active")
      } else if (step < this.currentValue) {
        el.classList.add("ds-stepper__step--completed")
      }
    })
  }
}
