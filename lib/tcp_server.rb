require_relative 'router'
require_relative 'response'
require_relative 'request'
require_relative 'mime_type'
require 'socket'

# The HTTPServer class handles incoming HTTP requests, routing, and serving static files.
class HTTPServer
  # Initializes a new HTTP server.
  #
  # @param [Integer] port The port number to listen on.
  # @param [Router] router The router instance for handling dynamic routes.
  def initialize(port, router)
    @port = port
    @router = router
  end

  # Serves a static file from the file system.
  #
  # @param [String] path The file path to be served.
  #
  # @return [Array<Integer, String, String>] The HTTP status code, MIME type, and file content or an error message.
  def serve_static_file(path)
    if File.exist?(path) && !File.directory?(path)
      ext = File.extname(path)
      mime_type = Mime_type.new(ext)
      mime_type = mime_type.get_ext || mime_type[:mime_default].call
      content = File.binread(path) 

      return 200, mime_type, content
    else
      return 404, "text/plain", "404 Not Found"
    end
  end

  # Starts the HTTP server, listens for incoming connections, and handles requests.
  #
  # @return [void]
  def start
    server = TCPServer.new(@port)
    puts "Listening on #{@port}"

    while session = server.accept
      data = ""
      while line = session.gets and line !~ /^\s*$/
        data += line
      end
      puts "RECEIVED REQUEST"
      puts "-" * 40
      puts data
      puts "-" * 40 

      request = Request.new(data)
      route = @router.match_route(request)

      if route
        status = 200
        body = route
        mime_type = "text/html"
      else
        static_file_path = File.join("public", request.resource)
        status, mime_type, body = serve_static_file(static_file_path)
      end

      response = Response.new(status, body, mime_type, session)
      response.send
    end
  end
end
