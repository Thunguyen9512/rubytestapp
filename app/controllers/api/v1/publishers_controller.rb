module Api
    module V1 
        class PublishersController < ApplicationController
            def index
                puplishers = Publisher.paginate(:page => params[:page], :per_page => params[:per_page]).order('created_at desc')
                render json: {status: 'SUCCESS', message: 'Load puplishers', data: puplishers}, status: :ok
            end
            def show
                publisher = Publisher.find(params[:id])
                books = publisher.books
                render json: {status: 'SUCCESS', message: 'Show book by publisher', data: books}, status: :ok
            end

            def create 
                puplisher = Publisher.new(publisher_params)
                if publisher.save
                    render json: {status: 'SUCCESS', message: 'Create publisher', data: publisher}, status: :ok
                else 
                    render json: {status: 'FAIL', message: 'Creata publisher', data: publisher}, status: :unprocessable_entity
                end
            end

            def destroy
                puplisher = Publisher.find(params[:id])
                if publisher.destroy
                    render json: {status: 'SUCCESS', message: 'Delete publisher', data: publisher}, status: :ok
                else 
                    render json: {status: 'FAIL', message: 'Delete publisher'}, status: :unprocessable_entity
                end
            end

            def update
                puplisher = Publisher.find(params[:id])
                if publisher.update(publisher_params)
                    render json: {status: 'SUCCESS', message: 'Update publisher', data: publisher}, status: :ok
                else 
                    render json: {status: 'FAIL', message: 'Update publisher'}, status: :unprocessable_entity
                end
            end

            private 

            def publisher_params
                params.permit(:name, :address, :email, :phone_number)
            end
        end
    end
end
