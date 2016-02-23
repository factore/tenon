window.ResourceIndexComponents.DefaultQuickSearchToolbar = (props) => {
  const { QuickSearchInput, ActionButtons } = props.childComponents;

  return (
    <div>
      <div className="toolbar">
        <Breadcrumbs breadcrumbs={props.breadcrumbs} />
        <div className="toolbar__content">
          <QuickSearchInput { ...props } />
          <ActionButtons { ...props } />
        </div>
      </div>
    </div>
  );
};
