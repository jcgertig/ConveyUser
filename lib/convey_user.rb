require "rails"
require "convey_user/require_proof"
require "convey_user/version"
require "convey_user/engine"
require "convey_user/token"
require "convey_user/user"

module ConveyUser
  ActionController::Base.send :include, ConveyUser::RequireProof
end
