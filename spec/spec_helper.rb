$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)
require 'pseudo_object'
require 'spec_helper/contextant'

def pure_instance_methods(cls)
  rspec_methods = %i/
      should_receive should_not_receive
      stub unstub stub_chain as_null_object null_object?
      received_message? should should_not/

  cls.instance_methods.reject do |method|
    rspec_methods.include?(method)
  end
end

def require_examples(suffixes, prefix = 'model/')
  root = "spec_helper/example/#{prefix}"

  suffixes.each do |suffix|
    require "#{root}#{suffix}"
  end
end
