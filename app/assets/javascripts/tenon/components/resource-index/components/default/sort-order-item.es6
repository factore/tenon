window.ResourceIndexComponents.DefaultSortOrderItem = (props) => {
  const classNames = [''];
  const { title, order } = props;
  const { order_field, order_direction } = props.data.query;
  const { orderBy } = props.handlers;
  const [field, direction] = order.split(':');

  if (field === order_field && direction === order_direction) {
    classNames.push('active');
  }

  return (
    <li className={classNames.join(' ')}>
      <a
        href="#!"
        onClick={(e) => orderBy(e, field, direction)}>
        {title}
      </a>
    </li>
  );
};
