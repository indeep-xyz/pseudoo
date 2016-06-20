class Contextant
  module Sample
    module_function

    def method_missing(message, *args)
      eval "#{message.to_s}"
    end

    # - - - - - - - - - - - - - - -
    # class

    def class_object
      ::BasicObject
    end

    # - - - - - - - - - - - - - - -
    # numeric

    def fixnum
      1
    end

    def bignum
      100000000000000000000000
    end

    def float
      1.0
    end

    def integer
      [0, fixnum, bignum]
    end

    def numeric
      integer | [float]
    end

    def negative_float
      float.map { |n| n * -1 }
    end

    def negative_integer
      integer.map { |n| n * -1 }
    end

    def negative_numeric
      numeric.map { |n| n * -1 }
    end

    def numeric_all
      numeric | negative_numeric
    end

    # - - - - - - - - - - - - - - -
    # string, symbol

    def string
      'StringData'
    end

    def symbol
      :SymbolData
    end

    # - - - - - - - - - - - - - - -
    # collection

    def array
      [1, 2, 3]
    end

    def hash
      {
        name: 'Taro',
        age: 20,
        address: 'Asia'
      }
    end

    def collection
      [array, hash]
    end

    # - - - - - - - - - - - - - - -
    # block - Proc, lambda

    def proc
      Proc.new { 'Proc!' }
    end

    def lambda
      ::Kernel.lambda { 'Lambda!' }
    end

    def block
      [proc, lambda]
    end

    # - - - - - - - - - - - - - - -
    # bool

    def bool
      [true, false]
    end

    def falsey
      [false, nil]
    end

    def truthy
      [true, numeric, string, array, hash, class_object, block]
    end

    # - - - - - - - - - - - - - - -
    # other

    def all
      [string, symbol, class_object, nil] \
          | numeric_all \
          | bool \
          | block \
          | collection
    end
  end
end