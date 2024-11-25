class Response

    attr_reader :status, :body

    def initialize(status, body)
        @status = status
        @body = body
    end

    def print_data
        "HTTP/1.1 #{@status}\r\n" \
            "Content-Type: text/html\r\n" \
            "Content-Length: #{@body.length}\r\n"\
            "\r\n #{@body}" 
    end


end