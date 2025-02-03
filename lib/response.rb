# The Response class represents an HTTP response.
class Response
  # @return [Integer] The HTTP status code (e.g., 200, 404, 500).
  # @return [String] The response body.
  # @return [Hash] The response headers.
  attr_reader :status, :body, :headers

  # Initializes a new HTTP response.
  #
  # @param [Integer] status The HTTP status code.
  # @param [String] body The response body.
  # @param [String] content_type The content type (default: "text/html").
  # @param [TCPSocket] session The client session for sending the response.
  def initialize(status, body, content_type = "text/html", session)
    @status = status
    @body = body.is_a?(String) ? body : body.force_encoding("BINARY")
    @headers = {
      "Content-Type" => content_type,
      "Content-Length" => @body.bytesize,
      "Connection" => "close"
    }
    @session = session
  end

  # Formats the response data as an HTTP response string.
  #
  # @return [String] The formatted HTTP response.
  def print_data
    response = []
    response << "HTTP/1.1 #{@status} #{status_message}"
    @headers.each { |key, value| response << "#{key}: #{value}" }
    response << ""
    response << @body
    response.join("\r\n")
  end

  # Sends the response over the session and closes it.
  #
  # @return [void]
  def send
    @session.print print_data
    @session.close
  end

  private

  # Returns the status message corresponding to the HTTP status code.
  #
  # @return [String] The status message (e.g., "OK", "Not Found").
  def status_message
    case @status
    when 200 then "OK"
    when 404 then "Not Found"
    when 500 then "Internal Server Error"
    else "Unknown"
    end
  end
end