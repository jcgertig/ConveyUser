module ConveyUser
  class User

    def initialize(auth_hash)
      @pure_data = auth_hash
      @user = find_or_create_by(auth_hash)
      @token = ConveyUser::Token.from_data({ pure_data: auth_hash, user_id: @user.id }, false)
    end

    def self.from_token(token)
      user_token = ConveyUser::Token.from_token(token)
      new(user_token.data[:pure_data])
    end

    def id
      @user.id
    end

    def uid
      @pure_data["uid"] || @pure_data.uid
    end

    def info
      @pure_data["info"] || @pure_data.info
    end

    def token
      @token.token
    end

    def credentials
      @pure_data["credentials"] || @pure_data.credentials
    end

    def to_json
      { uid: self.uid, id: self.id, info: self.info, token: self.token }
    end

    def find_or_create_by(auth_hash)
      ::User.where(uid: self.uid).first_or_create(self.info)
    end

  end
end
