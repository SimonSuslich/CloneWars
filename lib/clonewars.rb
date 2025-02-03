require_relative 'tcp_server'
require_relative 'router'

# The CloneWars class initializes and starts the HTTP server, handling routing and requests.
class CloneWars
  # Returns the router instance for managing HTTP routes.
  #
  # @return [Router] The router instance used for routing requests.
  def self.r
    @r ||= Router.new
  end

  # Starts the HTTP server and listens for incoming requests.
  #
  # @param [Integer] port The port number to listen on (default is 4567).
  # 
  # @return [void]
  def self.run(port = 4567)
    server = HTTPServer.new(port, r())
    server.start
  end
end
