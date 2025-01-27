class Router
    attr_reader :routes, :method, :path, :block

    def initialize
        @routes = []
    end

    # Add route method
    def add_route(method, path, &block)

        path_parts = path[1..-1].split('/')

        match_data_path = "^/"
        path_parts.each_with_index do |part, i|
            str = part
            if part.start_with?(':')
                str = "/(?<#{part[1..-1]}>\\w+)"
            end
            match_data_path << str
        end
        match_data_path << "$"
        path_regexp = Regexp.new(match_data_path)


        @routes << { method: method, path: path_regexp, block: block }
    end

    #Match route using request.resource and request.method
    def match_route(request)
        matched_route = @routes.find do |route|
            route[:method] == request.method && route[:path].match?(request.resource)
        end

        return unless matched_route

        matched_path = matched_route[:path].match(request.resource)
        params = matched_path.named_captures.values

        matched_route[:block].call(*params)
    end
end