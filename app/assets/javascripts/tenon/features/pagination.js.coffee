class Tenon.features.Pagination
  constructor: ->
    $('ul.pagination').on('click', 'a', @_pageClicked)

  _pageClicked: (e) =>
    e.preventDefault();
    @$link = $(e.currentTarget)
    @$pagination = @$link.closest('.pagination')
    @_goToPage()
    @_setActive()

  _goToPage: =>
    $recordList = $(@$pagination.data('record-list'))
    $recordList
      .data('records-page', @$link.data('page'))
      .find('li').addClass('hidden').delay(250).remove();
    new Tenon.features.RecordList($recordList)

  _setActive: =>
    @$pagination.find('li.active').removeClass('active')
    @$link.closest('li').addClass('active')