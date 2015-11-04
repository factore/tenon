class DefaultSidebar extends React.Component {
  render() {
    const singular = _.singularize(this.props.title)
    return(
      <div className="sidebar-container">
        <div className="sidebar">
          <div className="content">
            <h2>{this.props.title}</h2>
            <a href={this.props.newPath} className="btn btn-primary btn-block">
              New {singular}
            </a>
          </div>
        </div>
      </div>
    );
  }
}

window.ResourceIndexComponents.DefaultSidebar = DefaultSidebar;
