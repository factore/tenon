/* global React */
class DefaultHeader extends React.Component {
  constructor(props) {
    super(props);
  }

  render() {
    const { Filtering, ActionButtons } = this.props.childComponents;
    // @sean: Can we, by default, provide a unique modifier class for each tenon
    // module? This way, if we want to add a unique color, all we have to do is
    // add a bg-color to a .toolbar--module class.
    let toolbarClassName = 'toolbar toolbar--posts';

    return (
      <div className={toolbarClassName}>
        <Breadcrumbs breadcrumbs={this.props.breadcrumbs} />
        <Filtering { ...this.props } />
        <ActionButtons { ...this.props } />
      </div>
    );
  }
}

window.ResourceIndexComponents.DefaultHeader = DefaultHeader;
