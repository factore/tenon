Tenon.features.nestedFields = {
  config: {
    sortable: {

    }
  },

  init: function (container, options) {
    var self = Tenon.features.nestedFields,
        $container = $(container);
    $.extend(self.config, options);

    $container
      .on('click', 'a.add_child', self.addChild)
      .on('click', 'a.remove_child', self.removeChild)
      .find('.sortable').sortable({
        update: function(event, ui) {
          var $list = $(this);
          var i = 0;
          $.each($list.find('li'), function() {
            $(this).find('input[name*=list_order]').val(i);
            i++;
          });
          self.runCallback(self.config.after);
        }
      });
  },

  addChild: function (e) {
    e.preventDefault();
    var self     = Tenon.features.nestedFields,
        assoc    = $(this).attr('data-association'),
        content  = $('#' + assoc + '_fields_template').html(),
        regexp   = new RegExp('new_' + assoc, 'g'),
        new_id   = new Date().getTime(),
        $list    = $('#'+assoc+'-list');

    self.runCallback(self.config.before);

    $list.append(content.replace(regexp, new_id));

    // Maintain the same value as the last select box
    if (content.match(/<select/)) {
      var length = $list.find("select").length;
      $($list.find("select")[length - 1]).val($($list.find("select")[length - 2]).val());
    }
    //$('input').hint();
    self.runCallback(self.config.after);
  },

  removeChild: function () {
    var self        = Tenon.features.nestedFields,
        hiddenField = $(this).prev('input[name*=_destroy]')[0];

    if (confirm(I18n.tenon.common.are_you_sure)) {
      // Existing records get set as deleted, new records just get cleared out of the DOM
      if(hiddenField) {
        hiddenField.value = 'true';
      }

      $(this).closest('li').fadeOut('fast', function() {
        self.runCallback(self.config.after);
      });

    }
    return false;
  },

  runCallback: function (callback) {
    if (typeof(callback) !== 'undefined')
      callback.call();
  },

  reorganize: function (mod, selector) {
    var $images = $(selector);
    $images.removeClass('last');
    $.each($images, function() {
      var index = $(this).index(selector + ":visible");
      if((index + 1) % mod === 0) {
        $(this).addClass('last');
      }
    });
  },

  setListOrder: function (selector) {
    var $images = $(selector);
    $.each($images, function() {
      var listOrder = $(this).find('input[name*=list_order]');
      var index = $(this).index(selector + ":visible");
      if (listOrder.length > 0) {
        listOrder.val(index);
      }
    });
  }
};
