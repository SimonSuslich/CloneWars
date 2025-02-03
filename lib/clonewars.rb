require_relative 'tcp_server'
require_relative 'router'

class CloneWars 

  def self.r
    @r ||= Router.new
  end

  def self.run(port=4567)
    
    server = HTTPServer.new(port, r())
    server.start
  end

end