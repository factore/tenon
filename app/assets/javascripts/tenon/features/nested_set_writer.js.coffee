class Tenon.features.NestedSetWriter
  constructor: (@set, @$list, @template, @name) ->
    @output = "<li class='top' data-record-id='#{@set[0].id}'>\n"
    @path = [null]
    @_buildList()
    @_populateList()
    @_addPlaceholderLists()

  # This was adapted from example code for the awesome_nested_set gem
  # I have no idea how it the logic in here works.
  _buildList: =>
    for o, i in @set
      @output += "\n<!-- Writing for page #{o.id} with parent_id #{o.parent_id} -->\n"
      unless o == @set[0]
        if o.parent_id != @path[@path.length - 1]
          # We are on a new level, did we decend or ascend?
          if $.inArray(o.parent_id, @path) != -1

            # Remove wrong tailing paths elements
            while @path[@path.length - 1] != o.parent_id
              @path.pop()
              @output += "\n</li>\n</ul>"

            if o.parent_id
              @output += "\n</li>\n<li data-record-id='#{o.id}' class='subpage'>\n"
            else
              @output += "\n</li>\n<li data-record-id='#{o.id}' class='top'>\n"
          else
            @path.push(o.parent_id)
            @output += "<ul class='subpages'>\n<li class='subpage' data-record-id='#{o.id}'>\n"
        else if i != 0
          if o.parent_id
            @output += "\n</li>\n<li data-record-id='#{o.id}' class='subpage'>\n"
          else
            @output += "\n</li>\n<li data-record-id='#{o.id}' class='top'>\n"

    for p in @path
      if p
        @output += "\n</li>\n</ul>"
      else
        @output += "\n</li>"

    @$list.append($.parseHTML(@output))

  _populateList: =>
    for record in @set
      $li = @$list.find("li[data-record-id=#{record.id}]")
      $ul = $li.find('ul:first')
      template = @_getTemplate(record)
      if $ul.length > 0
        $(template).insertBefore($ul)
      else
        $li.html($(template))

  _addPlaceholderLists: =>
    $.each @$list.find('li'), ->
      $li = $(this)
      if $li.find('> ul').length == 0
        $ul = $('<ul />').addClass('ui-sortable subpages')
        $li.append($ul)

  _getTemplate: (record) =>
    opts = {}
    opts[@name] = record
    JST[@template](opts)