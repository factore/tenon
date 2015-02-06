json.records do
  json.partial! 'menu', collection: @menus, as: :menu
end

json.partial!('tenon/shared/pagination', collection: @menus)