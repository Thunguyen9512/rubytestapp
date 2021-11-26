module Api
    module V1 
        class CategoriesController < ApplicationController
            def index
                categories = Category.paginate(:page => params[:page], :per_page => params[:per_page]).order('created_at desc')
                render json: {status: 'SUCCESS', message: 'Load categories', data: categories}, status: :ok
            end
            def show
                category = Category.find(params[:id])
                render json: {status: 'SUCCESS', message: 'Show category', data: category}, status: :ok
            end

            def create 
                category = Category.new(category_params)
                if category.save
                    render json: {status: 'SUCCESS', message: 'Create category', data: category}, status: :ok
                else 
                    render json: {status: 'FAIL', message: 'Creata category', data: category}, status: :unprocessable_entity
                end
            end

            def destroy
                category = Category.find(params[:id])
                if category.destroy
                    render json: {status: 'SUCCESS', message: 'Delete category', data: category}, status: :ok
                else 
                    render json: {status: 'FAIL', message: 'Delete category'}, status: :unprocessable_entity
                end
            end

            def update
                category = Category.find(params[:id])
                if category.update(category_params)
                    render json: {status: 'SUCCESS', message: 'Update category', data: category}, status: :ok
                else 
                    render json: {status: 'FAIL', message: 'Update category'}, status: :unprocessable_entity
                end
            end

            private 

            def category_params
                params.permit(:name)
            end
        end
    end
end
