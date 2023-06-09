module Api
    module V1
        class ArticlesController < ApplicationController
            def index
                @articles = Article.order("created_at": :desc)
                render json: { status: "SUCCESS",message:"Loaded articles",data:@articles},status: :ok
            end

            def show
                @articles = Article.find_by(id:params[:id])
                render json: {status:"SUCCESS",message:"Loaded article",data:@articles},status: :ok
            end

            def create
                @article = Article.new(article_params)
                    if @article.save
                        render json: {status:"SUCCESS",message:"Saved article",data:@article},status: :ok
                    else 
                        render json: {status:"ERROR",message:"Article not saved",data:@article.errors},status: :unprocessable_entity
                    end
            end
            
            def update
                @article = Article.find_by(id:params[:id])
                if @article.update(article_params)
                    render json: {status:"SUCCESS",message:"Update article",data:@article},status: :ok
                else
                    render json: {status:"Error",message:"Article not update",data:@article.errors},status: :unprocessable_entity
                end
            end
            

            def destroy
                @article = Article.find_by(id:params[:id])
                @article.destroy if @article
                render json: {status:"SUCCESS",message:"Deleted article",data:@article},status: :ok
            end

            private def article_params
                params.require(:article).permit(:title,:body)
            end

        end
    end
end