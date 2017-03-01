class TagsController < ApplicationController
    use ActionDispatch::Session::CookieStore
    
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
        if !current_user
            render json: {'msg': "please login", 'status': false}
            return
        end
        if !params[:id] || !params[:tag]
            render json: {'msg': "invalid params", 'status': false}
            return
        end
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
                @taggerUser = self.tagger(@newTagUser.id, params[:id], current_user.id)
                if @newTagUser
                    # 他人にタグを追加
                    if @taggerUser != -1 && @taggerUser != 0
                        render json: {'msg': "success to add tag", 'status': true}
                    # 自分にタグを追加
                    elsif @taggerUser == 0
                        render json: {'msg': "success to add tag", 'status': true}
                    else 
                        render json: {'msg': "failed to add tag. already exist", 'status': false}
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
            
            @taggerUser = self.tagger(@newTagUser.id, params[:id], current_user.id)

            if @newTag && @newTagUser
                # 他人にタグを追加
                if @taggerUser != -1 && @taggerUser != 0
                    render json: {'msg': "success to add tag", 'status': true}
                # 自分にタグを追加
                elsif @taggerUser == 0
                    render json: {'msg': "can't add tag in yourself", 'status': false}
                else 
                    render json: {'msg': "failed to add tag. already exist", 'status': false}
                end
            else
                render json: {'msg': "failed to add tag", 'status': false}
            end
        end
    end
 
    # タグを追加した人をtagger_userに追加する
    # @return TaggUser|-1|0 タグ追加した情報|すでにタグを+1した情報が追加されていた|自身にタグ付けしようとしていた
    def tagger(tagid, userid, add_userid)
        # 他のユーザが追加したのであれば、タグを追加した人として記録
        if(userid != add_userid)
            # ユーザに対して追加したユーザのペアがあれば追加しない
            if !TaggerUser.find_by({tag_user_id: tagid, user_id: add_userid})
                return TaggerUser.create({tag_user_id: tagid, user_id: add_userid})
            else
                return -1
            end
        end
        return 0
    end

    # 指定のタグにユーザが+1する際に呼ばれる
    def update
        if !current_user
            render json: {'msg': "please login", 'status': false}
        end
        if !params[:id] || !params[:user_id]
            render json: {'msg': "invalid params", 'status': false}
        end
        @tagid = Tag.find_by(tag: params[:id])
        @tagUser = TagUser.find_by(user_id: params[:user_id], tag_id: @tagid.id)
        @taggerUser = self.tagger(@tagUser.id, params[:user_id], current_user.id)
        # 他人にタグを追加
        if @taggerUser != -1 && @taggerUser != 0
            render json: {'msg': "success to add tag", 'status': true}
        # 自分にタグを追加
        elsif @taggerUser == 0
            render json: {'msg': "can't add tag in yourself", 'status': false}
        else 
            render json: {'msg': "failed to add tag. already exist", 'status': false}
        end
    end

    def destroy

    end
end
