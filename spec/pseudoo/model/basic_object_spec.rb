require 'pseudoo/model/basic_object'
require 'spec_helper'

require_examples %w!
basic_object/class_methods/listing_pseudoo_methods
basic_object/class_methods/new
basic_object/instance_methods/not_being
basic_object/instance_methods/not_overridden
basic_object/instance_methods/overridden
basic_object/instance_methods/own
!

describe ::Pseudoo::BasicObject do
  describe 'class methods' do
    it_behaves_like 'in BasicObject, creating a new instance'
    it_behaves_like 'in BasicObject, listing pseudoo methods'
  end

  describe 'instance methods' do
    it_behaves_like 'in BasicObject, instance methods not being'
    it_behaves_like 'in BasicObject, own instance methods'
    it_behaves_like 'in BasicObject, overridden instance methods'
    it_behaves_like 'in BasicObject, not overridden instance methods'
  end
end
