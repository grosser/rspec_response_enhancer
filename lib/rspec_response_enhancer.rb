require 'rspec_response_additions'
#we cannot use these as simple additions, since they would be overwritten
module RspecResponseEnhancer
  #--------Enhance old Methods
  #TODO DRY
  #redirect_to
  class RedirectToEnhancer < Spec::Rails::Matchers::RedirectTo
    def initialize(do_not,care,response)
      super(do_not,care)
      @enhancer = Spec::Rails::Matchers::StatusEnhancer.new :status_verb => 'redirect'#does not need status_verb, but matches fails without
      @enhancer.matches?(response)
    end
    def failure_message
      clean_duplicates(super)
    end
    def negative_failure_message
      clean_duplicates(super)
    end
  private 
    def clean_duplicates text
      out = @enhancer.status_info_to_text(text).split("\n")
      out.reject! {|x| x =~ /^ - redirected to/}
      out.join("\n")
    end
  end
  
  def redirect_to(opts)
    RedirectToEnhancer.new(request, opts,response)
  end
  
  #render_template
  class RenderTemplateEnhancer < Spec::Rails::Matchers::RenderTemplate
    def initialize(do_not,care,response)
      super(do_not,care)
      @enhancer = Spec::Rails::Matchers::StatusEnhancer.new :status_verb => 'redirect'#does not need status_verb, but matches fails without
      @enhancer.matches?(response)
    end
    def failure_message
      clean_duplicates super.sub(/^expected "/,"expected to render \"")#a bit more descriptive...
    end
    def negative_failure_message
      clean_duplicates super
    end
    private 
    def clean_duplicates text
      out = @enhancer.status_info_to_text(text).split("\n")
      out.reject! {|x| x =~ /^ - rendered/}
      out.join("\n")
    end
  end
  
  def render_template(path)
    RenderTemplateEnhancer.new(path.to_s, @controller ,response)
  end
end