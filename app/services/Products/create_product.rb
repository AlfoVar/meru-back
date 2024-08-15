module Products
    class CreateProduct
        def initialize(params)
          @params = params
        end
        
        def call
            return { success: false, error: 'Invalid parameters' } unless valid_params?
      
            product = Product.new(@params)
            if product.save
              { success: true, product: product }
            else
              { success: false, error: product.errors.full_messages.join(', ') }
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
            @params[:price].is_a?(Float) && @params[:price].present?
        end
    end
end
            