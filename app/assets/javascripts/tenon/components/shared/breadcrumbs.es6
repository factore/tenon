/* global React */

class Breadcrumbs extends React.Component {
  render() {
    return (
      <div className="breadcrumbs">
        <ul className="breadcrumbs__list">
          {this.props.breadcrumbs.map((breadcrumb, i) =>
            <li className="breadcrumbs__item" key={i}>
              {this.renderLink(breadcrumb, i)}
            </li>
          )}
        </ul>
      </div>
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
