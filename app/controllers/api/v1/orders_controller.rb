module Api
    module V1 
        class OrdersController < ApplicationController
            def index
                orders = Order.paginate(:page => params[:page], :per_page => params[:per_page]).order('created_at desc')
                pagination = { page: params[:page] || 1 , per_page: params[:per_page] || 20, total_pages: orders.total_pages, total_count: orders.total_entries }   
                render json: {status: 'SUCCESS', message: 'Load order', data: orders, pagination: pagination}, status: :ok
            end
            def show
                order = Order.find_by(id: params[:id])
                render json: {status: 'SUCCESS', message: 'Show order', data: order}, status: :ok
            end
            def create
                # reader = User.where(role: "reader").find_by(params[:reader_id])
                reader = User.find_by id: params[:reader_id], role: "reader"
                staff = User.find_by id: params[:staff_id], role: "staff"
                # staff = User.where(role: "staff").find(params[:staff_id])
                if reader && staff
                    order = Order.new(order_params)
                    if order.save
                        order_books_params[:book_list].each do |item|
                            order_book = order.order_books.build(item)
                            if !order_book.save
                                #Lou Not necessary. You need research about dependent params in rails model
                                #order.order_books.destroy_all
                                #fixed
                                order.destroy
                                #Lou  Why not use return ?
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
                if !order 
                    render json: {status: 'FAIL', message: 'Delete order'}, status: :unprocessable_entity
                    return
                end                
                if order.destroy
                    render json: {status: 'SUCCESS', message: 'Delete order', data: order}, status: :ok
                else 
                    render json: {status: 'FAIL', message: 'Delete order', data: order.errors}, status: :unprocessable_entity
                end
            end

            def update
                order = Order.find_by(id: params[:id])
                if !order 
                    render json: {status: 'FAIL', message: 'Update order'}, status: :unprocessable_entity
                    return
                end
                if order.update(order_params)
                    render json: {status: 'SUCCESS', message: 'Update order', data: order}, status: :ok
                else 
                    render json: {status: 'FAIL', message: 'Update order'}, status: :unprocessable_entity
                end
            end

            private 
            #Lou Is it necessary to create method? Try merge it with order_params method.
            def order_books_params
                params.permit(:book_list => [:book_id,  :quantity])
            end
            def order_params
                # params.permit(:reader_id, :staff_id, :expire_date)
                params.permit(:reader_id, :staff_id, :expire_date)
            end
        end
    end
end
