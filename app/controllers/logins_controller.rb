class LoginsController < ApplicationController
    def index
        
    end

    def new

    end

    def show

    end

    def edit

    end

    # ログイン
    def create
        user = User.find_by(email: params[:email])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            render :json => {'msg': 'success login', 'status': true}
        else
            render :json => {'msg': 'failed login', 'status': false}
        end
    end

    def update

    end

    # ログアウト
    def destroy
        session[:user_id] = nil
        @current_user = nil
        render :json => {'msg': 'success logout', 'status': true}
    end
end
