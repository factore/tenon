json.records do
  json.partial! 'tenon_callout', collection: @tenon_callouts, as: :tenon_callout
end

json.partial!('tenon/shared/pagination', collection: @tenon_callouts)