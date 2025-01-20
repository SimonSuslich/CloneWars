
require_relative 'router'
require_relative 'response'
require_relative 'request'
require_relative 'mime_type'
require 'socket'

class HTTPServer

    def initialize(port)
        @port = port
    end

    def define_routes
        @router = Router.new
        

        @router.add_route(:get, '/') do
            "<h1>CloneWars Prog2 Projekt</h1>\n<a href='index.html'>go to index.html</a>\n<a href='/image.png'>go watch image</a>"
        end

        @router.add_route(:get, '/hey/:id') do |id|
            "Hey, Player #{id}"
        end

        @router.add_route(:get, '/dude/:id/:name') do |id, name|
            "Wassup #{name}! Your id is #{id}!"
        end

    end

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
            route = @router.match_route(request) #returnerar numera blocket direkt med eventuella variabler insatta
        

            if route
                status = 200
                body = route
                mime_type = "text/html"
            else
                static_file_path = "#{File.join("public", request.resource)}"
                status, mime_type, body = serve_static_file(static_file_path)
            end
            

            response = Response.new(status, body, mime_type, session)
            response.send
        end
    end
end

server = HTTPServer.new(4567)
server.start
