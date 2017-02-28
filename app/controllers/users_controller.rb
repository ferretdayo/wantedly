class UsersController < ApplicationController
    use ActionDispatch::Session::CookieStore
    # 全ユーザの取得
    def index
        if !current_user
            render json: {'msg': "please login", 'status': false}
            return
        end
        users = User.where.not(id: current_user.id).select(:name, :id)
        render json: {'users': users, 'current_user': current_user, 'status': true}, callback: params[:callback]
    end

    def new

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
        @tagData = @user.tags.all
        # 指定されたユーザとタグの中間情報
        @middleTagUser = @user.tag_users

        taggedUser = Hash.new { |h, k| h[k] = [] }
        # タグとユーザの関連付け
        @middleTagUser.each do |middle|
            # タグにプラスしたユーザの情報(array)
            # TODO: どうにかして一気に取れないものか
            @tagged_user = middle.users.select(:name, :id)
            # 指定のタグにプラスしたユーザの情報を格納
            @tagData.each do |tag|
                # タグが一致した時
                if middle.tag_id == tag.id
                    taggedUser[tag.tag] = @tagged_user
                end
            end
        end

        render json: {'msg': 'success to fetch Data', 'status': true, 'user': @user, 'taggedUser': taggedUser}
    end

    def edit

    end

    # ユーザの作成
    def create 
        user = User.new({name: params[:name], email: params[:email], password: params[:password]})
        if user.save
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
