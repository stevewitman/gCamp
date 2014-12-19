module UsersHelper

  def mask_token(token)
    token[0..3] + ("*" * (token.length - 4)) unless token.nil? || token.empty?
  end

end
