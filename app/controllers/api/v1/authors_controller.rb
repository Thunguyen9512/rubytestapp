module Api
    module V1 
        class AuthorsController < ApplicationController
            before_action :authenticate_user

            def index
                authors = Author.paginate(:page => params[:page], :per_page => params[:per_page]).order('created_at desc')
                authorize authors
                pagination = { page: params[:page] || 1 , per_page: params[:per_page] || 20, total_pages: authors.total_pages, total_count: authors.total_entries }
                render json: {status: 'SUCCESS', message: 'Load authors', data: authors, pagination: pagination}, status: :ok
            rescue Pundit::NotAuthorizedError
                render json: {status: 'FAIL', message: 'Do not have permission'}, status: :unprocessable_entity
            end
            def show
                author = Author.find_by(id: params[:id])
                authorize author
                render json: {status: 'SUCCESS', message: 'Show author', data: author}, status: :ok
            rescue Pundit::NotAuthorizedError
                render json: {status: 'FAIL', message: 'Do not have permission'}, status: :unprocessable_entity
            end
            def create 
                author = Author.new(author_params)
                authorize author
                if author.save
                    render json: {status: 'SUCCESS', message: 'Create author', data: author}, status: :ok
                else 
                    render json: {status: 'FAIL', message: 'Creata author', data: author}, status: :unprocessable_entity
                end
            rescue Pundit::NotAuthorizedError
                render json: {status: 'FAIL', message: 'Do not have permission'}, status: :unprocessable_entity
            end
            def destroy
                author = Author.find_by(id: params[:id])
                authorize author
                if !author
                    render json: {status: 'FAIL', message: 'Delete author'}, status: :unprocessable_entity
                    return
                end
                if author.destroy
                    render json: {status: 'SUCCESS', message: 'Delete author', data: author}, status: :ok
                else 
                    render json: {status: 'FAIL', message: 'Delete author', data: author.errors}, status: :unprocessable_entity
                end
            rescue Pundit::NotAuthorizedError
                render json: {status: 'FAIL', message: 'Do not have permission'}, status: :unprocessable_entity
            end

            def update
                author = Author.find_by(id: params[:id])
                authorize author
                if !author 
                    render json: {status: 'FAIL', message: 'Update author'}, status: :unprocessable_entity
                    return
                end
                if author.update(author_params)
                    render json: {status: 'SUCCESS', message: 'Update author', data: author}, status: :ok
                else 
                    render json: {status: 'FAIL', message: 'Update author'}, status: :unprocessable_entity
                end
            rescue Pundit::NotAuthorizedError
                render json: {status: 'FAIL', message: 'Do not have permission'}, status: :unprocessable_entity
            end
            private 

            def author_params
                params.permit(:name, :note)
            end
        end
    end
end
