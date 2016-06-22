module PseudoObject
  class BasicObject < ::BasicObject
    attr_reader \
        :pseudo_object

    @@pseudo_class = ::BasicObject

    class << self
      %w/
      pseudo_class
      /.each do |method_name|
        define_method(method_name) do
          class_variable_get(:"@@#{method_name}")
        end
      end

      %w/
      instance_methods
      methods
      private_instance_methods
      protected_instance_methods
      public_instance_methods
      /.each do |method_name|
        pseudo_method_name = 'pseudo_%s' % method_name

        define_method(pseudo_method_name) do
          __send__(method_name) \
              - superclass.__send__(method_name)
        end
      end

      def pseudo_superclass
        nil
      end

      def instance_methods_pseudized
        instance_methods \
            | @@pseudo_class.instance_methods
      end

      def public_instance_methods_pseudized
        public_instance_methods \
            | @@pseudo_class.public_instance_methods
      end
    end

    # - - - - - - - - - - - - - - -
    # error

    TypeError = ::Class.new(::TypeError) {
      def initialize(object)
        message = '%s is not a kind of %s class' % [
            object.class,
            PSEUDO_CLASS.name]
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
      unless object.kind_of?(@@pseudo_class)
        fail TypeError.new(object)
      end
    end
    private :validate_class

    # - - - - - - - - - - - - - - -
    # pseudo - compare

    def ==(other)
      if other.kind_of?(@@pseudo_class) \
          && other == @pseudo_object
        return true
      end

      false
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