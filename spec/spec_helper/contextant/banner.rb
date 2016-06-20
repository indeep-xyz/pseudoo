class Contextant
  class Banner
    attr_reader :object

    def initialize(object)
      @object = object
    end

    def full
      "has #{@object.class}#{value_part}"
    end

    def value_part
      %w/
      class proc
      string symbol other
      /.each do |type|
        temp = send("value_part_#{type}")

        if temp.kind_of?(::String)
          return '(%s)' % temp
        end
      end

      ''
    end

    private

    # - - - - - - - - - - - - - - -
    # make string in a part of object value

    def value_part_class
      if object_kind_of?(::Class)
        return '::%s' % @object
      end
    end

    def value_part_proc
      if object_kind_of?(::Proc)
        return @object.lambda? \
            ? 'proc'
            : 'lambda'
      end
    end

    def value_part_string
      if object_kind_of?(::String)
        return '"%s"' % @object
      end
    end

    def value_part_symbol
      if object_kind_of?(::Symbol)
        return ':%s' % @object
      end
    end

    def value_part_other
      if @object.respond_to?(:to_s) \
          && @object.to_s.length > 0
        return '%s' % @object.to_s
      end
    end

    def object_kind_of?(cls)
      @object.respond_to?(:kind_of?) \
          && @object.kind_of?(cls)
    end
  end
end