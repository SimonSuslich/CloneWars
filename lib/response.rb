class Response
  attr_reader :status, :body, :headers

  def initialize(status, body, content_type = "text/html")
    @status = status
    @body = body.is_a?(String) ? body : body.force_encoding("BINARY")
    @headers = {
      "Content-Type" => content_type,
      "Content-Length" => @body.bytesize,
      "Connection" => "close"
    }
  end

  def print_data

    response = []
    response << "HTTP/1.1 #{@status} #{status_message}"
    @headers.each { |key, value| response << "#{key}: #{value}" }
    response << "" 
    response << @body 

    response.join("\r\n")
  end

  private

  def status_message
    case @status
    when 200 then "OK"
    when 404 then "Not Found"
    when 500 then "Internal Server Error"
    else "Unknown"
    end
  end
end
