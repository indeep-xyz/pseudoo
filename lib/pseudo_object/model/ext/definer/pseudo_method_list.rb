module PseudoObject
  module ModelExt
    module Definer
      class PseudoMethodList

        METHOD_TYPES = %w/
        instance_methods
        methods
        private_instance_methods
        protected_instance_methods
        public_instance_methods
        /

        class << self
          def define_methods(cls)
            instance = new(cls)

            instance.define_pseudo_methods
            instance.define_pseudized_methods
          end
        end

        def initialize(cls)
          @class = cls
        end

        def define_pseudo_methods
          METHOD_TYPES.each do |type|
            define_pseudo_method(type)
          end
        end

        def define_pseudized_methods
          define_pseudized_method('instance_methods')
        end

        private

        # - - - - - - - - - - - - - - - -
        # Define

        # Define the class method of "pseudized_*" series
        #
        # It returns an array including the names of methods
        # overriding the model's.
        #
        # @m [String] method name of the method to list methods
        def define_pseudized_method(m)
          @class.class_eval <<-EOT
            define_method('#{pseudized_method_name(m)}') do
              collection = ancestors[0..-2].inject([]) do |result, cls|
                result |= cls.#{m}
              end & pseudo_class.#{m}

              head_of_commons = collection.index(:instance_eval)
              collection[0...head_of_commons]
            end
          EOT
        end

        # Define the class method of "pseudo_*" series
        #
        # It returns an array including the names of methods
        # defined in PseudoObject.
        #
        # @m [String] method name of the method to list methods
        def define_pseudo_method(m)
          @class.class_eval <<-EOT
            define_method('#{pseudo_method_name(m)}') do
              ancestors[0..-2].inject([]) do |result, cls|
                result |= cls.#{m}
              end - pseudo_class.#{m}
            end
          EOT
        end

        # - - - - - - - - - - - - - - - -
        # Parts

        def pseudized_method_name(method_name)
          'pseudized_%s' % method_name
        end

        def pseudo_method_name(method_name)
          'pseudo_%s' % method_name
        end
      end
    end
  end
end