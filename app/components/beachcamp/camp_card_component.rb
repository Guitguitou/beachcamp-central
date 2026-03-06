module Beachcamp
  class CampCardComponent < ViewComponent::Base
    with_collection_parameter :camp

    def initialize(camp:)
      @camp = camp
    end

    erb_template <<~'ERB'
      <a href="<%= camp_path(@camp) %>" class="ds-card ds-card--hoverable ds-camp-card" style="text-decoration:none; color:inherit;">
        <div class="ds-camp-card__image">
          <% if @camp.poster.attached? %>
            <%= image_tag url_for(@camp.poster), alt: @camp.title %>
          <% else %>
            <div style="width:100%; height:100%; background: linear-gradient(135deg, var(--ocean-200), var(--sunset-200));"></div>
          <% end %>
          <div class="ds-camp-card__image-overlay">
            <%= render Beachcamp::LevelBadgeComponent.new(level: @camp.level) %>
            <% if @camp.featured? %>
              <span class="ds-badge" style="background: var(--sand-400); color: var(--sand-900);"><%= t("components.camp_card.featured") %></span>
            <% end %>
          </div>
        </div>
        <div class="ds-camp-card__body">
          <div class="ds-camp-card__title"><%= @camp.title %></div>
          <div class="ds-camp-card__location">
            <%= @camp.location %>, <%= @camp.country %>
            &middot; <%= I18n.l(@camp.start_date, format: :short) %> – <%= I18n.l(@camp.end_date, format: :short) %>
          </div>
          <div class="ds-camp-card__meta">
            <div class="ds-camp-card__price">
              &euro;<%= @camp.price_cents / 100 %> <span><%= t("components.camp_card.per_person") %></span>
            </div>
            <%= render Beachcamp::SpotsIndicatorComponent.new(camp: @camp) %>
          </div>
        </div>
      </a>
    ERB
  end
end
