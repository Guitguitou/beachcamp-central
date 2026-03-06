module Beachcamp
  class FilterBarComponent < ViewComponent::Base
    def initialize(filters:, current_params: {})
      @filters = filters
      @current_params = current_params
    end

    erb_template <<~ERB
      <div class="ds-filter-bar" data-controller="filter-bar">
        <% @filters.each do |filter| %>
          <% active = @current_params[filter[:param].to_s] == filter[:value].to_s %>
          <% if active %>
            <%= link_to camps_path(@current_params.except(filter[:param].to_s)),
                class: "ds-chip ds-chip--active",
                data: { turbo_action: "replace" } do %>
              <%= filter[:label] %> &times;
            <% end %>
          <% else %>
            <%= link_to camps_path(@current_params.merge(filter[:param] => filter[:value])),
                class: "ds-chip",
                data: { turbo_action: "replace" } do %>
              <%= filter[:label] %>
            <% end %>
          <% end %>
        <% end %>
      </div>
    ERB
  end
end
