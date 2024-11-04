# frozen_string_literal: true

# Class that handles http requests
class Request
  attr_reader :method, :resource, :version, :headers, :params

  def initialize(request_string)
    request_lines = request_string.split("\n")
    first_line, *rest_lines = request_lines
    create_methods(first_line)
    create_headers(rest_lines)
    create_params(request_string)
  end

  def create_methods(source_string)
    @method, @resource, @version = source_string.split(' ')
    @method = @method.downcase.to_sym
  end

  def create_headers(source_strings)
    @headers = source_strings.select do |element|
      element.include?(':')
    end.map { |element| element.split(':', 2).map(&:strip) }.to_h
  end

  def create_params(source_string)
    @params = {}

    if source_string[-2..] != "\n\n"
      @params = source_string.split("\n")[-1].split('&').map do |element|
        element.include?('=') ? element.split('=', 2).map(&:strip) : nil
      end.compact.to_h
    end


    return unless @resource.include?('?')

    @params = @resource.split('?', 2)[-1].split('&').map do |element|
      element.include?('=') ? element.split('=', 2).map(&:strip) : nil
    end.compact.to_h
  end
end
