class LoginsController < ApplicationController
    # ログイン
    def create
        user = User.find_by(email: params[:email])
        if user && user.authenticate(params[:password])
            log_in user
            render :json => {'msg': 'success login', 'status': true, 'current_user': current_user }
            return
        else
            render :json => {'msg': 'failed login', 'status': false}
            return
        end
    end
    # ログアウト
    def destroy
        session[:user_id] = nil
        @current_user = nil
        render :json => {'msg': 'success logout', 'status': true}
        return
    end
end
