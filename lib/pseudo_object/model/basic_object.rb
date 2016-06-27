require_relative 'ext/definer/pseudo_method_list'

module PseudoObject
  class BasicObject < ::BasicObject
    attr_reader \
        :pseudo_object

    @@pseudo_substance = self
    @@pseudo_model = ::BasicObject

    class << self
      ModelExt::Definer::PseudoMethodList.define_methods(self)

      %w/
      pseudo_substance
      pseudo_model
      /.each do |method_name|
        define_method(method_name) do
          class_variable_get(:"@@#{method_name}")
        end
      end

      def pseudo_superclass
        nil
      end
    end

    # - - - - - - - - - - - - - - -
    # error

    TypeError = ::Class.new(::TypeError) {
      def initialize(object)
        message = '%s is not a kind of %s class' % [
            object.class,
            @@pseudo_model.name]
        super(message)
      end
    }

    # - - - - - - - - - - - - - - -
    # initialize

    def initialize(
        object,
        infection: true
        )
      self.pseudo_object = object
      self.pseudo_infection = infection
    end

    # - - - - - - - - - - - - - - -
    # setter, bool

    def pseudo?
      true
    end

    def pseudo_object=(other)
      validate_class(other)
      @pseudo_object = other
    end

    def pseudo_infection?
      @pseudo_infection
    end

    def pseudo_infection=(bool)
      @pseudo_infection = !!bool
    end

    # - - - - - - - - - - - - - - -
    # private - validate

    def method_missing(method_name, *args, &block)
      @pseudo_object.__send__(method_name, *args, &block)
    end
    private :method_missing

    def validate_class(object)
      unless object.kind_of?(@@pseudo_model)
        fail TypeError.new(object)
      end
    end
    private :validate_class

    # - - - - - - - - - - - - - - -
    # pseudo - compare

    def ==(other)
      __id__ == other.__id__ \
          || @pseudo_object.__id__ == other.__id__
    end

    def !=(other)
      !(self == other)
    end

    # - - - - - - - - - - - - - - -
    # pseudo - other

    def !
      !@pseudo_object
    end
  end
end