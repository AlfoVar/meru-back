class RegistrationsController < Devise::RegistrationsController
    def create
        service = UserRegistrationService.new(sign_up_params)
        result = service.call

        if result[:success]
        render json: { user: result[:user] }, status: :created
        else
        render json: { errors: result[:errors] }, status: :unprocessable_entity
        end
    end
end