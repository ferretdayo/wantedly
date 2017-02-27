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
            # もう既にタグとユーザの関連があるかを確認
            @tagUser = TagUser.find_by(tag_id: @tag.id, user_id: params[:id])

            # tag_idとuser_idの組み合わせがある場合は追加しない
            if @tagUser
                render json: {'msg': "already exist", 'status': false}

            # 新たにユーザにタグを追加する場合
            else 
                # タグとユーザの関連の追加
                @newTagUser = TagUser.create({tag_id: @tag.id, user_id: params[:id]})
                @taggerUser = self.tagger(@newTagUser.id, params[:id], params[:add_userid])
                if @newTagUser
                    # 他人にタグを追加
                    if @taggerUser
                        render json: {'msg': "success to add tag", 'status': true}
                    # 自分にタグを追加
                    else 
                        render json: {'msg': "success to add self tag", 'status': true}
                    end
                else
                    render json: {'msg': "failed to add tag", 'status': false}
                end
            end
        # タグがない場合
        else
            # TODO transactionですべき・・・
            
            # tagがない場合は新規に作成
            @newTag = Tag.create({tag: params[:tag]});
            # 中間テーブルに関連を作成
            @newTagUser = TagUser.create({tag_id: @newTag.id, user_id: params[:id]})
            
            @taggerUser = self.tagger(@newTagUser.id, params[:id], params[:add_userid])

            if @newTag && @newTagUser
                if @taggerUser
                    render json: {'msg': "success to add tag", 'status': true}
                else 
                    render json: {'msg': "success to add self tag", 'status': true}
                end
            else
                render json: {'msg': "failed to add tag", 'status': false}
            end
        end
    end
 
    # タグを追加した人をtagger_userに追加する
    def tagger(tagid, userid, add_userid)
        # 他のユーザが追加したのであれば、タグを追加した人として記録
        if(userid != add_userid)
            # ユーザに対して追加したユーザのペアがあれば追加しない
            if !TaggerUser.find_by({tag_user_id: tagid, user_id: add_userid})
                return TaggerUser.create({tag_user_id: tagid, user_id: add_userid})
            end
        end
        return false
    end

    def update

    end

    def destroy

    end
end
