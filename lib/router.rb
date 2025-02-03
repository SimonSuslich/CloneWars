# The Router class is responsible for managing and matching routes.
class Router
    # @return [Array<Hash>] List of defined routes.
    attr_reader :routes
  
    # Initializes a new Router instance.
    def initialize
      @routes = []
    end
  
    # Adds a new route to the router.
    #
    # @param [Symbol] method The HTTP method (e.g., :get, :post).
    # @param [String] path The route path, which may include dynamic segments (e.g., "/users/:id").
    # @param [Proc] block The block to execute when the route is matched.
    #
    # @return [void]
    def add_route(method, path, block)
      regexp_path = Regexp.new(path.gsub(/:([\w]+)/, '(?<\1>\w+)').prepend('^').concat('$'))
      @routes << { method: method, path: regexp_path, block: block }
    end
  
    # Defines shorthand methods for HTTP verbs.
    #
    # @param [String] path The route path.
    # @param [Proc] block The block to execute when the route is matched.
    #
    # @return [void]
    def get(path, &block); add_route(:get, path, block); end
    def post(path, &block); add_route(:post, path, block); end
    def put(path, &block); add_route(:put, path, block); end
    def patch(path, &block); add_route(:patch, path, block); end
    def delete(path, &block); add_route(:delete, path, block); end
    def head(path, &block); add_route(:head, path, block); end
    def options(path, &block); add_route(:options, path, block); end
    def connect(path, &block); add_route(:connect, path, block); end
    def trace(path, &block); add_route(:trace, path, block); end
  
    # Matches a request to a defined route and executes the corresponding block.
    #
    # @param [Object] request The request object, expected to have `method` and `resource` attributes.
    #
    # @return [Object, nil] The result of the executed block, or nil if no route matches.
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
  