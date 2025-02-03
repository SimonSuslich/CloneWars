# frozen_string_literal: true

# The Request class parses an HTTP request string into its components,
# including the method, resource, HTTP version, headers, and parameters.
class Request
  # @return [Symbol] The HTTP method (:get, :post).  
  # @return [String] The requested resource path (e.g., "/users?id=1").  
  # @return [String] The HTTP version (e.g., "HTTP/1.1").  
  # @return [Hash] A hash of HTTP headers.  
  # @return [Hash] A hash of query and body parameters.  
  attr_reader :method, :resource, :version, :headers, :params

  # Initializes a new Request instance by parsing the request string.
  #
  # @param [String] request_string The raw HTTP request as a string.
  def initialize(request_string)
    request_lines = request_string.split("\n")
    first_line, *rest_lines = request_lines

    create_methods(first_line)
    create_headers(rest_lines)
    create_params(request_string)
  end

  private

  # Parses the first line of the request string to extract the HTTP method, resource, and version.
  #
  # @param [String] source_string The first line of the HTTP request.
  #
  # @return [void]
  def create_methods(source_string)
    @method, @resource, @version = source_string.split(' ')
    @method = @method.downcase.to_sym
  end

  # Parses the remaining lines of the request to extract headers.
  #
  # @param [Array<String>] source_strings The header lines of the request.
  #
  # @return [void]
  def create_headers(source_strings)
    headers_info = []
    source_strings.each do |element|
      headers_info << element if element.include?(':')
    end

    @headers = headers_info.map { |element| element.split(':', 2).map(&:strip) }.to_h
  end

  # Extracts query parameters from the URL and body parameters from the request body.
  #
  # @param [String] source_string The full request string.
  #
  # @return [void]
  def create_params(source_string)
    @params = {}

    if source_string[-2..] != "\n\n"
      @params = source_string.split("\n")[-1].split('&').map do |element|
        assert_params(element)
      end.compact.to_h
    end

    return unless @resource.include?('?')

    @params = @resource.split('?', 2)[-1].split('&').map do |element|
      assert_params(element)
    end.compact.to_h
  end

  # Parses a key-value pair from a query string or body.
  #
  # @param [String] element A parameter string in "key=value" format.
  #
  # @return [Array<String>, nil] A key-value pair or nil if the format is invalid.
  def assert_params(element)
    element.include?('=') ? element.split('=', 2).map(&:strip) : nil
  end
end
