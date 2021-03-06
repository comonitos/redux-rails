class ApplicationController < ActionController::API
  include Response
  include ExceptionHandler
  include ErrorResponses

  # called before every action on controllers
  before_action :authorize_request
  attr_reader :current_user

  private

  # Check for valid request token and return user
  def authorize_request
    result = AuthorizationOrganizer.call({ headers: request.headers })
    if result.success?
      @current_user = result.user
    else
      response_unauthorized_request(result.message)
    end
  end
end