require 'grape-swagger'

module API
  class Root < Grape::API
    # version 'v1'
    # format :json
    # prefix :api

    before do
      header['Access-Control-Allow-Origin'] = '*'
      header['Access-Control-Request-Method'] = '*'
    end

    format :json
    mount V1::Items
    mount V1::Users
    mount V1::Tasks
    mount V1::Subtasks
    add_swagger_documentation
  end
end
