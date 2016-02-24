window.ResourceIndexComponents.DefaultActionButtons = (props) => {
  const { FilterDrawerToggle, SortOrder } = props.childComponents;

  return (
    <div className="toolbar__actions toolbar__actions--right">
      <FilterDrawerToggle {...props} />
      <SortOrder {...props} />
    </div>
  );
};
