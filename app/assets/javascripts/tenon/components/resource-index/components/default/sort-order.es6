window.ResourceIndexComponents.DefaultSortOrder = (props) => {
  if (!props.orderOptions || props.orderOptions.length === 0) {
    return <div></div>;
  }

  const { SortOrderItem } = props.childComponents;

  return (
    <div className="records-list__action">
      <a
        className="records-list__action-icon dropdown-button"
        href="#!"
        title="Sort Order">
        <i className="material-icons">sort</i>
      </a>

      <ul className="dropdown">
        <li className="dropdown__item dropdown__item--label">Order By</li>
        {props.orderOptions.map((oo) => {
          return (
            <SortOrderItem
              key={oo.order}
              { ...props }
              title={oo.title}
              order={oo.order} />
          );
        })}
      </ul>
    </div>
  );
};
