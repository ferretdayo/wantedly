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
        @tag = Tag.find_by(tag: params[:tag])
        # タグがあった場合、対象のtagのidから設定
        if @tag
        else
            newTag = Tag.create({tag: params[:tag]});
        end

    end

    def update

    end

    def destroy

    end
end
