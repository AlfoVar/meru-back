class Api::ProductsController < ApplicationController
    before_action :authenticate_user!, only: [:index, :show, :create, :update, :destroy]
    before_action :set_product, only: [:show, :update, :destroy]

    def index
        @products = Product.all
        render json: { message: 'Productos obtenidos exitosamente', products: @products }
    end

    def show
        @product = Product.find_by(id: params[:id])
  
        if @product
            render json: { message: 'Producto obtenido exitosamente', product: @product }
        else
            render json: { message: 'Producto no encontrado' }, status: :not_found
        end
    end

    def create 
        result = Products::CreateProduct.new(product_params).call
        
        if result[:success]
            @product = result[:product]
            render json: { message: 'Producto creado exitosamente', product: @product }, status: :created
        else
            render json: { message: 'Error al crear el producto', errors: result[:error] }, status: :unprocessable_entity
        end
    end

    def update
        result = Products::UpdateProduct.new(@product, product_params).call
        
        if result[:success]
            render json: { message: 'Se actualizo el prodcuto correctamente', product: result[:product] }
        else
            render json: { message: 'Hubo un problema al actualizar el producto', errors: result[:errors] }, status: :unprocessable_entity
        end
    end

    def destroy
        @product = Product.find_by(id: params[:id])
  
        if @product
            Products::DeleteProduct.new(@product).call
            render json: { message: 'Producto eliminado exitosamente' }, status: :ok
        else
            render json: { message: 'Producto no encontrado' }, status: :not_found
        end
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
