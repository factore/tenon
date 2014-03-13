Tenon.features.i18n = {
  init: function () {
    $('#current_language').on('change', function() {
      var val = $(this).val();
      $('.i18n').css({position: 'absolute'});
      $('.' + val).css({position: 'static'});
      $('#current_language').val(val);
    });
  }
}