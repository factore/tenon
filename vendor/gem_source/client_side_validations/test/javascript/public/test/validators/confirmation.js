module('Confirmation options', {
  setup: function() {
    $('#qunit-fixture')
      .append('<input id="password" type="password" />')
      .append('<input id="password_confirmation" type="password" />')
      .append('<input id="username" type="text" />')
      .append('<input id="username_confirmation" type="text" />')
  }
});

test('when values match (case sensitive)', function() {
  var password_element = $('#password');
  var password_confirmation_element = $('#password_confirmation');
  var options = { message: "failed validation" };
  password_element.val('test');
  password_confirmation_element.val('test');
  equal(ClientSideValidations.validators.local.confirmation(password_element, options), undefined);
});

test('when values do not match', function() {
  var password_element = $('#password');
  var password_confirmation_element = $('#password_confirmation');
  var options = { message: "failed validation" };
  password_element.val('test');
  password_confirmation_element.val('bad test');
  equal(ClientSideValidations.validators.local.confirmation(password_element, options), "failed validation");
});

test('when values match (case insensitive)', function() {
  var username_element = $('#username');
  var username_confirmation_element = $('#username_confirmation');
  var options = { message: "failed validation" };
  username_element.val('tEsT');
  username_confirmation_element.val('test');
  equal(ClientSideValidations.validators.local.confirmation(username_element, options), undefined);
});
