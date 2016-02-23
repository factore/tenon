window.ResourceIndexComponents.DefaultSortOrder = (props) => {
  if (!props.orderOptions || props.orderOptions.length === 0) {
    return <div></div>;
  }

  const { orderBy } = props.handlers;
  const { order_direction, order_field } = props.data.query;

  return (
    <div className="toolbar__action">
      <a
        className="action-icon dropdown-button"
        href="#!"
        title="Sort Order">
        <i className="material-icons">sort</i>
      </a>

      <ul className="dropdown-content">
        <li className="dropdown-label">Order By:</li>
        {props.orderOptions.map((oo) => {
          const classNames = [''];
          const { title, order } = oo;
          const [field, direction] = order.split(':');

          if (field === order_field && direction === order_direction) {
            classNames.push('active');
          }

          return (
            <li
              key={order}
              className={classNames.join(' ')}>
              <a
                href="#!"
                onClick={(e) => orderBy(e, field, direction)}>
                {title}
              </a>
            </li>
          );
        })}
      </ul>
    </div>
  );
};
