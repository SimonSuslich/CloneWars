# The MimeType class determines the MIME type for a given file extension.
class MimeType
  # @return [Hash] A mapping of file extensions to MIME types.
  # @return [String] The default MIME type if no match is found.
  # @return [String] The file extension to look up.
  attr_reader :mime_types, :mime_default, :ext

  # Initializes a new MimeType instance.
  #
  # @param [String] ext The file extension (e.g., ".html", ".json").
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

  # Retrieves the MIME type for the given file extension.
  #
  # @return [String, nil] The corresponding MIME type or nil if not found.
  def get_ext
    @mime_types[@ext]
  end
end
