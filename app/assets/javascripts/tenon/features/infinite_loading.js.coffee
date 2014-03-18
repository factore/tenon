class Tenon.features.InfiniteLoading
  constructor: ->
    $(document).on 'click', '.infinite-loader', @_loadRecords

  _loadRecords: (e) ->
    e.preventDefault()
    $link = $(e.currentTarget)
    $recordList = $($link.data('record-list'))
    nextPage = parseInt($recordList.data('records-page')) + 1
    $recordList.data('records-page', nextPage)
    new Tenon.features.RecordList($recordList)

