require 'pseudoo/model/object'
require 'spec_helper'

require_examples %w!
basic_object/class_methods/listing_pseudoo_methods
basic_object/instance_methods/not_being
basic_object/instance_methods/not_overridden
basic_object/instance_methods/overridden
basic_object/instance_methods/own
object/class_methods/new
object/instance_methods/overridden_comparison
!

describe ::Pseudoo::Object do
  describe 'class methods' do
    it_behaves_like 'in BasicObject, listing pseudoo methods'
    it_behaves_like 'in Object, creating a new instance'
  end

  describe 'instance methods' do
    it_behaves_like 'in BasicObject, instance methods not being'
    it_behaves_like 'in BasicObject, own instance methods'
    it_behaves_like 'in BasicObject, overridden instance methods'
    it_behaves_like 'in BasicObject, not overridden instance methods'
    it_behaves_like 'in Object, overridden comparison instance methods'
  end
end
