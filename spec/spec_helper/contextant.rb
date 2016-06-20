require 'spec_helper/contextant/banner'
require 'spec_helper/contextant/sample'

class Contextant
  class << self
    def in(methods, &block)
      new.in(methods, &block)
    end

    def create_banner(source)
      create_banner(source)
    end
  end

  # Collect example variables for RSpec
  # and yield them
  #
  # @methods [Array] method names in Sample class
  def in(methods, &block)
    collect(methods).each do |object|
      yield(object, create_banner(object))
    end
  end

  def create_banner(source)
    Banner.new(source).full
  end

  private

  # Collect example variables for RSpec
  # from Sample class
  #
  # @methods [Array] method names in Sample class
  def collect(methods)
    methods.inject([]) do |result, method_name|
      data = Sample.send(method_name)
      result.push(*data)
    end
  end
end