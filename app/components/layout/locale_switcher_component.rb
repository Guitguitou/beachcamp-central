module Layout
  class LocaleSwitcherComponent < ViewComponent::Base
    LOCALES = {
      en: { label: "EN", flag: "🇬🇧" },
      fr: { label: "FR", flag: "🇫🇷" },
      es: { label: "ES", flag: "🇪🇸" },
      it: { label: "IT", flag: "🇮🇹" }
    }.freeze

    def initialize(current_locale:, style: :dropdown)
      @current_locale = current_locale.to_sym
      @style = style
    end

    erb_template <<~'ERB'
      <div class="ds-locale-switcher" data-controller="locale-switcher">
        <button type="button" class="ds-locale-switcher__trigger" data-action="click->locale-switcher#toggle">
          <%= current_flag %> <%= current_label %> ▾
        </button>
        <ul class="ds-locale-switcher__menu" data-locale-switcher-target="menu" style="display:none;">
          <% LOCALES.each do |code, info| %>
            <li>
              <a href="<%= locale_switch_path(code) %>" class="<%= item_class(code) %>" data-turbo="false">
                <%= info[:flag] %> <%= info[:label] %>
              </a>
            </li>
          <% end %>
        </ul>
      </div>
    ERB

    private

    def current_flag
      LOCALES.dig(@current_locale, :flag) || "🇬🇧"
    end

    def current_label
      LOCALES.dig(@current_locale, :label) || "EN"
    end

    def locale_switch_path(code)
      current_path = request.path
      new_path = current_path.sub(%r{^/(en|fr|es|it)}, "/#{code}")
      new_path = "/#{code}" if new_path == current_path
      query = request.query_string.presence
      query ? "#{new_path}?#{query}" : new_path
    end

    def item_class(code)
      classes = "ds-locale-switcher__item"
      classes += " ds-locale-switcher__item--active" if code == @current_locale
      classes
    end
  end
end
