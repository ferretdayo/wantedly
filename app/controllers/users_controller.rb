class UsersController < ApplicationController
    # 全ユーザの取得
    def index
        @users = User.all
        render json: {'users': @users, 'current_user': current_user }, callback: params[:callback]
    end

    def new

    end

    def show
        @user = User.find(params[:id])
    end

    def edit

    end

    # ユーザの作成
    def create 
        @user = User.new({name: params[:name], email: params[:email], password: params[:password]})
        if @user.save
            render json: {"msg": "create user", "status": true}, callback: params[:callback]
        else
            render json: {"msg": "error", "status": false}, callback: params[:callback]
        end
    end

    def update

    end

    def destroy

    end
end
