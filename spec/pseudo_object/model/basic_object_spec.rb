require 'pseudo_object/model/basic_object'
require 'spec_helper'

require_examples %w!
_common/class_methods/creating_an_instance
_common/instance_methods/not_being
basic_object/class_methods/valid_pseudo_methods
basic_object/instance_methods/not_overridden
basic_object/instance_methods/overridden
basic_object/instance_methods/own
!

describe ::PseudoObject::BasicObject do
  describe 'class methods' do
    it_behaves_like 'creating an instance'
    it_behaves_like 'valid pseudo methods'
  end

  describe 'instance methods' do
    it_behaves_like 'instance methods not being'
    it_behaves_like 'own instance methods of BasicObaject'
    it_behaves_like 'overridden instance methods of BasicObaject'
    it_behaves_like 'not overridden instance methods of BasicObaject'
  end
end
