require_relative 'basic_object'

module PseudoObject
  class Object < BasicObject
    @@pseudo_class = ::Object

    class << self
    end

  end
end