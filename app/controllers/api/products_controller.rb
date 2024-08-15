class Api::ProductsController < ApplicationController
    before_action :authenticate_user!, only: [:create, :update, :destroy]
    before_action :set_product, only: [:show, :update, :destroy]

    def index
        @products = Product.all
        render json: @products
    end

    def show
        render json: @product
    end

    def create 
        result = Products::CreateProduct.new(product_params).call
        
        if result[:success]
            @product = result[:product]
            render json: @product, status: :created
        else
            render json: result[:errors], status: :unprocessable_entity
        end
    end

    def update
        result = Products::UpdateProduct.new(@product, product_params).call
        
        if result[:success]
            render json: result[:product]
        else
            render json: result[:errors], status: :unprocessable_entity
        end
    end

    def destroy
        Products::DeleteProduct.new(@product).call
        head :no_content
    end

    private

    def set_product
        @product = Products::GetProduct.new(params[:id]).call
    rescue ActiveRecord::RecordNotFound
        render json: { error: 'Producto no encontrado' }, status: :not_found
    end

    def product_params
        params.require(:product).permit(:name, :description, :price)
    end
end
