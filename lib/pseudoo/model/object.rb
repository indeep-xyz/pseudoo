require_relative 'basic_object'

module Pseudoo
  class Object < BasicObject
    @@pseudoo_substance = self
    @@pseudoo_model = ::Object

    class << self
    end

    # - - - - - - - - - - - - - - -
    # in Pseudoo - compare

    def pseudoo_kind_of?(klass)
      @@pseudoo_substance.ancestors.include?(klass) \
          || @@pseudoo_model.ancestors.include?(klass)
    end
    alias_method :pseudoo_is_a?, :pseudoo_kind_of?

    def pseudoo_instance_of?(klass)
      @@pseudoo_substance == klass \
          || @@pseudoo_model == klass
    end

    # - - - - - - - - - - - - - - -
    # override - compare

    def kind_of?(klass)
      pseudoo_kind_of?(klass) \
          || @pseudoo_object.__send__(:kind_of?, *[klass])
    end
    alias_method :is_a?, :kind_of?

    def instance_of?(klass)
      pseudoo_instance_of?(klass) \
          || @pseudoo_object.__send__(:instance_of?, *[klass])
    end
    alias_method :===, :instance_of?

    # - - - - - - - - - - - - - - -
    # override - get

    def class
      @@pseudoo_model
    end
  end
end