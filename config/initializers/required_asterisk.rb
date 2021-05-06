module ActionView
  module Helpers
    class FormBuilder
      include TagHelper

      alias actual_label label

      def label method, content_or_options = nil, options = nil, &block
        begin
          if content_or_options && content_or_options.class == Hash
            options = content_or_options
          else
            content = content_or_options
          end
          if object.present? and object.class != Ransack::Search and object.class != OpenStruct
            if object.class.validators_on(method).map(&:class).include? ActiveRecord::Validations::PresenceValidator
              if options.class != Hash
                options = {class: " required"}
              else
                options[:class] = ((options[:class] || "") + " required").split.uniq
              end
            end
          end
          actual_label(method, content, options || {}, &block)
        rescue
        end

      end
    end
  end
end