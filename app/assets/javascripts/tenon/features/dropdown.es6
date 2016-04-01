() => {
  class Dropdown {
    constructor(options) {
      const defaultOptions = {
        inDuration: 250,
        outDuration: 250,
        constrainWidth: true, // Constrains width of dropdown to the activator
        hover: false,
        gutter: 0, // Spacing from edge
        belowOrigin: true,
        alignment: 'left',
        selector: '[data-dropdown-activate]'
      };

      this.globalOptions = { ...defaultOptions, options };
      $(document).on(
        'click.DropdownOrigin',
        this.globalOptions.selector,
        this.onClick.bind(this)
      );
    }

    onClick(e) {
      e.preventDefault();
      const $origin = $(e.currentTarget);
      const options = {
        ...this.globalOptions,
        ...this._optionsFromData($origin)
      };

      if ($origin.data('dropdown-active')) {
        this._hideDropdown($origin, options);
        $(document).off('click.DropdownOut');
      } else {
        this._placeDropdown($origin, options);
        $(document).on('click.DropdownOut', (ev) => {
          this.onClickOut(ev, $origin);
        });
      }
    }

    onClickOut(e, $origin) {
      const $activates = $origin.next('.dropdown');
      const ignore = [
        $origin,
        $origin.find('*'),
        $activates,
        $activates.find('*')
      ];

      e.preventDefault();
      if (!_.find(ignore, (el) => el.is(e.target))) {
        $origin.trigger('click.DropdownOrigin');
      }
    }

    _hideDropdown($origin, options) {
      const $activates = $origin.next('.dropdown');

      $origin.data('dropdown-active', false);
      $activates.fadeOut(options.outDuration);
      $activates.removeClass('dropdown--is-active');
      $origin.removeClass('dropdown-button--is-active');
      setTimeout(
        function() {
          $activates
            .css('max-height', '')
            .insertAfter($origin);
        }
        , options.outDuration
      );
    }

    _placeDropdown($origin, options) {
      const $activates = $origin.next('.dropdown');

      $origin.data('dropdown-active', true);

      // Add active classes
      $activates.addClass('dropdown--is-active');
      $origin.addClass('dropdown-button--is-active');

      // Constrain width
      if (options.constrainWidth === true) {
        $activates.css('width', $origin.outerWidth());
      } else {
        $activates.css('white-space', 'nowrap');
      }

      // Position dropdown
      $activates.css({
        position: 'absolute',
        top: this._topPosition($origin, $activates, options),
        left: this._leftPosition($origin, $activates, options)
      });

      // Show dropdown
      $activates
        .stop(true, true)
        .css('opacity', 0)
        .slideDown({
          queue: false,
          duration: options.inDuration,
          easing: 'easeOutCubic',
          complete: function() {
            $(this).css('height', '');
          }
        })
        .animate(
          { opacity: 1 },
          { queue: false, duration: options.inDuration, easing: 'easeOutSine' }
        );
    }

    _optionsFromData($origin) {
      const currentOptions = {};

      [
        'in-duration', 'out-duration', 'constrain-width',
        'gutter', 'below-origin', 'alignment'
      ].forEach((opt) => {
        if ($origin.data(opt) && $origin.data(opt).length) {
          currentOptions[_.camelCase(opt)] = $origin.data(opt);
        }
      });
    }

    _topPosition($origin, $activates, options) {
      const startingPoint = $origin.position().top;
      const originHeight = $origin.innerHeight();
      const windowHeight = window.innerHeight;
      const offsetTop = startingPoint - $(window).scrollTop();
      let verticalOffset = 0;
      let adjustedHeight;

      if (options.belowOrigin === true) {
        verticalOffset = $origin.innerHeight();
      }

      // Vertical bottom offscreen detection
      if (offsetTop + $activates.innerHeight() > windowHeight) {
        // If going upwards still goes offscreen, just crop height of dropdown.
        if (offsetTop + originHeight - $activates.innerHeight() < 0) {
          adjustedHeight = windowHeight - offsetTop - verticalOffset;
          $activates.css('max-height', adjustedHeight);
        } else {
          // Flow upwards.
          if (!verticalOffset) {
            verticalOffset += originHeight;
          }
          verticalOffset -= $activates.innerHeight();
        }
      }

      return startingPoint + verticalOffset;
    }

    _leftPosition($origin, $activates, options) {
      const offsetLeft = $origin.position().left;
      let currAlignment = options.alignment;
      let gutterSpacing, offsetRight;

      if (offsetLeft + $activates.innerWidth() > $(window).width()) {
        // Dropdown goes past screen on right, force right alignment
        currAlignment = 'right';
      } else if (offsetLeft - $activates.innerWidth() + $origin.innerWidth() < 0) {
        // Dropdown goes past screen on left, force left alignment
        currAlignment = 'left';
      }

      // Handle edge alignment
      if (currAlignment === 'left') {
        gutterSpacing = options.gutter;
        return $origin.position().left + gutterSpacing;
      } else if (currAlignment === 'right') {
        offsetRight = $origin.position().left + $origin.outerWidth();
        offsetRight -= $activates.outerWidth();
        gutterSpacing = -options.gutter;
        return offsetRight + gutterSpacing;
      }
    }
  }

  window.Tenon.features.Dropdown = Dropdown;
}();
