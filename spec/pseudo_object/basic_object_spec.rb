require 'pseudo_object/basic_object'

require 'spec_helper'
require 'spec_helper/example/_common/class_methods/creating_an_instance'
require 'spec_helper/example/_common/class_methods/having_instance_methods_correctly'
require 'spec_helper/example/_common/instance_methods/not_being'
require 'spec_helper/example/basic_object/instance_methods/not_overridden'
require 'spec_helper/example/basic_object/instance_methods/overridden'
require 'spec_helper/example/basic_object/instance_methods/own'

describe ::PseudoObject::BasicObject do
  describe 'class methods' do
    it_behaves_like 'creating an instance'
    it_behaves_like 'having instance methods correctly'
  end

  describe 'instance methods' do
    it_behaves_like 'instance methods not being'
    it_behaves_like 'own instance methods of BasicObaject'
    it_behaves_like 'overridden instance methods of BasicObaject'
    it_behaves_like 'not overridden instance methods of BasicObaject'
  end
end
