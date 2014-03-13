Tenon.features.notifications = {
  init: function () {
    var self = Tenon.features.notifications;

    if ($('#notification-bar').find('span').html() !== '') {
      $('#notification-bar').slideDown();
    }
    $('body').on('click', self.clearNotifications)
  },

  clearNotifications: function () {
    var self = Tenon.features.notifications;

    $('#notification-bar').slideUp();
    $('#warning').fadeOut(function () {
      $('#warning').remove();
    });
  },

  newWarning: function (message) {
    $('<div />').attr('id', 'warning').html(message).appendTo('body');
  },

  newNotice: function (message) {
    var self = Tenon.features.notifications;
    $('#notification-bar').find('span').html(message).end().slideDown();
  }
}