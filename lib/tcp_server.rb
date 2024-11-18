
require_relative 'router'
require_relative 'response'
require_relative 'request'
require 'socket'

class HTTPServer

    def initialize(port)
        @port = port
    end

    def define_routes
        router = Router.new
        router.add_route(:get, '/') do |request|
            Response.new(200, "<h1>DOoode!!</h1>")
        end
    end

    def start
        server = TCPServer.new(@port)
        puts "Listening on #{@port}"

        define_routes()

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
            router.match_route(request)
            # Sen kolla om resursen (filen finns)



            session.print response.printData
        end
    end
end

server = HTTPServer.new(4567)
server.start
