class Response

    attr_reader :status, :body

    def initialize(status, body, mime_type)
        @status = status
        @body = body
        @mime_type = mime_type
        
    end

    def print_data
        "HTTP/1.1 #{@status}\r\n" \
            "Content-Type: #{@mime_type}\r\n" \
            "Content-Length: #{@body.length+1}\r\n"\
            "\r\n #{@body}" 
    end


end