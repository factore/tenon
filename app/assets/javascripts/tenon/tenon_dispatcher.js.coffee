class TenonDispatcher
  constructor: ->
    @routes = { }

  initialize: ->
    body = $('body')

    controller = body.data('controller')
    action = body.data('action')

    @dispatch('tenon', 'initialize')

    @dispatch(controller, 'initialize')
    @dispatch(controller, action)

  route: (amalgam, fn) ->
    [controller, action] = amalgam.split('#')

    @routes[controller] ?= { }
    @routes[controller][action] = fn

  dispatch: (controller, action) ->
    @routes[controller]?[action]?()

Tenon.dispatcher = new TenonDispatcher
