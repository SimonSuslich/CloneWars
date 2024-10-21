class Request

  attr_reader :method, :resource, :version, :headers, :params

  def initialize(request_string)
      request_lines = request_string.split("\n")
      first_line, *rest_lines = request_lines 
      @method, @resource, @version = first_line.split(" ")
      # params_line = rest_lines.pop
      p rest_lines
      @headers = rest_lines.map {|line| line.include?":" ? line.split(":", 2).map(&:strip) : nil }.to_h
      @params = extract_params(rest_lines)
      @method = @method.downcase.to_sym
  end

  def extract_params(request)
    url_params = extract_url_params(request)
    form_params = extract_form_params(request)
    url_params.merge(form_params)
  end

  def extract_url_params(request)
    query_string = request.split("\n").find { |line| line.include?("?") }
    return {} unless query_string

    query_string.split("?")[1].split(" ")[0].split("&").map { |param| param.plit("=") }.to_h
  end

  def extract_form_params(request)
    body  =request.split("\n\n", 2)[1]
    return {} unless body

    body.split("&").map { |param| param.split("=") }.to_h
  end 

end

request_string = File.read('../test/example_requests/get-index.request.txt')
p Request.new(request_string).headers