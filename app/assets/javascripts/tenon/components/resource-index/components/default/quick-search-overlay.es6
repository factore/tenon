const component = (props) => {
  const {
    ui: { quickSearchOpen },
    childComponents: { QuickSearchInput, ActionButtons },
    actions: { toggleQuickSearch, updateQuery }
  } = props;
  const classNames = ['toolbar', 'toolbar__quicksearch', 'toolbar--overlay-z1'];

  if (quickSearchOpen) {
    classNames.push('toolbar--is-open');
  }

  return (
    <div className={classNames.join(' ')}>
      <div className="toolbar__action toolbar__action--left">
        <a
          href="#!"
          className="action-icon toolbar__search-clear"
          onClick={(e) => {
            e.preventDefault();
            toggleQuickSearch('off');
            updateQuery({ q: '', page: 1 });
          }}>
            <i className="material-icon">arrow_back</i>
          Clear
        </a>
      </div>

      <div className="toolbar__content">
        <QuickSearchInput { ...props } />
        <ActionButtons { ...props } />
      </div>
    </div>
  );
};

window.ResourceIndexComponents.DefaultQuickSearchOverlay = component;
