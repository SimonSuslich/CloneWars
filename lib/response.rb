class Response

    def initialize(status, body)
        @status = status
        @body = body
    end

    def idontknow
        "HTTP/1.1 #{@status}\r\n" \
            "Content-Type: text/html\r\n" \
            "\r\n" +
            @body
    end


end