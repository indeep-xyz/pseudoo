require_relative 'basic_object'

module PseudoObject
  class Object < BasicObject
    @@pseudo_substance = self
    @@pseudo_model = ::Object

    class << self
    end

    # - - - - - - - - - - - - - - -
    # pseudo original - compare

    def pseudo_kind_of?(klass)
      @@pseudo_substance.ancestors.include?(klass) \
          || @@pseudo_model.ancestors.include?(klass)
    end
    alias_method :pseudo_is_a?, :pseudo_kind_of?

    def pseudo_instance_of?(klass)
      @@pseudo_substance == klass \
          || @@pseudo_model == klass
    end

    # - - - - - - - - - - - - - - -
    # override - compare

    def kind_of?(klass)
      pseudo_kind_of?(klass) \
          || @pseudo_object.__send__(:kind_of?, *[klass])
    end
    alias_method :is_a?, :kind_of?

    def instance_of?(klass)
      pseudo_instance_of?(klass) \
          || @pseudo_object.__send__(:instance_of?, *[klass])
    end
    alias_method :===, :instance_of?

    # - - - - - - - - - - - - - - -
    # override - get

    def class
      @@pseudo_model
    end
  end
end