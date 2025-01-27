class Router
    attr_reader :routes, :method, :path, :block

    def initialize
        @routes = []
    end

    # Add route method
    def add_route(method, path, &block)

        regexp_path = Regexp.new(path.gsub(/:([\w]+)/, '(?<\1>\w+)').prepend('^').concat('$'))


        @routes << { method: method, path: regexp_path, block: block }
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