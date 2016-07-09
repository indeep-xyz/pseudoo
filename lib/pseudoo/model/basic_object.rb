require_relative 'ext/definer/pseudoo_method_list'

module Pseudoo
  class BasicObject < ::BasicObject
    attr_reader \
        :pseudoo_object

    @@pseudoo_substance = self
    @@pseudoo_model = ::BasicObject

    class << self
      ModelExt::Definer::PseudooMethodList.define_methods(self)

      %w/
      pseudoo_substance
      pseudoo_model
      /.each do |method_name|
        define_method(method_name) do
          class_variable_get(:"@@#{method_name}")
        end
      end

      def pseudoo_superclass
        nil
      end
    end

    # - - - - - - - - - - - - - - -
    # error

    TypeError = ::Class.new(::TypeError) {
      def initialize(object)
        message = '%s is not a kind of %s class' % [
            object.class,
            @@pseudoo_model.name]
        super(message)
      end
    }

    # - - - - - - - - - - - - - - -
    # override - initialize

    def initialize(**options)
      self.pseudoo_object = @@pseudoo_model.new
      pseudoo_initialize_options(**options)
    end

    def pseudoo_initialize_options(
        infection: true
        )
      self.pseudoo_infection = infection
    end
    private :pseudoo_initialize_options

    # - - - - - - - - - - - - - - -
    # pseudo original - set

    def pseudoo_infection=(bool)
      @pseudoo_infection = !!bool
    end

    def pseudoo_object=(other)
      validate_pseudoo_class(other)
      @pseudoo_object = other
    end

    # - - - - - - - - - - - - - - -
    # pseudo original - get - bool

    def pseudo?
      true
    end

    def pseudoo_infection?
      @pseudoo_infection
    end

    # - - - - - - - - - - - - - - -
    # pseudo original - private - validate

    def validate_pseudoo_class(object)
      unless object.kind_of?(@@pseudoo_model)
        fail TypeError.new(object)
      end
    end
    private :validate_pseudoo_class

    # - - - - - - - - - - - - - - -
    # override - compare

    def ==(other)
      __id__ == other.__id__ \
          || @pseudoo_object.__id__ == other.__id__
    end

    def !=(other)
      !(self == other)
    end

    # - - - - - - - - - - - - - - -
    # override - convert

    def !
      !@pseudoo_object
    end

    # - - - - - - - - - - - - - - -
    # override - private - other

    def method_missing(method_name, *args, &block)
      @pseudoo_object.__send__(method_name, *args, &block)
    end
    private :method_missing
  end
end