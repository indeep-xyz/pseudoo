module PseudoObject
  class BasicObject < ::BasicObject
    attr_reader \
        :pseudo_object

    PSEUDO_CLASS = ::BasicObject
    PSEUDO_INSTANCE_METHODS = %i/
    pseudo_object
    pseudo_object=
    pseudo?
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

    def initialize(source)
      self.pseudo_object = source
    end

    # - - - - - - - - - - - - - - -
    # setter, bool

    def pseudo_object=(other)
      validate_class(other)
      @pseudo_object = other
    end

    def pseudo?
      true
    end

    # - - - - - - - - - - - - - - -
    # private - validate

    def method_missing(method_name, *args, &block)
      @pseudo_object.__send__(method_name, *args, &block)
    end
    private :method_missing

    def validate_class(source)
      unless source.kind_of?(PSEUDO_CLASS)
        fail TypeError.new(source)
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