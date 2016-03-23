window.ResourceIndexComponents.DefaultToolbar = (props) => {
  const {
    QuickSearchInput, QuickSearchToggle, FilterDrawerToggle, SortOrder
  } = props.childComponents;

  return (
    <div>
      <div className="toolbar">
        <Breadcrumbs breadcrumbs={props.breadcrumbs} />
        <div className="toolbar__content">
          <QuickSearchInput { ...props } className="hide-on-min" />
        </div>

        <div className="toolbar__actions toolbar__actions--right">
          <QuickSearchToggle {...props} />
          <FilterDrawerToggle {...props} className="hide-on-min" />
        </div>
      </div>
    </div>
  );
};
