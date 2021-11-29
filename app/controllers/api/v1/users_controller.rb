module Api
    module V1 
        class UsersController < ApplicationController
            def index
                if user_params = ''
                    users = User.paginate(:page => params[:page], :per_page => params[:per_page] || 20).order('created_at desc')
                    pagination = { page: params[:page] || 1 , per_page: params[:per_page] || 20, total_pages: users.total_pages, total_count: users.total_entries }
                else
                    users = User.where(role: user_params[:role]).paginate(:page => params[:page], :per_page => params[:per_page]).order('created_at desc')
                    pagination = { page: params[:page] || 1 , per_page: params[:per_page] || 20, total_pages: users.total_pages, total_count: users.total_entries }
                end
                render json: {status: 'SUCCESS', message: 'Load user', data: users, pagination: pagination }, status: :ok
            end

            def show
                user = User.find_by(id: params[:id])
                render json: {status: 'SUCCESS', message: 'Show user', data: user}, status: :ok
            end

            def create 
                user = User.new(user_params)
                if user.save
                    render json: {status: 'SUCCESS', message: 'Create user', data: user}, status: :ok
                else 
                    render json: {status: 'FAIL', message: 'Creata user', data: user}, status: :unprocessable_entity
                end
            end

            def destroy
                user = User.find_by(id: params[:id])
                if !user
                    render json: {status: 'FAIL', message: 'Delete user'}, status: :unprocessable_entity
                    return
                end
                if user.destroy
                    render json: {status: 'SUCCESS', message: 'Delete user', data: user}, status: :ok
                else 
                    render json: {status: 'FAIL', message: 'Delete user', data: user.errors}, status: :unprocessable_entity
                end
            end

            def update
                user = User.find_by(id: params[:id])
                if !user
                    render json: {status: 'FAIL', message: 'Update user'}, status: :unprocessable_entity
                    return
                end                
                if user.update(user_params)
                    render json: {status: 'SUCCESS', message: 'Update user', data: user}, status: :ok
                else 
                    render json: {status: 'FAIL', message: 'Update user'}, status: :unprocessable_entity
                end
            end

            private 
            def user_params
                params.permit(:name, :user_name, :password, :date_of_birth, :role, :phone_number, :address, :join_date)
            end
        end
    end
end
