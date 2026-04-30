import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "list"]
  static values = { url: String }

  connect() {
    this.debounceTimer = null
  }

  search() {
    const query = this.inputTarget.value.trim()
    if (query.length < 2) {
      this.listTarget.innerHTML = ""
      return
    }

    clearTimeout(this.debounceTimer)
    this.debounceTimer = setTimeout(() => this.fetchSuggestions(query), 220)
  }

  async fetchSuggestions(query) {
    try {
      const url = `${this.urlValue}?q=${encodeURIComponent(query)}`
      const response = await fetch(url, { headers: { Accept: "application/json" } })
      if (!response.ok) return

      const data = await response.json()
      this.listTarget.replaceChildren()
      data.forEach((entry) => {
        const opt = document.createElement("option")
        opt.value = entry.value
        opt.label = entry.label
        this.listTarget.appendChild(opt)
      })
    } catch (_error) {
      // Keep silent: search input still works as plain text.
    }
  }
}
