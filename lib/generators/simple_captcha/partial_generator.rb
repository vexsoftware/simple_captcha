require 'rails/generators'

module SimpleCaptcha
  class PartialGenerator < Rails::Generators::Base                            
    def self.source_root
      @source_root ||= File.expand_path(File.join(File.dirname(__FILE__), 'templates/'))
    end
    
    def create_partial
      template "partial.erb", File.join('app/views', 'simple_captcha', "_captcha.erb")
    end
  end
end
