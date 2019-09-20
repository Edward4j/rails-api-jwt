module V1
  class Root < Grape::API

    before do
      header['Access-Control-Allow-Origin'] = '*'
      header['Access-Control-Request-Method'] = '*'
    end

    helpers do
      def current_user
        @current_user = AuthorizeApiRequest.call(request.headers).result
      end

      def authenticate!
        error!('401 Unauthorized', 401) unless current_user
      end
    end

    format :json
    # mount Entities::Item
    mount V1::Items
    # mount V1::Item
    # mount Api::V1::Users
    # mount Api::V1::Tasks
    # mount Api::V1::Subtasks
    add_swagger_documentation \
      add_version: true,
      doc_version: 'v1',
      host: 'localhost:3000',
      path: lambda { |request| request.host =~ /^example/ ? '/api-example' : '/api' },
      # models: [
      #     Item,
      #     # Entities::Item,
      #     # Entities::ApiError
      # ],
      info: {
        title: "The Rails 5 API JWT",
        description: "The Rails 5 API Test app with JWT authentication.",
        contact_name: "Eduard Dovgal",
        contact_email: "Contact@email.com",
        contact_url: "Contact URL",
        license: "The name of the license, usually - MIT.",
        license_url: "www.The-URL-of-the-license.org",
        terms_of_service_url: "www.The-URL-of-the-terms-and-service.com",
    }

  #   desc 'API::V1 Root'
  #   get do
  #     {
  #       users_url: '/users',
  #       tasks_url: '/tasks'
  #     }
  #   end
  end
end
