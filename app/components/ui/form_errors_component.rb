module Ui
  class FormErrorsComponent < ViewComponent::Base
    def initialize(record:)
      @record = record
    end

    def render?
      @record.respond_to?(:errors) && @record.errors.any?
    end

    erb_template <<~ERB
      <div class="mb-4" style="color:var(--danger); font-size:var(--fs-sm);">
        <ul>
          <% @record.errors.full_messages.each do |message| %>
            <li><%= message %></li>
          <% end %>
        </ul>
      </div>
    ERB
  end
end
