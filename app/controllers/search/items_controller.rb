module Search
  class ItemsController < parent_controller
    def index
      @search_query.sorts = 'datetime desc'
      @items = @search_query.result.paginate(
        page: params[:page],
        per_page: 10,
      )
    end

    def in_json
      index
    end
  end
end
