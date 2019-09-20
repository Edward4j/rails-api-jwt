module V1
  class Items < Root
    version 'v1'
    format :json
    prefix :api

    helpers do
      def current_user
        @current_user = AuthorizeApiRequest.call(request.headers).result
      end

      def authenticate!
        error!('401 Unauthorized', 401) unless current_user
      end
    end

    @@items = []

    namespace :items do
      desc 'Get all items',
           is_array: true,
           http_codes: [
             { code: 200, message: 'get all Items', model: Entities::Item },
             { code: 422, message: 'ItemsOutError' }
           ]
      get do
        authenticate!
        # byebug
        # present :items, Item.all, with: Entities::Item
        # present :items, @@items, with: Entities::Item
        # present :items, with: Entities::Item
        # present :items, with: { id: 1, name: "Test Item" }
        { id: 1, name: "Test Item" }
      end

      #
      desc 'Return an item.',
           http_codes: [
             { code: 200, message: 'get an item' },
             { code: 422, message: 'ItemsOutError' }
           ]
      params do
        requires :id, type: Integer, desc: 'Item id.'
      end
      get ':id' do
        authenticate!
        error!(code: 422, message: 'ItemsOutError') unless @@items[params[:id] - 1]

        present @@items[params[:id] - 1], with: Entities::Item
      end
    end
  end
end
