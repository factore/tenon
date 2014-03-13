json.records do
  json.partial! '<%= singular_name %>', collection: @<%= plural_name %>, as: :<%= singular_name %>
end

json.partial!('tenon/shared/pagination', collection: @<%= plural_name %>)