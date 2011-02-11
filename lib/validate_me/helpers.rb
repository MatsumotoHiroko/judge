module ValidateMe

  module Helpers

    include ActionView::Helpers::TagHelper
    
    %w{text_field text_area}.each do |type|
      helper = <<-END
        def validated_#{type}(method, options = {})
          validators = self.object.class.validators_on(method).collect{ |v| { :kind => v.kind.to_s, :options => v.options } }
          options = { "data-validate" => validators.to_json }.merge(options)
          @template.#{type}(self.object_name, method, options)
        end
      END
      class_eval helper, __FILE__, __LINE__
    end

  end

end
