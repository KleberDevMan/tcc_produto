module ActionView
  module Helpers
    class FormBuilder
      include TagHelper

      alias actual_label label

      def label method, content_or_options = nil, options = nil, &block
        if content_or_options && content_or_options.class == Hash
          options = content_or_options
        else
          content = content_or_options
        end
        if object.class != Ransack::Search
          unless object.nil?
            if object.class.validators_on(method).map(&:class).include? ActiveRecord::Validations::PresenceValidator
              if options.class != Hash
                options = {class: " required"}
                # else
                #     options[:class] = ((options[:class] || "") + " required")
                #               .split.uniq.join Settings.salary_module.space
              end
            end
          end
        end
        actual_label(method, content, options || {}, &block)
      end
    end
  end
end