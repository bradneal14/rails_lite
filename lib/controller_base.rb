require 'active_support'
require 'active_support/core_ext'
require 'erb'
require_relative './session'
require 'active_support/inflector'

class ControllerBase
  attr_reader :req, :res, :params

  # Setup the controller
  def initialize(req, res, params={})
    @req = req
    @res = res
    already_built_response?
  end

  # Helper method to alias @already_built_response
  def already_built_response?
    @already_built_response ||= false
  end

  # Set the response status code and header
  def redirect_to(url)
    if @already_built_response
      raise "Double Render Error"
    else
      @res['Location'] = url
      @res.status = 302
      session.store_session(@res)
      @already_built_response = true
    end
  end

  # Populate the response with content.
  # Set the response's content type to the given type.
  # Raise an error if the developer tries to double render.
  def render_content(content, content_type)
    if @already_built_response
      raise "Double Render Error"
    else
      @res['content-type'] = content_type
      @res.write(content)
      session.store_session(@res)
      @already_built_response = true
    end
  end

  # use ERB and binding to evaluate templates
  # pass the rendered html to render_content
  def render(template_name)
    controller_name = "#{self.class.name}".underscore
    file_path = "views/#{controller_name}/#{template_name}.html.erb"
    contents = File.read(file_path)
    erb_version = ERB.new(contents)
    content = erb_version.result(binding)
    render_content(content, 'text/html')
  end

  # method exposing a `Session` object
  def session
    @session ||= Session.new(@req)
  end

  # use this with the router to call action_name (:index, :show, :create...)
  def invoke_action(name)
    something.send(name)
    unless @already_built_response
      render(name)
    end
  end
end
