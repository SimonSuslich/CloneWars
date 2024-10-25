class Request

  attr_reader :method, :resource, :version, :headers, :params

  def initialize(request_string)
      request_lines = request_string.split("\n")
      first_line, *rest_lines = request_lines 
      @method, @resource, @version = first_line.split(" ")
      @method = @method.downcase.to_sym
      
      @headers = rest_lines.map {|element| element.include?(":") ? element.split(":", 2).map(&:strip) : nil}.compact.to_h
      
      @params = {}
      request_string[-2..-1] != "\n\n" ? @params = rest_lines[-1].split("&").map {|element| element.include?("=") ? element.split("=", 2).map(&:strip) : nil}.compact.to_h : nil
      @resource.include?("?") ? @params = @resource.split("?", 2)[-1].split("&").map {|element| element.include?("=") ? element.split("=", 2).map(&:strip) : nil}.compact.to_h : nil
  end
end