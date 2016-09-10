module Api::V1::AppDoc 
  extend ActiveSupport::Concern

  included do
    swagger_controller :app, "Overall app queries"
  end
end