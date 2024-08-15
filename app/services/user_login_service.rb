class UserLoginService
    def initialize(email, password)
        @user = User.find_by(email: email)
        @password = password
    end

    def call
        if @user&.valid_password?(@password)
          token = Warden::JWTAuth::UserEncoder.new.call(@user, :user, nil).first
          { success: true, token: token }
        else
          { success: false, errors: ['Usuario o contraseña invalidos'] }
        end
    end
end