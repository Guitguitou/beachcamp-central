module Layout
  class PublicNavbarComponent < ViewComponent::Base
    def initialize(current_user: nil, transparent: false)
      @current_user = current_user
      @transparent = transparent
    end

    erb_template <<~'ERB'
      <nav class="<%= navbar_classes %>" data-controller="mobile-menu">
        <div class="container ds-navbar__inner">
          <%= link_to root_path, class: "ds-navbar__brand" do %>
            🏐 <span><%= t("components.navbar.brand") %></span>
          <% end %>

          <ul class="ds-navbar__links hidden-mobile">
            <li><%= link_to t("components.navbar.explore"), camps_path, class: "ds-navbar__link" %></li>
            <% if @current_user %>
              <li><%= link_to t("components.navbar.my_camps"), player_dashboard_path, class: "ds-navbar__link" %></li>
              <% if @current_user.organizer? %>
                <li><%= link_to "Organiser", organizer_dashboard_path, class: "ds-navbar__link" %></li>
              <% end %>
              <% if @current_user.coach? %>
                <li><%= link_to "Coach", coach_dashboard_path, class: "ds-navbar__link" %></li>
              <% end %>
              <% if @current_user.admin? %>
                <li><%= link_to "Admin", admin_dashboard_path, class: "ds-navbar__link" %></li>
              <% end %>
              <li><%= link_to t("components.navbar.sign_out"), destroy_user_session_path, data: { turbo_method: :delete }, class: "ds-navbar__link" %></li>
            <% else %>
              <li><%= link_to t("components.navbar.log_in"), new_user_session_path, class: "ds-navbar__link" %></li>
              <li>
                <%= render Ui::ButtonComponent.new(size: "sm", href: new_user_registration_path) do %>
                  <%= t("components.navbar.sign_up") %>
                <% end %>
              </li>
            <% end %>
          </ul>

          <div class="ds-navbar__right">
            <%= render Layout::LocaleSwitcherComponent.new(current_locale: I18n.locale) %>
            <button type="button" class="ds-navbar__burger hidden-desktop" data-action="click->mobile-menu#toggle" aria-label="Menu">
              <span></span><span></span><span></span>
            </button>
          </div>
        </div>

        <div class="ds-navbar__mobile-menu hidden-desktop" data-mobile-menu-target="menu" style="display:none;">
          <ul>
            <li><%= link_to t("components.navbar.explore"), camps_path, class: "ds-navbar__link" %></li>
            <% if @current_user %>
              <li><%= link_to t("components.navbar.my_camps"), player_dashboard_path, class: "ds-navbar__link" %></li>
              <% if @current_user.organizer? %>
                <li><%= link_to "Organiser", organizer_dashboard_path, class: "ds-navbar__link" %></li>
              <% end %>
              <% if @current_user.coach? %>
                <li><%= link_to "Coach", coach_dashboard_path, class: "ds-navbar__link" %></li>
              <% end %>
              <% if @current_user.admin? %>
                <li><%= link_to "Admin", admin_dashboard_path, class: "ds-navbar__link" %></li>
              <% end %>
              <li><%= link_to t("components.navbar.sign_out"), destroy_user_session_path, data: { turbo_method: :delete }, class: "ds-navbar__link" %></li>
            <% else %>
              <li><%= link_to t("components.navbar.log_in"), new_user_session_path, class: "ds-navbar__link" %></li>
              <li><%= link_to t("components.navbar.sign_up"), new_user_registration_path, class: "ds-navbar__link" %></li>
            <% end %>
          </ul>
        </div>
      </nav>
    ERB

    private

    def navbar_classes
      base = "ds-navbar"
      base += " ds-navbar--transparent" if @transparent
      base
    end
  end
end
