module Layout
  class OrganizerSidebarComponent < ViewComponent::Base
    def initialize(current_path: "")
      @current_path = current_path
    end

    erb_template <<~'ERB'
      <aside class="ds-sidebar">
        <div style="padding: 0 var(--space-6); margin-bottom: var(--space-8);">
          <%= link_to root_path, class: "ds-navbar__brand" do %>
            🏐 <span><%= t("components.navbar.brand") %></span>
          <% end %>
        </div>
        <ul class="ds-sidebar__nav">
          <%= sidebar_link t("components.sidebar.dashboard"), organizer_dashboard_path, "📊" %>
          <%= sidebar_link t("components.sidebar.my_camps"), organizer_camps_path, "🏕" %>
          <%= sidebar_link t("components.sidebar.create_camp"), new_organizer_camp_path, "➕" %>
          <%= sidebar_link t("components.sidebar.messages"), organizer_conversations_path, "💬" %>
        </ul>
        <div style="padding: var(--space-6); margin-top: auto; border-top: 1px solid var(--neutral-200);">
          <%= link_to "← #{t('components.sidebar.back_to_site')}", root_path, class: "ds-sidebar__item" %>
        </div>
        <div style="padding: 0 var(--space-6);">
          <%= render Layout::LocaleSwitcherComponent.new(current_locale: I18n.locale) %>
        </div>
      </aside>
    ERB

    private

    def sidebar_link(label, path, icon)
      active = @current_path.start_with?(path)
      css = "ds-sidebar__item"
      css += " ds-sidebar__item--active" if active
      link_to path, class: css do
        "#{icon} #{label}".html_safe
      end
    end
  end
end
