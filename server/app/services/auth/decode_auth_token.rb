class DecodeAuthToken
  include Interactor

  ## Find user service object
  # @param auth_token
  # @return id
  def call
    token = context.auth_token
    token_hash = JsonWebToken.decode(token)
    context.fail!(message: "Invalid token") unless token_hash
    context.fail!(message: "Invalid token format") unless token_hash[:user_id]
    context.id = token_hash[:user_id]
  end
end
