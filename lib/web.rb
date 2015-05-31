module FyberOffers
  class Web
    def call(env)
      @env = env

      request_valid? ? success : error
    end

    private

    attr_reader :env

    def request_valid?
      get_request? && root_path?
    end

    def get_request?
      env["REQUEST_METHOD"] == "GET"
    end

    def root_path?
      env["PATH_INFO"] == "/"
    end

    def success
      [
        200,
        { "Content-Type" => content_type },
        [ "Fyber Offers" ]
      ]
    end

    def error
      [
        404,
        { "Content-Type" => content_type },
        [ "" ]
      ]
    end

    def content_type
      "text/html;charset=utf-8"
    end
  end
end
