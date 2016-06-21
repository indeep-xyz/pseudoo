module PseudoObject
  class BasicObject < ::BasicObject
    attr_reader \
        :pseudo_object

    PSEUDO_CLASS = ::BasicObject
    PSEUDO_INSTANCE_METHODS = %i/
    pseudo?
    pseudo_influence=
    pseudo_influence?
    pseudo_object
    pseudo_object=
    /

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
        influence: true
        )
      self.pseudo_object = object
      self.pseudo_influence = influence
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

    def pseudo_influence?
      @pseudo_influence
    end

    def pseudo_influence=(bool)
      @pseudo_influence = !!bool
    end

    # - - - - - - - - - - - - - - -
    # private - validate

    def method_missing(method_name, *args, &block)
      @pseudo_object.__send__(method_name, *args, &block)
    end
    private :method_missing

    def validate_class(object)
      unless object.kind_of?(PSEUDO_CLASS)
        fail TypeError.new(object)
      end
    end
    private :validate_class

    # - - - - - - - - - - - - - - -
    # pseudo - compare

    def ==(other)
      if other.kind_of?(PSEUDO_CLASS) \
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