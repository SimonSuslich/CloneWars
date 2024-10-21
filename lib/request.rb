# class Request
  
#   attr_reader :method, :resource

#   def initialize(request_string)
#     @method = :get
#     @resource = "/"
#   end
# end


class Request

  attr_reader :method, :resource, :version, :headers, :params

  def initialize(request_string)
      request_lines = request_string.split("\n")
      first_line, *rest_lines = request_lines 
      @method, @resource, @version = first_line.split(" ")
      @headers = rest_lines.map {|x| {x.split(": ")[0] => x.split(": ")[-1]}}.reduce(:merge)
      @params = {}
      @method = @method.downcase.to_sym
  end

end