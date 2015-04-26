module Inch
  module Language
    module Crystal
    end
  end
end

require 'inch/language/crystal/provider/yard'

require 'inch/language/crystal/code_object/base'
require 'inch/language/crystal/code_object/namespace_object'
require 'inch/language/crystal/code_object/class_object'
require 'inch/language/crystal/code_object/class_variable_object'
require 'inch/language/crystal/code_object/constant_object'
require 'inch/language/crystal/code_object/method_object'
require 'inch/language/crystal/code_object/method_parameter_object'
require 'inch/language/crystal/code_object/module_object'

require 'inch/language/crystal/evaluation/base'
require 'inch/language/crystal/evaluation/namespace_object'
require 'inch/language/crystal/evaluation/class_object'
require 'inch/language/crystal/evaluation/class_variable_object'
require 'inch/language/crystal/evaluation/constant_object'
require 'inch/language/crystal/evaluation/method_object'
require 'inch/language/crystal/evaluation/module_object'

require 'inch/language/crystal/roles/base'
require 'inch/language/crystal/roles/missing'
require 'inch/language/crystal/roles/object'
require 'inch/language/crystal/roles/method'
require 'inch/language/crystal/roles/method_parameter'
require 'inch/language/crystal/roles/namespace'
require 'inch/language/crystal/roles/constant'
require 'inch/language/crystal/roles/class_variable'
