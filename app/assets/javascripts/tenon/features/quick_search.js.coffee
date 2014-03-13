class Tenon.features.QuickSearch
  constructor: ->
    $(document).on('keyup', '#quick-search', $.debounce(500, @_submitSearch))

  _submitSearch: (e) =>
    @$field = $('#quick-search')
    @$list = $(@$field.data('record-list'))
    params = {q: @$field.val()}
    new Tenon.features.RecordList(@$list, params: params, clear: true)