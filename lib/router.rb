class Router

    def initialize
        @routes = {}
    
    end

    def add_route(method, path, &block)
        @routes[[method, path]] = block

    end

    def match_route(request)

        @routes.each_key do |element|
            element[0] == [request.method, request.resource] ? "hey" : "ney"
        end 

    end

end