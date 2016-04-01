/* global React */
/* global ReactPortal */
/* global DropdownHelper */
/* global classNames */

class DropdownMenu extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      leftPos: 0,
      topPos: 0
    };
  }

  _onOpen(node) {
    const $menu = $(node).find('.dropdown');

    this._setLeftPos($menu);
    this._setTopPos($menu);
    this._animateIn($menu);
  }

  _beforeClose(node, removeFromDOM) {
    $(node).find('.dropdown').fadeOut(250, () => {
      removeFromDOM();
    });
  }

  _setTopPos($node) {
    const topPos = DropdownHelper.getTopPos(
      $node,
      { ...this.props, belowOrigin: true }
    );

    this.setState({ topPos: topPos });
  }

  _setLeftPos($node) {
    const leftPos = DropdownHelper.getLeftPos($node, this.props);

    this.setState({ leftPos: leftPos });
  }

  _animateIn($node) {
    DropdownHelper.animateIn($node, 250);
  }

  render() {
    const { leftPos, topPos } = this.state;
    const classnames = classNames({
      'dropdown': true,
      'dropdown--is-active': this.props.isDropdownOpened
    });

    return (
      <ReactPortal
        beforeClose={this._beforeClose}
        onOpen={this._onOpen.bind(this)}
        isOpened={this.props.isDropdownOpened}>
        <ul
          className={classnames}
          style={{ left: leftPos, top: topPos }}>
          {this.props.children}
        </ul>
      </ReactPortal>
    );
  }
}

window.DropdownMenu = DropdownMenu;
