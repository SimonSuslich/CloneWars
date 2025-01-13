class Mime_type
  attr_reader :mime_types, :mime_default, :ext

  def initialize(ext)
    @mime_types = {
      ".html" => "text/html",
      ".css"  => "text/css",
      ".js"   => "application/javascript",
      ".png"  => "image/png",
      ".jpg"  => "image/jpeg",
      ".jpeg" => "image/jpeg",
      ".gif"  => "image/gif",
      ".zip"  => "application/zip",
      ".txt"  => "text/plain",
      ".json" => "application/json"
    }
    
    @mime_default = "application/octet-stream"

    @ext = ext

  end

  def get_ext
    @mime_types[@ext]
  end


end