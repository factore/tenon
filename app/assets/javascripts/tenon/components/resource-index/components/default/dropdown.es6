/* global React */
/* global ReactDOM */
/* global DropdownButton */
/* global DropdownMenu */

class Dropdown extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      isDropdownOpened: false
    };
  }

  componentDidMount() {
    document.addEventListener('click', this._onOutsideClick.bind(this));
  }

  componentWillUnmount() {
    document.removeEventListener('click', this._onOutsideClick.bind(this));
  }

  _renderChildren() {
    return React.Children.map(this.props.children, (child) => {
      switch (child.type) {
      case DropdownButton:
        return React.cloneElement(child, {
          onClick: this._onClickButton.bind(this)
        });

      case DropdownMenu:
        return React.cloneElement(child, {
          left: this.state.left,
          top: this.state.top,
          width: this.state.width,
          height: this.state.height,
          isDropdownOpened: this.state.isDropdownOpened,
        });

      default:
        return child;
      }
    });
  }

  _onClickButton(e) {
    const bodyRect = document.body.getBoundingClientRect();
    const targetRect = e.target.getBoundingClientRect();

    this.setState({
      isDropdownOpened: !this.state.isDropdownOpened,
      top: targetRect.top - bodyRect.top,
      left:  targetRect.left - bodyRect.left,
      width: targetRect.width,
      height: targetRect.height
    });
  }

  _onOutsideClick(e) {
    const { isDropdownOpened } = this.state;

    if (!isDropdownOpened || ReactDOM.findDOMNode(this).contains(e.target)) {
      return;
    }

    this.setState({ isDropdownOpened: false });
  }

  render() {
    const className = this.props.className || 'dropdown-container';

    return (
      <div className={className}>
        {this._renderChildren()}
      </div>
    );
  }
}

window.Dropdown = Dropdown;
