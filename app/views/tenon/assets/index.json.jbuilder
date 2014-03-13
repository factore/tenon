json.records do
  json.partial! 'asset', collection: @assets, as: :asset
end

json.partial!('tenon/shared/pagination', collection: @assets)