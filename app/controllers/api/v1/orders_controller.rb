module Api
    module V1 
        class OrdersController < ApplicationController
            def index
                orders = Order.paginate(:page => params[:page], :per_page => params[:per_page]).order('created_at desc')
                render json: {status: 'SUCCESS', message: 'Load order', data: orders}, status: :ok
            end
            def show
                order = Order.find(params[:id])
                order_books = order.order_books                
                render json: {status: 'SUCCESS', message: 'Show order', data: order}, status: :ok
            end
            def create 
                order = Order.new(order_params)
                if order.save
                    isSuccess = true
                    order_books_params[:book_list].each do |item|
                        order_book = order.order_books.build(item)
                        if !order_book.save
                            isSuccess = false
                            #Lou Not necessary. You need research about dependent params in rails model
                            order.order_books.destroy_all
                            order.destroy
                            #Lou  Why not use return ?
                            render json: {status: 'FAIL', message: 'Creata order book', data: order_book.errors}, status: :unprocessable_entity
                            break
                        else
                        
                        end
                    end 
                    #Lou It don't use isSuccess var
                    if isSuccess
                        render json: {status: 'SUCCESS', message: 'Create order book', data: order.order_books}, status: :ok
                    end
                else
                  #Lou Order don't save. Why use destroy method?
                    order.destroy
                    render json: {status: 'FAIL', message: 'Creata order', data: order.errors}, status: :unprocessable_entity
                end
            end

            def destroy
                order =  Order.find(params[:id])
                if order.destroy && order.order_books.destroy_all
                    render json: {status: 'SUCCESS', message: 'Delete order', data: order}, status: :ok
                else 
                    render json: {status: 'FAIL', message: 'Delete order'}, status: :unprocessable_entity
                end
            end

            def update
                order = Order.find(params[:id])
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
                params.permit(:reader_id, :staff_id, :expire_date)
            end
        end
    end
end
