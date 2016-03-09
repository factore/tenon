window.ClientSideValidations.formBuilders['Tenon::FormBuilder'] = {
  add: (element, settings, message) ->
    form = $(element[0].form)
    if element.data('valid') != false and not form.find("label.input-block__error-message[for='#{element.attr('id')}']")[0]?
      inputErrorField = $(settings.input_tag)
      labelErrorField = $(settings.label_tag)
      label = form.find("label[for='#{element.attr('id')}']:not(.input-block__error-message)")

      element.attr('autofocus', false) if element.attr('autofocus')

      element.before(inputErrorField)
      inputErrorField.find('span#input_tag').replaceWith(element)
      inputErrorField.find('label.input-block__error-message').attr('for', element.attr('id'))
      labelErrorField.find('label.input-block__error-message').attr('for', element.attr('id'))
      labelErrorField.insertAfter(label)
      labelErrorField.find('label#label_tag').replaceWith(label)

    form
      .find("label.input-block__error-message[for='#{element.attr('id')}']")
      .text("This field #{message}.")

  remove: (element, settings) ->
    form = $(element[0].form)
    errorFieldClass = $(settings.input_tag).attr('class')
    inputErrorField = element.closest(".#{errorFieldClass.replace(/\ /g, ".")}")
    label = form.find("label[for='#{element.attr('id')}']:not(.input-block__error-message)")
    labelErrorField = label.closest(".#{errorFieldClass}")

    if inputErrorField[0]
      inputErrorField.find("##{element.attr('id')}").detach()
      inputErrorField.replaceWith(element)
      label.detach()
      labelErrorField.replaceWith(label)
}

window.ClientSideValidations.callbacks.form.fail = ($el, event) ->
  msg = """
    <strong>One or more fields</strong> need to be fixed before this can be
    saved.
  """
  action = """
    <a href='#!' class='flash__action' data-focus-error>Fix Them</a>
  """
  Tenon.features.Flash.draw(msg, $(action))
