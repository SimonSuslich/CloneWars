
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
            "<h1>CloneWars Prog2 Projetk</h1>"
        end
    end

    mime_types = {
        ".html" => "text/html",
        ".css"  => "text/css",
        ".js"   => "application/javascript",
        ".png"  => "image/png",
        ".jpg"  => "image/jpeg",
        ".jpeg" => "image/jpeg",
        ".gif"  => "image/gif",
        ".zip"  => "application/zip",
        ".txt"  => "text/plain",
        ".json" => "application/json"
      }
    
    mime_default = "application/octet-stream"
    

    def serve_static_file(path)
        if File.exist?(path) && !File.directory?(path)
          ext = File.extname(path)
          mime_type = mime_types[ext] || mime_default
          content = File.read(path) 

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
            route = @router.match_route(request)
            
            if route
                status = 200
                body = route[:block].call
                mime_type = "text/html"
            else
              static_file_path = "public#{request.path}" 
              status, mime_type, body = serve_static_file(static_file_path)
            end
            
            response = Response.new(status, body)

            
            session.print response.print_data
        end
    end
end

server = HTTPServer.new(4567)
server.start
