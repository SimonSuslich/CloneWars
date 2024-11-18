class Router

    def initialize
        @routes = []
    
    end

    def add_route(method, path, &block)
        @routes << {method: method, path: path, block: block}

    end

    def match_route(request)

        @routes.each do |element|
            element[:method] != request.method ? "404" : nil
            element[:path] != request.resource ? "404" : nil
        end 

    end

end