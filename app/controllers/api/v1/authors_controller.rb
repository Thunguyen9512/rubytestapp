module Api
    module V1 
        class AuthorsController < ApplicationController
            def index
                authors = Author.paginate(:page => params[:page], :per_page => params[:per_page]).order('created_at desc')
                render json: {status: 'SUCCESS', message: 'Load authors', data: authors}, status: :ok
            end
            def show
                author = Author.find(params[:id])
                render json: {status: 'SUCCESS', message: 'Show author', data: author}, status: :ok
            end
            def create 
                author = Author.new(author_params)
                if author.save
                    render json: {status: 'SUCCESS', message: 'Create author', data: author}, status: :ok
                else 
                    render json: {status: 'FAIL', message: 'Creata author', data: author}, status: :unprocessable_entity
                end
            end
            def destroy
                author =  Author.find(params[:id])
                if author.destroy
                    render json: {status: 'SUCCESS', message: 'Delete author', data: author}, status: :ok
                else 
                    render json: {status: 'FAIL', message: 'Delete author', data: author.errors}, status: :unprocessable_entity
                end
            end

            def update
                author = Author.find(params[:id])
                if author.update(author_params)
                    render json: {status: 'SUCCESS', message: 'Update author', data: author}, status: :ok
                else 
                    render json: {status: 'FAIL', message: 'Update author'}, status: :unprocessable_entity
                end
            end

            private 

            def author_params
                params.permit(:name, :note)
            end
        end
    end
end
