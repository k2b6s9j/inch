module Inch
  module Language
    module Crystal
      module CodeObject
        # Proxy class for methods
        class MethodObje


          ct < Base
          def constructor?
            self[:constructor?]
          end

          def bang_name?
            self[:bang_name?]
          end

          def getter?
            self[:getter?]
          end

          def has_doc?
            super || mentioned_in_parent_docstring?
          end

          def has_parameters?
            !parameters.empty?
          end

          MANY_PARAMETERS_THRESHOLD = 3
          def has_many_parameters?
            parameters.size > MANY_PARAMETERS_THRESHOLD
          end

          MANY_LINES_THRESHOLD = 20
          def has_many_lines?
            # for now, this includes the 'def' line and comments
            if source
              size = source.lines.count
              size > MANY_LINES_THRESHOLD
            else
              false
            end
          end

          def parameter(name)
            parameters.find { |p| p.name == name.to_s }
          end

          def parameters
            @parameters ||= self[:parameters].map do |param_attr|
              MethodParameterObject.new(param_attr)
            end
          end

          def overridden?
            self[:overridden?]
          end

          def overridden_method
            @overridden_method ||=
              object_lookup.find(self[:overridden_method_fullname])
          end

          def return_mentioned?
            self[:return_mentioned?]
          end

          def return_described?
            self[:return_described?]
          end

          def return_typed?
            self[:return_typed?]
          end

          def setter?
            self[:setter?]
          end

          def source
            self[:source?]
          end

          def undocumented?
            super && !mentioned_in_parent_docstring?
          end

          def questioning_name?
            self[:questioning_name?]
          end

          private

          def mentioned_in_parent_docstring?
            parent && parent.has_doc_for?(name)
          end

        end
      end
    end
  end
end
