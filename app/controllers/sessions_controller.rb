class SessionsController < Devise::SessionsController
    def create
      service = UserLoginService.new(params[:user][:email], params[:user][:password])
      result = service.call
  
      if result[:success]
        render json: { token: result[:token] }, status: :ok
      else
        render json: { errors: result[:errors] }, status: :unauthorized
      end
    end
end