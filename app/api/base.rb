module API
  class Base < Grape::API
    # require 'grape-entity'
    # require '../lib/grape-swagger'
    format :json

    mount API::V1::Root
    # mount API::V1::Items
    mount API::V1::Users
    mount API::V1::Tasks
    mount API::V1::SubTasks

    before do
      header['Access-Control-Allow-Origin'] = '*'
      header['Access-Control-Request-Method'] = '*'
    end

    # global exception handler, used for error notifications
    rescue_from :all do |e|
      raise e
      error_response(message: "Internal server error: #{e}", status: 500)
    end

    add_swagger_documentation hide_documentation_path: true,
                              api_version: 'v1',
                              info: {
                                  title: 'Users and Tasks',
                                  description: 'Demo api app of grape swagger 0.33'
                              }
  end
end
