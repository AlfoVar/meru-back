class SessionsController < Devise::SessionsController
  skip_before_action :verify_signed_out_user, only: :destroy

  def create
    service = UserLoginService.new(params[:user][:email], params[:user][:password])
    result = service.call

    if result[:success]
      user = User.find_by(email: params[:user][:email])
      render json: { token: result[:token], email: user.email }, status: :ok
    else
      render json: { errors: result[:errors] }, status: :unauthorized
    end
  end

  def destroy
    token = request.headers['Authorization']&.split(' ')&.last

    if token
      payload = JWT.decode(token, Rails.application.credentials.devise[:jwt_secret_key], true, algorithm: 'HS256').first

      user = User.find(payload['sub'])

      if user

        JwtDenylist.create!(jti: payload['jti'], exp: Time.at(payload['exp']))
        
        user.update(jti: SecureRandom.uuid)

        render json: { message: 'Logged out successfully' }, status: :ok
      else
        render json: { errors: 'User not found' }, status: :not_found
      end
    else
      render json: { errors: 'Token not provided' }, status: :bad_request
    end
  rescue JWT::DecodeError
    render json: { errors: 'Invalid token' }, status: :unauthorized
  end

  protected

  def respond_to_on_destroy
    head :no_content
  end
end