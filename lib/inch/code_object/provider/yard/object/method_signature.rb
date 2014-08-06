module Inch
  module CodeObject
    module Provider
      module YARD
        module Object
          # Utility class to describe (overloaded) method signatures
          class MethodSignature < Struct.new(:method, :yard_tag)
            attr_reader :method, :docstring

            # @param method [Provider::YARD::Object::MethodObject]
            # @param yard_tag [::YARD::Tags::Tag,nil] if nil, the method's normal signature is used
            def initialize(method, yard_tag = nil)
              @method = method
              @yard_tag = yard_tag
              @docstring = Provider::YARD::Docstring.new(relevant_object.docstring)
            end

            def all_signature_parameter_names
              relevant_object.parameters.map(&:first)
            end

            def has_code_example?
              if docstring.contains_code_example?
                true
              else
                !relevant_object.tags(:example).empty?
              end
            end

            def has_doc?
              !docstring.empty? && !implicit_docstring?
            end

            def parameters
              @parameters ||= all_parameter_names.map do |name|
                signature_name = in_signature(name)
                tag = parameter_tag(name) || parameter_tag(signature_name)
                MethodParameterObject.new(method, name, signature_name, tag)
              end
            end

            # Returns the parameter with the given +name+.
            # @param name [String,Symbol]
            # @return [MethodParameterObject]
            def parameter(name)
              parameters.find { |p| p.name == name.to_s }
            end

            # Returns +true+ if the other signature is identical to self
            # @param other [MethodSignature]
            # @return [Boolean]
            def same?(other)
              all_signature_parameter_names == other.all_signature_parameter_names
            end

            # Returns the actual signature of the method.
            # @return [String]
            def signature
              relevant_object.signature.gsub(/^(def\ )/, "")
            end

            private

            def all_parameter_names
              all_names = all_signature_parameter_names + parameter_tags.map(&:name)
              all_names.map do |name|
                normalize_parameter_name(name) if name
              end.compact.uniq
            end

            # Returns +true+ if the docstring was generated by YARD
            def implicit_docstring?
              YARD.implicit_docstring?(docstring, method)
            end

            # Returns how the given parameter is noted in the method's
            # signature.
            #
            # @param name [String] parameter name
            # @return [String]
            def in_signature(name)
              possible_names = [name, "*#{name}", "&#{name}"]
              (all_signature_parameter_names & possible_names).first
            end

            # Removes block, splat symbols, dollar sign,
            # leading and trailing brackets from a given +name+
            # (sometimes used to indicate optional parameters in overload
            # signatures).
            # @param name [String] parameter name
            # @return [String]
            def normalize_parameter_name(name)
              name.gsub(/[\&\*\$\[\]]/, "")
            end

            def parameter_tag(param_name)
              parameter_tags.find do |tag|
                tag.name == param_name
              end
            end

            def parameter_tags
              relevant_object.tags(:param)
            end

            def relevant_object
              @yard_tag || method.object
            end
          end
        end
      end
    end
  end
end
