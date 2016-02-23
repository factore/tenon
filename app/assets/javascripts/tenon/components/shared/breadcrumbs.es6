class Breadcrumbs extends React.Component {
  render() {
    return (
      <ul className="breadcrumbs">
        {this.props.breadcrumbs.map( (breadcrumb, i) =>
          <li className="breadcrumbs__item action-icon" key={i}>
            {this.renderLink(breadcrumb, i)}
            <i className="material-icon">keyboard_arrow_right</i>
          </li>
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
