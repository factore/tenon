(function($) {

  $.fn.radioSlider = function(options) {
    var settings = {
      'sliderImage'     : '/images/tenon/slider-button.png',
      'activeClass'     : 'slider-active',
      'leftOffset'      : 0,
      'rightOffset'     : 19
    };

    if ( options ) { $.extend( settings, options ); }

    this.each(function() {
      var $this = this;
      var buttons = $('input:radio', this);
      var slideWidget = $('<div />').addClass('slider-widget').append($('<img />').attr('src', settings.sliderImage));

      //insert the widget
      $('label:first', this).after(slideWidget);

      // Set up the buttons
      buttons
        .css({ position: 'absolute', left: -9999 })
        .focus(function () {
          slideWidget.find('img').addClass('focus');
        })
        .blur(function () {
          slideWidget.find('img').removeClass('focus');
        });

      //charge the events
      buttons.bind('change.radioSlider', function() { updateSlider($this); });
      $('div.slider-widget', this).bind('click.radioSlider', function() { swapActive($this); });
      updateSlider(this);
    });

    function updateSlider(holder) {
      holder = $(holder);
      var checked = $('input[type=radio]:checked', holder);
      var slider = $('div.slider-widget img', holder);
      if (checked.index($('input[type=radio]', holder)) === 0) {
        slider.animate({left: settings.leftOffset}, 100);
      } else {
        slider.animate({left: settings.rightOffset}, 100);
      }
      $('label', holder).removeClass(settings.activeClass);
      $('input[type=radio]:checked', holder).closest('label').addClass(settings.activeClass);
    }

    function swapActive(holder) {
      $(holder).find('input[type=radio]').not(':checked').click().change();
    }

  };
})(jQuery);
