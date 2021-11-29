module Api
    module V1 
        class CategoriesController < ApplicationController
            def index
                categories = Category.paginate(:page => params[:page], :per_page => params[:per_page]).order('created_at desc')
                pagination = { page: params[:page] || 1 , per_page: params[:per_page] || 20, total_pages: categories.total_pages, total_count: categories.total_entries }
                render json: {status: 'SUCCESS', message: 'Load categories', data: categories, pagination: pagination}, status: :ok
            end
            def show
                category = Category.find_by(id: params[:id])
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
                category = Category.find_by(id: params[:id])
                if !category 
                    render json: {status: 'FAIL', message: 'Delete category'}, status: :unprocessable_entity
                    return
                end
                if category.destroy
                    render json: {status: 'SUCCESS', message: 'Delete category', data: category}, status: :ok
                else 
                    render json: {status: 'FAIL', message: 'Delete category', data: category.errors}, status: :unprocessable_entity
                end
            end

            def update
                category = Category.find_by(id: params[:id])
                if !category 
                    render json: {status: 'FAIL', message: 'Update category'}, status: :unprocessable_entity
                    return
                end               
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
