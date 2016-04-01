/* global DropdownHelper */

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
      const $activates = $origin.data('dropdown');

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
      $origin.data('dropdown', $activates);

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
      $activates
        .appendTo('body')
        .css({
          top: this._topPosition($origin, $activates, options),
          left: this._leftPosition($origin, $activates, options)
        });

      // Show dropdown
      DropdownHelper.animateIn($activates, options.inDuration);
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
      return DropdownHelper.getTopPos($activates, {
        ...options,
        top: $origin.offset().top,
        height: $origin.innerHeight()
      });
    }

    _leftPosition($origin, $activates, options) {
      return DropdownHelper.getLeftPos($activates, {
        ...options,
        left: $origin.offset().left,
        width: $origin.outerWidth()
      });
    }
  }

  window.Tenon.features.Dropdown = Dropdown;
}();
