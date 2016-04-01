// We have Dropdowns being drawn via DOM events and via React, let's
// move some of the logic here so we can avoid duplication

window.DropdownHelper = {
  animateIn: (node, duration) => {
    $(node)
      .stop(true, true)
      .css('opacity', 0)
      .slideDown({
        queue: false,
        duration: duration,
        easing: 'easeOutCubic',
        complete: function() {
          $(this).css('height', '');
        }
      })
      .animate(
        { opacity: 1 },
        { queue: false, duration: duration, easing: 'easeOutSine' }
      );
  },

  getLeftPos: (node, opts) => {
    const $node = $(node);
    const offsetLeft = opts.left || 0;
    const gutter = opts.gutter || 0;
    const width = opts.width || 0;
    const dropdownWidth = $node.innerWidth();
    let currAlignment = opts.alignment || 'left';
    let gutterSpacing, offsetRight, leftPos;

    if (offsetLeft + dropdownWidth > $(window).width()) {
      // Dropdown goes past screen on right, force right alignment
      currAlignment = 'right';
    } else if (offsetLeft - dropdownWidth < 0) {
      // Dropdown goes past screen on left, force left alignment
      currAlignment = 'left';
    }

    // Handle edge alignment
    if (currAlignment === 'left') {
      gutterSpacing = gutter;
      leftPos = offsetLeft + gutterSpacing;
    } else if (currAlignment === 'right') {
      offsetRight = offsetLeft + width;
      offsetRight -= dropdownWidth;
      gutterSpacing = -gutter;
      leftPos = offsetRight + gutterSpacing;
    }

    return leftPos;
  },

  getTopPos: (node, opts) => {
    const $node = $(node);
    const startingPoint = opts.top || 0;
    const originHeight = opts.height || 0;
    const belowOrigin = opts.belowOrigin;
    const windowHeight = window.innerHeight;
    const offsetTop = startingPoint - $(window).scrollTop();
    let verticalOffset = 0;
    let adjustedHeight;

    if (belowOrigin === true) {
      verticalOffset = originHeight;
    }

    // Vertical bottom offscreen detection
    if (offsetTop + $node.innerHeight() > windowHeight) {
      // If going upwards still goes offscreen, just crop height of dropdown.
      if (offsetTop + originHeight - $node.innerHeight() < 0) {
        adjustedHeight = windowHeight - offsetTop - verticalOffset;
        $node.css('max-height', adjustedHeight);
      } else {
        // Flow upwards.
        if (!verticalOffset) {
          verticalOffset += originHeight;
        }
        verticalOffset -= $node.innerHeight();
      }
    }

    return startingPoint + verticalOffset;
  }
};
