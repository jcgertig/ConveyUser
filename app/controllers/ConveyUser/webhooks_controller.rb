class WebhooksController < ApplicationController
  def catch
    action = request.headers["X-Convey-Action"] if request.headers["X-Convey-Action"]
    resource = request.headers["X-Convey-Resource"] if request.headers["X-Convey-Resource"]
    send("#{action}_#{resource}", params)
  end

  private

    def update_users(params)
      threads = params[:users].each do |user|
        Thread.new do
          ActiveRecord::Base.connection_pool.with_connection do
            uid = user[:_id]
            user.delete(:_id)
            new_user = User.where(uid: uid)
            if new_user.count > 0
              new_user.update(user)
            else
              new_user.first_or_create(user)
            end
          end
        end
      end

      threads.each(&:join)
    end

    def update_user(params)
      user = params[:user]
      uid  = user[:_id]
      user.delete(:_id)
      User.where(uid: uid).first.update(user)
    end

    def create_user(params)
      user = params[:user]
      uid  = user[:_id]
      user.delete(:_id)
      User.where(uid: uid).first_or_create(user)
    end

    def destroy_user(params)
      user = params[:user]
      uid  = user[:_id]
      user.delete(:_id)
      User.where(uid: uid).first.update(active: false)
    end
end
