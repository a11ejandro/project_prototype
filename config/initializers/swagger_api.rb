Swagger::Docs::Config.register_apis({
    "1" => {
        # the extension used for the API
        :api_extension_type => :json,
        # the output location where your .json files are written to
        :api_file_path => "public/swagger_api",
        #
        # base_api_controller: "ActionController::API",
        # the URL base path to your API
        :base_path => Rails.application.secrets.current_base_url,
        # if you want to delete all .json files at each generation
        :clean_directory => true,
        # add custom attributes to api-docs
        :attributes => {
            :info => {
                "title" => "Project_Prototype",
                "description" => "Project_Prototype",
                "termsOfServiceUrl" => "",
                "contact" => "apotrakhov@prophonix.com",
                "license" => "",
                "licenseUrl" => ""
            }
        }
    }
})

class Swagger::Docs::Config
  def self.transform_path(path, api_version)
    "swagger_api/#{path}"
  end

  def self.base_api_controller
    ActionController::API
  end
end