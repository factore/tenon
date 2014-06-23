json.records do
  json.partial! 'redirect', collection: @redirects, as: :redirect
end

json.partial!('tenon/shared/pagination', collection: @redirects)