module Ui
  class InputComponent < ViewComponent::Base
    def initialize(
      name:,
      label: nil,
      type: "text",
      value: nil,
      placeholder: nil,
      helper: nil,
      error: nil,
      required: false,
      form: nil,
      input_html: {}
    )
      @name = name
      @label = label
      @type = type
      @value = value
      @placeholder = placeholder
      @helper = helper
      @error = error
      @required = required
      @form = form
      @input_html = input_html
    end

    erb_template <<~ERB
      <div class="form-group">
        <% if @label %>
          <% if @form %>
            <%= @form.label @name, @label, class: "form-label" %>
          <% else %>
            <label for="<%= @name %>" class="form-label"><%= @label %><%= " *" if @required %></label>
          <% end %>
        <% end %>

        <% if @form %>
          <% if @type == "textarea" %>
            <%= @form.text_area @name, class: input_classes, placeholder: @placeholder, required: @required, **@input_html %>
          <% elsif @type == "select" %>
            <%= @form.select @name, @input_html.delete(:options) || [], { include_blank: @placeholder }, class: input_classes, required: @required, **@input_html %>
          <% else %>
            <%= @form.text_field @name, class: input_classes, type: @type, placeholder: @placeholder, required: @required, **@input_html %>
          <% end %>
        <% else %>
          <% if @type == "textarea" %>
            <textarea name="<%= @name %>" id="<%= @name %>" class="<%= input_classes %>" placeholder="<%= @placeholder %>" <%= "required" if @required %>><%= @value %></textarea>
          <% else %>
            <input type="<%= @type %>" name="<%= @name %>" id="<%= @name %>" value="<%= @value %>" class="<%= input_classes %>" placeholder="<%= @placeholder %>" <%= "required" if @required %>>
          <% end %>
        <% end %>

        <% if @error %>
          <p class="form-error"><%= @error %></p>
        <% elsif @helper %>
          <p class="form-helper"><%= @helper %></p>
        <% end %>
      </div>
    ERB

    private

    def input_classes
      classes = ["form-input"]
      classes << "form-input--error" if @error
      classes.join(" ")
    end
  end
end
