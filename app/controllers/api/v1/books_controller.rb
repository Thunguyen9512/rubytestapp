module Api
    module V1 
        class BooksController < ApplicationController
            def index
                books = Book.paginate(:page => params[:page], :per_page => params[:per_page]).order('created_at desc')
                render json: {status: 'SUCCESS', message: 'load book', data: books}, status: :ok
            end
            def show
                book = Book.find(params[:id])
                render json: {status: 'SUCCESS', message: 'Show book', data: book}, status: :ok
            end

            def create 
                book = Book.new(book_params)
                if book.save
                    render json: {status: 'SUCCESS', message: 'create book', data: book}, status: :ok
                else 
                    render json: {status: 'FAIL', message: 'creata book', data: book.errors}, status: :unprocessable_entity
                end
            end

            def destroy
                book =  Book.find(params[:id])
                if book.destroy
                    render json: {status: 'SUCCESS', message: 'Delete book', data: book}, status: :ok
                else 
                    render json: {status: 'FAIL', message: 'Delete book'}, status: :unprocessable_entity
                end

            end

            def update
                book = Book.find(params[:id])
                if book.update(book_params)
                    render json: {status: 'SUCCESS', message: 'Update book', data: book}, status: :ok
                else 
                    render json: {status: 'FAIL', message: 'Update book', data: book.errors}, status: :unprocessable_entity
                end
            end

            private 

            def book_params
                params.permit(:name, :category_id, :author_id, :public_year, :quantity, :pulisher_id)
            end
        end
    end
end
