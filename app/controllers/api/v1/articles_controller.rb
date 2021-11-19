module Api
    module V1 
        class ArticlesController < ApplicationController
            def index
                articles = Article.all
                render json: {status: 'SUCCESS', message: 'load article', data: articles}, status: :ok
                # render json: @articles
            end

            def show
                articles = Article.find(params[:id])
                render json: {status: 'SUCCESS', message: 'load article', data: articles}, status: :ok
            end

            def create 
                article = Article.new(article_params)
                if article.save
                    render json: {status: 'SUCCESS', message: 'load article', data: article}, status: :ok
                else 
                 
                   render json: {status: 'FAIL', message: 'load article'}, status: :ok
                end

            end
            private 

            def article_params
                params.permit(:title, :body)
            end

        end
    end
end
