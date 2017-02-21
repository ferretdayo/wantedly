class UsersController < ApplicationController
    # 全ユーザの取得
    def index
        users = User.all
        render json: {'users': users, 'current_user': current_user }, callback: params[:callback]
    end

    def new

    end

    # ユーザ情報（ユーザ、タグ、タグの付属したユーザID）の取得
    def show
        @user = User.find(params[:id])
        @tagData = @user.tags.all
        
        @tagUserList = TagUser.where(user_id: @user.id)

        # ユーザについているタグのidを取得
        tagUserIds = []
        @tagUserList.each{|tagUser|
            tagUserIds.push(tagUser.id)
        }

        # 指定のユーザについているタグを追加した人の情報を取得
        taggerUsers = Hash.new { |h, k| h[k] = [] }
        @taggerInfo = TaggerUser.where(tag_user_id: tagUserIds)
        @taggerInfo.each{|tagger|
            taggerUsers[tagger.tag_user_id].push(tagger.user_id)
        }

        render json: {'msg': 'success to fetch Data', 'status': true, 'tag': @tagData, 'user': @user, 'tagCnt': taggerUsers}
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
