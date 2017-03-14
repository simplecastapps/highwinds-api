require "highwinds-api/version"

module HighwindsAPI
  autoload :Content, "highwinds-api/content"
  ONE_HOUR_IN_SECONDS = 3600
  def self.credentials
    {
      username: @username,
      password: @password
    }
  end

  def self.set_credentials(username, password)
      @username = username
      @password = password
  end

  def self.set_token(api_token)
      @api_token = api_token
  end

  def self.get_token
    if @api_token
      @token = @api_token
      @token_time = Time.now
    elsif !@token_time or Time.now - @token_time > ONE_HOUR_IN_SECONDS
      @token = Content::get_token
      @token_time = Time.now
    end

    @token
  end

  # should be  used only in testing scenarios
  def self.clear_token
    @token = nil
    @token_time = nil
  end

end
