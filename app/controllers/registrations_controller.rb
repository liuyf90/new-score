class RegistrationsController < Devise::RegistrationsController
    layout 'login'
    # 其他自定义逻辑
    def create
      
      super do |resource|
        if params[:user][:staff].present?
          resource.create_staff(sign_up_params[:staff])
        end
      end
    end
  
    private
    def sign_up_params
        params.require(:user).permit(
          :email, :password, :password_confirmation,
          staff_attributes: [:name, :status, :mobile])
    end
  end
  