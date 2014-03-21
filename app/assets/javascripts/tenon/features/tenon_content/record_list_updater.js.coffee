class Tenon.features.RecordListUpdater
  constructor: ->
    $(document).on('click', 'a.record-list-updater', @updateRecordList)
    $(window).on('popstate', @popUpdate)

  updateRecordList: (e) =>
    e.preventDefault()
    $link = $(e.currentTarget)
    query = URI($link.attr('href')).query()
    history.pushState({recordListUpdate: true}, $link.textContent, "?#{query}")
    Tenon.refreshed = false
    Tenon.activeRecordList.refresh(clear: true)

  popUpdate: (e) =>
    if !Tenon.refreshed && Tenon.activeRecordList
      state = e.originalEvent.state
      Tenon.activeRecordList.refresh(clear: true)