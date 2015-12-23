class Breadcrumbs extends React.Component {
  render() {
    return (
      <ul className="breadcrumbs">
        {this.props.breadcrumbs.map((breadcrumb, i) =>
          <li key={i}>{this.renderLink(breadcrumb, i)}</li>
        )}
      </ul>
    );
  }

  renderLink(breadcrumb, i) {
    let jsx;

    if (i === this.props.breadcrumbs.length - 1) {
      jsx = <span>{breadcrumb.title}</span>;
    } else {
      jsx = <a href={breadcrumb.path}>{breadcrumb.title}</a>;
    }
    return jsx;
  }
}

window.Breadcrumbs = Breadcrumbs;
