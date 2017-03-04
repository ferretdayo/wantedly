class UsersController < ApplicationController
    # 全ユーザの取得
    def index
        if !current_user
            render json: {'msg': "please login", 'status': false}
            return
        end
        @users = User.where.not(id: current_user.id).select(:name, :id)
        render json: {'users': @users, 'current_user': current_user, 'status': true}
        return
    end

    # ユーザ情報（ユーザ、タグ、タグの付属したユーザID）の取得
    def show
        if !current_user
            render json: {'msg': "please login", 'status': false}
            return
        end
        if !params[:id]
            render json: {'msg': "invalid params", 'status': false}
            return
        end
        @user = User.find(params[:id])
        # 指定されたユーザの持つタグ全て
        @tags = @user.tags.all
        # 指定されたユーザとタグの中間情報
        @middleTagUser = @user.tag_users

        taggedUser = Hash.new { |h, k| h[k] = [] }
        # タグとユーザの関連付け
        @middleTagUser.each do |middle|
            # タグに+1したユーザの情報(array)
            @tagged_user = middle.users.select(:name, :id)
            # 指定のタグに+1したユーザの情報を格納
            @tags.each do |tag|
                # タグが一致した時
                if middle.tag_id == tag.id
                    taggedUser[tag.tag] = @tagged_user
                end
            end
        end
        render json: {'msg': 'success to fetch Data', 'status': true, 'user': @user, 'taggedUser': taggedUser}
        return
    end

    # ユーザの作成
    def create 
        @user = User.new({name: params[:name], email: params[:email], password: params[:password]})
        if @user.save
            render json: {"msg": "create user", "status": true}
            return
        else
            render json: {"msg": "error", "status": false}
            return
        end
    end
end
