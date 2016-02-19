/* global React */
class DefaultHeader extends React.Component {
  constructor(props) {
    super(props);
  }

  render() {
    const { Filtering, ActionButtons } = this.props.childComponents;

    return (
      <div className="toolbar">
        <Breadcrumbs breadcrumbs={this.props.breadcrumbs} />
        <Filtering {...this.props} />
        <ActionButtons />
      </div>
    );
  }
}

window.ResourceIndexComponents.DefaultHeader = DefaultHeader;
