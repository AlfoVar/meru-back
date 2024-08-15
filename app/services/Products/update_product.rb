module Products
    class UpdateProduct
        def initialize(product, params)
          @product = product
          @params = params
        end
      
        def call
          return { success: false, errors: 'Parametros invalidos' } unless valid_params?
      
          if @product.update(@params)
            { success: true, product: @product }
          else
            { success: false, errors: @product.errors.full_messages }
          end
        end
      
        private
      
        def valid_params?
          valid_name? && valid_description? && valid_price?
        end
      
        def valid_name?
          @params[:name].is_a?(String) && @params[:name].present?
        end
      
        def valid_description?
          @params[:description].is_a?(String) && @params[:description].present?
        end
      
        def valid_price?
          @params[:price].is_a?(Numeric) && @params[:price].present?
        end
      end
end

