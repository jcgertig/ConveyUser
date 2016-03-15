module ConveyUser
  class SessionsController < ApplicationController
    def create
      token = ConveyUser::User.new(auth_hash).token
      redirect_to "/auth/success?token=#{token}"
    end

    def new
      redirect_to "/auth/convey"
    end

    protected

      def auth_hash
        request.env["omniauth.auth"]
      end
  end
end
