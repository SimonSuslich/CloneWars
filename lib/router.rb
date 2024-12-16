class Router

    attr_reader :routes, :method, :path, :block


    def initialize
        @routes = []
    
    end

    def add_route(method, path, &block)
        @routes << {method: method, path: path, block: block}

    end

    def match_route(request)

        @routes.find do |element|
            element[:method] == request.method && element[:path] == request.resource
        end


    end

end