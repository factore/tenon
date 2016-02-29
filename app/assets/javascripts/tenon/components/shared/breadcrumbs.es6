/* global React */

class Breadcrumbs extends React.Component {
  render() {
    return (
      <ul className="breadcrumbs">
        {this.props.breadcrumbs.map((breadcrumb, i) =>
          <li className="breadcrumbs__item" key={i}>
            {this.renderLink(breadcrumb, i)}
            <span className="breadcrumbs__separator">
              <i className="material-icon">
                keyboard_arrow_right
              </i>
            </span>
          </li>
        )}
      </ul>
    );
  }

  renderLink(breadcrumb, i) {
    let jsx;

    if (i === this.props.breadcrumbs.length - 1) {
      jsx = <span className="breadcrumbs__link">{breadcrumb.title}</span>;
    } else {
      jsx = (
        <a
          className="breadcrumbs__link"
          href={breadcrumb.path}>
          {breadcrumb.title}
        </a>
      );
    }
    return jsx;
  }
}

window.Breadcrumbs = Breadcrumbs;
