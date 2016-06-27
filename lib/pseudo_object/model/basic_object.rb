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
    # override - initialize

    def initialize(
        object,
        infection: true
        )
      self.pseudo_object = object
      self.pseudo_infection = infection
    end

    # - - - - - - - - - - - - - - -
    # pseudo original - set

    def pseudo_infection=(bool)
      @pseudo_infection = !!bool
    end

    def pseudo_object=(other)
      validate_pseudo_class(other)
      @pseudo_object = other
    end

    # - - - - - - - - - - - - - - -
    # pseudo original - get - bool

    def pseudo?
      true
    end

    def pseudo_infection?
      @pseudo_infection
    end

    # - - - - - - - - - - - - - - -
    # pseudo original - private - validate

    def validate_pseudo_class(object)
      unless object.kind_of?(@@pseudo_model)
        fail TypeError.new(object)
      end
    end
    private :validate_pseudo_class

    # - - - - - - - - - - - - - - -
    # override - compare

    def ==(other)
      __id__ == other.__id__ \
          || @pseudo_object.__id__ == other.__id__
    end

    def !=(other)
      !(self == other)
    end

    # - - - - - - - - - - - - - - -
    # override - convert

    def !
      !@pseudo_object
    end

    # - - - - - - - - - - - - - - -
    # override - private - other

    def method_missing(method_name, *args, &block)
      @pseudo_object.__send__(method_name, *args, &block)
    end
    private :method_missing
  end
end