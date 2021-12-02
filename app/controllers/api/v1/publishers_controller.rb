module Api
    module V1 
        class PublishersController < ApplicationController
            before_action :authenticate_user

            def index
                publishers = Publisher.paginate(:page => params[:page], :per_page => params[:per_page]).order('created_at desc')
                authorize publishers
                pagination = { page: params[:page] || 1 , per_page: params[:per_page] || 20, total_pages: publishers.total_pages, total_count: publishers.total_entries }
                render json: {status: 'SUCCESS', message: 'Load puplishers', data: publishers, pagination: pagination}, status: :ok
            rescue Pundit::NotAuthorizedError
                render json: {status: 'FAIL', message: 'Do not have permission'}, status: :unprocessable_entity
            end
            def show
                publisher = Publisher.find_by(id: params[:id])
                authorize publisher
                render json: {status: 'SUCCESS', message: 'Show book by publisher', data: publisher}, status: :ok
            rescue Pundit::NotAuthorizedError
                render json: {status: 'FAIL', message: 'Do not have permission'}, status: :unprocessable_entity
            end

            def create 
                publisher = Publisher.new(publisher_params)
                authorize publisher
                if publisher.save
                    render json: {status: 'SUCCESS', message: 'Create publisher', data: publisher}, status: :ok
                else 
                    render json: {status: 'FAIL', message: 'Creata publisher', data: publisher}, status: :unprocessable_entity
                end
            rescue Pundit::NotAuthorizedError
                render json: {status: 'FAIL', message: 'Do not have permission'}, status: :unprocessable_entity
            end

            def destroy
                publisher = Publisher.find_by(id: params[:id])
                authorize publisher
                if !publisher
                    render json: {status: 'FAIL', message: 'Delete publisher'}, status: :unprocessable_entity
                    return
                end
                if publisher.destroy
                    render json: {status: 'SUCCESS', message: 'Delete publisher', data: publisher}, status: :ok
                else 
                    render json: {status: 'FAIL', message: 'Delete publisher', data:publisher.errors}, status: :unprocessable_entity
                end
            rescue Pundit::NotAuthorizedError
                render json: {status: 'FAIL', message: 'Do not have permission'}, status: :unprocessable_entity
            end

            def update
                publisher = Publisher.find_by(id: params[:id])
                authorize publisher
                if !publisher
                    render json: {status: 'FAIL', message: 'Update publisher'}, status: :unprocessable_entity
                    return
                end                
                if publisher.update(publisher_params)
                    render json: {status: 'SUCCESS', message: 'Update publisher', data: publisher}, status: :ok
                else 
                    render json: {status: 'FAIL', message: 'Update publisher'}, status: :unprocessable_entity
                end
            rescue Pundit::NotAuthorizedError
                render json: {status: 'FAIL', message: 'Do not have permission'}, status: :unprocessable_entity
            end

            private 

            def publisher_params
                params.permit(:name, :address, :email, :phone_number)
            end
        end
    end
end
