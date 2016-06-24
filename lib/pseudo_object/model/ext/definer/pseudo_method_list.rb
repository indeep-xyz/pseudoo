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
            new(cls).define_methods
          end
        end

        def initialize(cls)
          @class = cls
        end

        def define_methods
          METHOD_TYPES.each do |type|
            define_pseudized_method(type)
            define_pseudo_method(type)
          end
        end

        private

        # - - - - - - - - - - - - - - - -
        # Define

        # Define the class method of "pseudized_*" series
        #
        # It returns an array including the names of methods
        # defined in PseudoObject and in the model.
        #
        # @m [String] method name of the method to list methods
        def define_pseudized_method(m)
          @class.class_eval <<-EOT
            define_method('#{pseudized_method_name(m)}') do
              #{pseudo_method_name(m)} \
                  | pseudo_class.#{m}
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
              ancestors.inject([]) do |collection, ancestor|
                collection |= ancestor.#{m}
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