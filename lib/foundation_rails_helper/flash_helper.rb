require 'action_view/helpers'

module FoundationRailsHelper
  module FlashHelper
    # <div class="callout [success alert secondary]" data-closable>
    #   This is an alert box.
    #   <button class="close-button" data-close><span aria-hidden=true>&times;</span></button>
    # </div>
    DEFAULT_KEY_MATCHING = {
      :alert     => :alert,
      :notice    => :success,
      :info      => :info,
      :secondary => :secondary,
      :success   => :success,
      :error     => :alert,
      :warning   => :warning
    }
    def display_flash_messages(key_matching = {})
      key_matching = DEFAULT_KEY_MATCHING.merge(key_matching)
      key_matching.default = :standard

      capture do
        flash.each do |key, value|
          next if FoundationRailsHelper.configuration.ignored_flash_keys.include? key.to_sym
          alert_class = key_matching[key.to_sym]
          concat alert_box(value, alert_class)
        end
      end
    end

  private

    def alert_box(value, alert_class)
      content_tag :div, :class => "callout #{alert_class}", data: { closable: '', animate: 'slide-in-down slide-out-up' } do
        concat value
        if FoundationRailsHelper.configuration.show_close_button
          concat close_link
        end
      end
    end

    def close_link
      content_tag :button, class: :'close-button', type: :button, 'data-close': '' do
        content_tag :span, '&times;'.html_safe, :'aria-hidden' => true
      end
    end

  end
end
