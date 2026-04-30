import { Controller } from "@hotwired/stimulus"
import flatpickr from "flatpickr"
import { French } from "flatpickr/l10n/fr"
import { Spanish } from "flatpickr/l10n/es"
import { Italian } from "flatpickr/l10n/it"

const LOCALES = { fr: French, es: Spanish, it: Italian }

export default class extends Controller {
  static targets = ["display", "from", "to"]
  static values = { locale: { type: String, default: "en" } }

  connect() {
    const loc = (this.localeValue || "en").split("-")[0]
    const locale = LOCALES[loc] || undefined

    const showTwoMonths = window.matchMedia("(min-width: 700px)").matches

    this.picker = flatpickr(this.displayTarget, {
      appendTo: document.body,
      className: "airbnb-picker",
      mode: "range",
      showMonths: showTwoMonths ? 2 : 1,
      monthSelectorType: "static",
      dateFormat: "Y-m-d",
      altInput: true,
      altInputClass: "form-input camps-date-range__alt",
      altFormat: "d M Y",
      defaultDate: this.defaultDates(),
      locale,
      disableMobile: true,
      clickOpens: true,
      onChange: (_dates, _str, instance) => {
        this.updateHiddenFromInstance(instance)
      },
      onClose: (_dates, _str, instance) => {
        this.updateHiddenFromInstance(instance)
      },
      onReady: (_dates, _str, instance) => {
        const el = instance.calendarContainer
        if (el) el.style.zIndex = "10050"
      }
    })
  }

  disconnect() {
    if (this.picker) {
      this.picker.destroy()
      this.picker = null
    }
  }

  openPicker() {
    if (this.picker && !this.picker.isOpen) this.picker.open()
  }

  presetWeekend() {
    const [from, to] = this.computeWeekendRange()
    this.setRange(from, to)
  }

  presetNext7Days() {
    const from = this.startOfLocalDay(new Date())
    const to = new Date(from)
    to.setDate(to.getDate() + 6)
    this.setRange(from, to)
  }

  presetThisMonth() {
    const now = new Date()
    const from = new Date(now.getFullYear(), now.getMonth(), 1)
    const to = new Date(now.getFullYear(), now.getMonth() + 1, 0)
    this.setRange(from, to)
  }

  computeWeekendRange() {
    const today = this.startOfLocalDay(new Date())
    const dow = today.getDay()
    const sat = new Date(today)
    if (dow === 0) {
      sat.setDate(sat.getDate() + 6)
    } else if (dow !== 6) {
      sat.setDate(sat.getDate() + (6 - dow))
    }
    const sun = new Date(sat)
    sun.setDate(sun.getDate() + 1)
    return [sat, sun]
  }

  setRange(from, to) {
    if (!this.picker) return
    if (from && to) {
      this.picker.setDate([from, to], true)
    } else {
      this.picker.clear()
    }
    this.fromTarget.value = from ? this.format(from) : ""
    this.toTarget.value = to ? this.format(to) : ""
  }

  updateHiddenFromInstance(instance) {
    const dates = instance.selectedDates
    this.fromTarget.value = dates[0] ? this.format(dates[0]) : ""
    this.toTarget.value = dates[1] ? this.format(dates[1]) : ""
  }

  defaultDates() {
    const a = this.fromTarget.value
    const b = this.toTarget.value
    const out = []
    const da = this.parseYmd(a)
    const db = this.parseYmd(b)
    if (da) out.push(da)
    if (db) out.push(db)
    return out.length ? out : undefined
  }

  parseYmd(str) {
    if (!str || typeof str !== "string") return null
    const m = str.match(/^(\d{4})-(\d{2})-(\d{2})$/)
    if (!m) return null
    const d = new Date(parseInt(m[1], 10), parseInt(m[2], 10) - 1, parseInt(m[3], 10))
    return Number.isNaN(d.getTime()) ? null : d
  }

  format(date) {
    const yyyy = date.getFullYear()
    const mm = `${date.getMonth() + 1}`.padStart(2, "0")
    const dd = `${date.getDate()}`.padStart(2, "0")
    return `${yyyy}-${mm}-${dd}`
  }

  startOfLocalDay(d) {
    const x = new Date(d)
    x.setHours(0, 0, 0, 0)
    return x
  }
}
