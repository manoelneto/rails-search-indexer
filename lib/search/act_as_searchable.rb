module Search
  module ActAsSearchable
    extend ActiveSupport::Concern

    included do
      Search.register_model self

      has_one :search_item, as: :searchable, class_name: 'Search::Item'

      after_save :sync_search
      after_destroy :delete_search

      def sync_search
        search_item = Search::Item.where(searchable: self).first_or_create
        search_item.content = search_content
        search_item.datetime = search_datetime
        if self.respond_to? :tags
          search_item.tags = self.tags
        end
        search_item.save!
      end

      def delete_search
        Search::Item.where(searchable: self).destroy_all
      end
    end
  end
end
