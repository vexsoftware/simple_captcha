# encoding: utf-8
require 'rails'
require 'simple_captcha'

module SimpleCaptcha
  class Engine < ::Rails::Engine
    config.before_initialize do
      ActiveSupport.on_load :active_record do
        ActiveRecord::Base.send(:include, SimpleCaptcha::ModelHelper)
      end
    end

    config.after_initialize do
      ActionController::Base.send(:include, SimpleCaptcha::ControllerHelper)
      ActionView::Base.send(:include, SimpleCaptcha::ViewHelper)
      ActionView::Helpers::FormBuilder.send(:include, SimpleCaptcha::FormBuilder)

      if Object.const_defined?("Formtastic")
        if Formtastic.const_defined?("Helpers")
          Formtastic::Helpers::FormHelper.builder = SimpleCaptcha::CustomFormBuilder
        else
          Formtastic::SemanticFormHelper.builder = SimpleCaptcha::CustomFormBuilder
        end
      end
    end

    config.app_middleware.use SimpleCaptcha::Middleware
  end
end


