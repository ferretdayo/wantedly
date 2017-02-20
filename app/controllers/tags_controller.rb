class TagsController < ApplicationController
    
    def index
        render json: {'tag': Tag.all}
    end

    def new

    end
    
    def show
        
    end

    def edit

    end

    # タグの追加
    def create
        @user = User.find(params[:id])
        @tag = Tag.find_by(tag: params[:tag])
        # タグがあった場合、対象のtagのidから設定
        if @tag
            # tag_idとuser_idの組み合わせがある場合は追加しない
            @tagUser = TagUser.find_by(tag_id: @tag.id, user_id: params[:id])
            if @tagUser
                render json: {'msg': "already exist", 'status': false}
            else 
                # タグとユーザの関連の追加
                @newTagUser = TagUser.create({tag_id: @tag.id, user_id: params[:id]})
                if @newTagUser
                    render json: {'msg': "success to add tag", 'status': true}
                else
                    render json: {'msg': "failed to add tag", 'status': false}
                end
            end
        else
            # TODO transactionですべき・・・
            
            # tagがない場合は新規に作成
            @newTag = Tag.create({tag: params[:tag]});
            @newTagUser = TagUser.create({tag_id: @newTag.id, user_id: params[:id]})

            if @newTag && @newTagUser
                render json: {'msg': "success to add tag", 'status': true}
            else
                render json: {'msg': "failed to add tag", 'status': false}
            end
        end
    end

    def update

    end

    def destroy

    end
end
