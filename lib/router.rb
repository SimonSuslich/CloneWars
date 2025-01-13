class Router

    attr_reader :routes, :method, :path, :block


    def initialize
        @routes = []
    
    end

    def add_route(method, path, &block)
        path_variables_arr = []

        path.split('/').each do |part|
            path_variables_arr << (part) if part[0] == ':'
        end

        if path_variables_arr !=  []
            @path_variables = path_variables_arr.map { |key| [key, key.to_s] }.to_h
            p @path_variables
        end

        p block

        @routes << {method: method, path: path, block: block}
    end

    def match_route(request)

        @routes.find do |element|
            element[:method] == request.method && element[:path] == request.resource
        end


    end

end