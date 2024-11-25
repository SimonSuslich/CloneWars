
require_relative 'router'
require_relative 'response'
require_relative 'request'
require 'socket'

class HTTPServer

    def initialize(port)
        @port = port
    end

    def define_routes
        @router = Router.new
        @router.add_route(:get, '/') do |request|
            "<h1>DOoode!!</h1>"
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
            route = @router.match_route(request)
            
            if route
                status = 200
                body = route[:block].call
            else
                status = 404
                body = "<h1>NOT FOUND</h1>"
            end
            
            response = Response.new(status, body)

            
            session.print response.print_data
        end
    end
end

server = HTTPServer.new(4567)
server.start
