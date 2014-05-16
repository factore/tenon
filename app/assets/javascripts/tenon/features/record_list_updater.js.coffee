class Tenon.features.RecordListUpdater
  constructor: ->
    $(document).on('click', 'a.record-list-updater', @updateRecordList)
    $(document).on('submit', 'form.record-list-updater', @updateRecordList)
    $(window).on('popstate', @popUpdate)

  updateRecordList: (e) =>
    e.preventDefault()
    $el = $(e.currentTarget)
    @clearQuery = $el.attr('data-clear-record-list-params')
    if $el.prop("tagName").toLowerCase() == 'form'
      @_updateWithQuery(@_processFormData($el), 'Search')
    else
      @_updateWithQuery(URI($el.attr('href')).query(true), $el.textContent)

  _processFormData: (form) =>
    formData = URI("?" + form.serialize()).query(true)
    form.find("input:checkbox").each ->
      if !(@.checked)
        formData[@.name] = "0"
    formData

  _updateWithQuery: (query, title) =>
    query = if @clearQuery then query else @_mergedQuery(query)
    state = if $.isEmptyObject(query) then "?" else "?#{query.toString()}"
    history.pushState({recordListUpdate: true}, title, state)
    Tenon.refreshed = false
    Tenon.activeRecordList.refresh(clear: true)

  # Get a combination of the current params and any new params that
  # the link or form is adding.  This allows us to, for example, submit
  # an advanced search form and then change the sort order with a link.
  # Add data-clear-record-list-params to prevent this merge.
  _mergedQuery: (newQueryObj) =>
    oldQueryObj = URI(location.href).query(true)
    $.param($.extend(oldQueryObj, newQueryObj))

  popUpdate: (e) =>
    # Chrome triggers window.onpopstate on page load, so elsewhere
    # at page load we set Tenon.refreshed to true to indicate that
    # as of yet nothing has been pushed to the history stack.
    #
    # Failing to do this results in a double AJAX load when the
    # page is first loaded in Chrome, and possible other browsers.
    if !Tenon.refreshed && Tenon.activeRecordList
      Tenon.activeRecordList.refresh(clear: true)
