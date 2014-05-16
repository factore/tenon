class Tenon.features.ItemVersionAutosave
  constructor: ->
    @$form = $('form[data-autosave="true"]')
    @$form.on('keyup change cocoon:after-insert cocoon:after-remove', $.debounce(6000, @autosave))

  autosave: =>
    console.log('saved')
    jqxhr = $.ajax
      url: @$form.data('version-create-path')
      data: @_formData()
      method: 'POST'
    jqxhr.done(@_updateAutosave)

  _updateAutosave: (data) =>
    $('.last-autosave')
      .text("Last draft autosave on #{data.created_at}")
      .fadeIn()

  _formData:  =>
    itemFormData = URI("?" + @$form.serialize()).query(true)

    # Serialize the checkbox in a way that rails can get down with
    @$form.find("input:checkbox").each ->
      if !(@.checked)
        itemFormData[@.name] = "0"
      else
        itemFormData[@.name] = "1"

    versionData =
      item_version:
        item_type: @$form.data('item-type')
        item_id: @$form.data('item-id')
        save_type: 'autosave'
        title: 'Auto-Save'
    delete(itemFormData._method)
    $.extend(itemFormData, versionData)