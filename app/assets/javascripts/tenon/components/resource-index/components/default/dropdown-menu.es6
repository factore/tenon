/* global React */
/* global ReactDOM */
/* global ReactPortal */

class DropdownMenu extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      leftPos: 0,
      topPos: 0
    };
  }

  componentDidMount() {
    this._setLeftPos(this.props);
  }

  componentWillReceiveProps(nextProps) {
    this._setLeftPos(nextProps);
  }

  _setLeftPos(props) {
    const offsetLeft = props.left || 0;
    const gutter = props.gutter || 0;
    const dropdownWidth = 200;
    let currAlignment = props.alignment || 'left';
    let gutterSpacing, offsetRight;

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
      this.setState({ leftPos: offsetLeft + gutterSpacing });
    } else if (currAlignment === 'right') {
      offsetRight = offsetLeft;
      offsetRight -= dropdownWidth;
      gutterSpacing = -gutter;
      this.setState({ leftPos: offsetRight + gutterSpacing });
    }
  }

  render() {
    const { leftPos } = this.state;

    return (
      <ReactPortal
        closeOnOutsideClick
        onClose={this.props.onClose}
        isOpened={this.props.isDropdownOpened}>
        <ul
          ref={(ul) => this.ul = ul}
          className="dropdown dropdown--is-active"
          style={{ left: leftPos, top: this.props.top }}>
          {this.props.children}
        </ul>
      </ReactPortal>
    );
  }
}

window.DropdownMenu = DropdownMenu;
