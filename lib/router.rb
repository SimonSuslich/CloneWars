# class Router
#     attr_reader :routes

#     def initialize
#         @routes = []
#     end

#     # Add route method
#     def add_route(method, path, &block)

#         path_parts = path[1..-1].split('/')

#         match_data_path = ""
#         path_parts.each_with_index do |part, i|
#             str = part
#             if part.start_with?(':')
#                 str = "/(?<#{part[1..-1]}>\\w+)"
#             end
#             match_data_path << str
#         end


#         p match_data_path



#         # "/dude/:id/:name"
#         # "/dude/(?<id>\\w+)/(?<name>\\w+)"

#         path_variables_hash = {}
#         path_parts = path[1..-1].split('/')

#         path_parts.each_with_index do |part, i|
#             if part.start_with?(':')
#                 path_variables_hash[part[1..-1].to_sym] = { index: i }
#             end
#         end

#         @routes << { method: method, path: path, block: block, variables: path_variables_hash }
#     end

#     def match_route(request)
#         matched_route = @routes.find do |route|
#             route[:method] == request.method && path_matches?(route[:path], request.resource)
#         end

#         return unless matched_route

#         params = extract_path_variables(matched_route[:path], request.resource)

#         matched_route[:block].call(*params)
#     end

#     private

#     def path_matches?(route_path, request_path)
#         route_parts = route_path[1..-1].split('/')
#         request_parts = request_path[1..-1].split('/')

#         return false if route_parts.size != request_parts.size

#         route_parts.each_with_index.all? do |part, i|
#             part.start_with?(':') || part == request_parts[i]
#         end
#     end

#     def extract_path_variables(route_path, request_path)
#         route_parts = route_path[1..-1].split('/')
#         request_parts = request_path[1..-1].split('/')

#         route_parts.each_with_index.map do |part, i|
#             part.start_with?(':') ? request_parts[i] : nil
#         end.compact
#     end
# end







class Router
    attr_reader :routes, :method, :path, :block

    def initialize
        @routes = []
    end

    # Add route method
    def add_route(method, path, &block)
        path_variables_hash = {}
        path_parts = path[1..-1].split('/')

        path_parts.each_with_index do |part, i|
            if part.start_with?(':')
                path_variables_hash[part[1..-1].to_sym] = { index: i }
            end
        end




# TEMPORARY
        path_parts = path[1..-1].split('/')

        match_data_path = ""
        path_parts.each_with_index do |part, i|
            str = part
            if part.start_with?(':')
                str = "/(?<#{part[1..-1]}>\\w+)"
            end
            match_data_path << str
        end
        p match_data_path
#TEMPORARY





        @routes << { method: method, path: path, block: block, variables: path_variables_hash }
    end

    def match_route(request)
        matched_route = @routes.find do |route|
            route[:method] == request.method && path_matches?(route[:path], request.resource)
        end

        return unless matched_route

        params = extract_path_variables(matched_route[:path], request.resource)

        matched_route[:block].call(*params)
    end

    private

    def path_matches?(route_path, request_path)
        route_parts = route_path[1..-1].split('/')
        request_parts = request_path[1..-1].split('/')

        return false if route_parts.size != request_parts.size

        route_parts.each_with_index.all? do |part, i|
            part.start_with?(':') || part == request_parts[i]
        end
    end

    def extract_path_variables(route_path, request_path)
        route_parts = route_path[1..-1].split('/')
        request_parts = request_path[1..-1].split('/')

        route_parts.each_with_index.map do |part, i|
            part.start_with?(':') ? request_parts[i] : nil
        end.compact
    end
end









#OLD VERSION


# class Router

#     attr_reader :routes, :method, :path, :block


#     def initialize
#         @routes = []
    
#     end

#     def add_route(method, path, &block)
#         path_variables_hash = {}

#         path[1..-1].split('/').each_with_index do |part, i|
#             if part[0] == ':'
#                 path_variables_hash[part[1..-1].to_sym] 
#                 path_variables_hash[part[1..-1].to_sym] = {
#                     route: path,
#                     index: i,
#                     value: 0,
#                 }
#             end
#         end

#         id = path_variables_hash

#         p id

#         p path_variables_hash

#         @routes << {method: method, path: path, block: block, variables: path_variables_hash}
#     end

#     def match_route(request)

#         @routes.find do |element|
#             element[:method] == request.method && element[:path] == request.resource
#         end


#     end

# end