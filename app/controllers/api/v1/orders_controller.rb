module Api
    module V1 
        class OrdersController < ApplicationController
            before_action :authenticate_user

            def index
                # orders = Order.paginate(:page => params[:page], :per_page => params[:per_page]).order('created_at desc')
                orders = Order.includes(:order_books).paginate(:page => params[:page], :per_page => params[:per_page]).order('created_at desc')
                authorize orders
                record = orders.map do |order|
                    books = order.order_books.map do |order_book|
                        {
                            title: order_book.book.name,
                            quantity: order_book.quantity,
                            book_id: order_book.book.id,
                        }
                    end
                    {
                        data: order,
                        books: books,
                    }
                end
                pagination = { page: params[:page] || 1 , per_page: params[:per_page] || 20, total_pages: orders.total_pages, total_count: orders.total_entries }   
                render json: {status: 'SUCCESS', message: 'Load order', data: record, pagination: pagination}, status: :ok
            rescue Pundit::NotAuthorizedError
                render json: {status: 'FAIL', message: 'Do not have permission'}, status: :unprocessable_entity
            end
            def show
                order = Order.find_by(id: params[:id])
                authorize order

                books = order.order_books.map do |order_book|
                    {
                        title: order_book.book.name,
                        quantity: order_book.quantity,
                        book_id: order_book.book.id,
                    }
                end

                record = {
                    data: order,
                    books: books,
                }
                
                render json: {status: 'SUCCESS', message: 'Show order', data: record}, status: :ok
            rescue Pundit::NotAuthorizedError
                render json: {status: 'FAIL', message: 'Do not have permission'}, status: :unprocessable_entity
            end
            def create
                reader = User.find_by id: params[:reader_id], role: "reader"
                staff = User.find_by id: params[:staff_id], role: "staff"
                if reader && staff
                    order = Order.new(order_params)
                    authorize order
                    if order.save
                        order_books_params[:book_list].each do |item|
                            order_book = order.order_books.build(item)
                            if !order_book.save
                                #Lou Not necessary. You need research about dependent params in rails model
                                #order.order_books.destroy_all
                                #fixed
                                order.destroy
                                render json: {status: 'FAIL', message: 'Create order book', data: order_book.errors}, status: :unprocessable_entity
                                return;
                            else
                            end
                        end 
                        #Lou It don't use isSuccess var
                        render json: {status: 'SUCCESS', message: 'Create order book', data: order.order_books}, status: :ok
                    else
                    #Lou Order don't save. Why use destroy method?
                        # order.destroy
                        render json: {status: 'FAIL', message: 'Create order', data: order.errors}, status: :unprocessable_entity
                    end
                else 
                    render json: {status: 'FAIL', message: 'No staff or reader'}, status: :unprocessable_entity
                end

            end

            def destroy
                order = Order.find_by(id: params[:id])
                authorize order
                if !order 
                    render json: {status: 'FAIL', message: 'Delete order'}, status: :unprocessable_entity
                    return
                end                
                if order.destroy
                    render json: {status: 'SUCCESS', message: 'Delete order', data: order}, status: :ok
                else 
                    render json: {status: 'FAIL', message: 'Delete order', data: order.errors}, status: :unprocessable_entity
                end
            rescue Pundit::NotAuthorizedError
                render json: {status: 'FAIL', message: 'Do not have permission'}, status: :unprocessable_entity
            end

            def update
                order = Order.find_by(id: params[:id])
                authorize order
                if !order 
                    render json: {status: 'FAIL', message: 'Update order'}, status: :unprocessable_entity
                    return
                end
                if order.update(order_params)
                    render json: {status: 'SUCCESS', message: 'Update order', data: order}, status: :ok
                else 
                    render json: {status: 'FAIL', message: 'Update order'}, status: :unprocessable_entity
                end
            rescue Pundit::NotAuthorizedError
                render json: {status: 'FAIL', message: 'Do not have permission'}, status: :unprocessable_entity
            end

            private 
            #Lou Is it necessary to create method? Try merge it with order_params method.
            def order_books_params
                params.permit(:book_list => [:book_id,  :quantity])
            end
            def order_params
                params.permit(:reader_id, :staff_id, :expire_date)
            end
        end
    end
end
