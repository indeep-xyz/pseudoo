module Pseudoo
  module ModelExt
    module Definer
      class PseudooMethodList

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

            instance.define_pseudoo_methods
            instance.define_pseudooized_methods
          end
        end

        def initialize(cls)
          @class = cls
        end

        def define_pseudoo_methods
          METHOD_TYPES.each do |type|
            define_pseudoo_method(type)
          end
        end

        def define_pseudooized_methods
          define_pseudooized_method('instance_methods')
        end

        private

        # - - - - - - - - - - - - - - - -
        # Define

        # Define the class method of "pseudooized_*" series
        #
        # It returns an array including the names of methods
        # overriding the model's.
        #
        # @m [String] method name of the method to list methods
        def define_pseudooized_method(m)
          @class.class_eval <<-EOT
            define_method('#{pseudooized_method_name(m)}') do
              collection = ancestors[0..-2].inject([]) do |result, cls|
                result |= cls.#{m}
              end & pseudoo_model.#{m}

              head_of_commons = collection.index(:instance_eval)
              collection[0...head_of_commons]
            end
          EOT
        end

        # Define the class method of "pseudoo_*" series
        #
        # It returns an array including the names of methods
        # defined in Pseudoo.
        #
        # @m [String] method name of the method to list methods
        def define_pseudoo_method(m)
          @class.class_eval <<-EOT
            define_method('#{pseudoo_method_name(m)}') do
              ancestors[0..-2].inject([]) do |result, cls|
                result |= cls.#{m}
              end - pseudoo_model.#{m}
            end
          EOT
        end

        # - - - - - - - - - - - - - - - -
        # Parts

        def pseudooized_method_name(method_name)
          'pseudooized_%s' % method_name
        end

        def pseudoo_method_name(method_name)
          'pseudoo_%s' % method_name
        end
      end
    end
  end
end