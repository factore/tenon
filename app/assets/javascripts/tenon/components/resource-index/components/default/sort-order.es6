window.ResourceIndexComponents.DefaultSortOrder = (props) => {
  if (!props.orderOptions || props.orderOptions.length === 0) {
    return <div></div>;
  }

  const { SortOrderItem } = props.childComponents;

  return (
    <div className="records-list__action">
      <Dropdown>
        <DropdownButton
          className="records-list__action-icon"
          title="Sort Order">
          <i className="material-icons">sort</i>
        </DropdownButton>

        <DropdownMenu>
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
        </DropdownMenu>
      </Dropdown>
    </div>
  );
};
