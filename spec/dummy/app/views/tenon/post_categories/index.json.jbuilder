json.records do
  json.partial! 'post_category', collection: @post_categories, as: :post_category
end

json.partial!('tenon/shared/pagination', collection: @post_categories)