module ConveyUser
  module RequireProof
    extend ActiveSupport::Concern

    def require_proof(options={})
      options[:authenticatable] ||= :User
      options[:header] ||= 'Authorization'

      raw_token = request.headers[options[:header]].split(' ').last if request.headers[options[:header]]
      begin
        token = ConveyUser::Token.from_token(raw_token) if raw_token
      rescue JWT::ExpiredSignature
        render json: { errors: ['Expired Token'] }, status: :unauthorized and return
      rescue JWT::VerificationError
        render json: { errors: ['Invalid Token Signature'] }, status: :unauthorized and return
      rescue JWT::IncorrectAlgorithm
        render json: { errors: ['Token Specifies Wrong Algorithm'] }, status: :unauthorized and return
      end

      proof_class = options[:authenticatable].to_s.camelize.constantize

      @current_user ||= ConveyUser::User.from_token(token.token) if token

      render json: { errors: ['Not Authorized'] }, status: :unauthorized unless @current_user
    end

    def current_user
      @current_user if @current_user
    end

    included do
    end
  end
end