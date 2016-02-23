const component = (props) => {
  const {
    onClickClear, ui: { quickSearchOpen },
    childComponents: { QuickSearchInput, ActionButtons }
  } = props;
  const classNames = ['toolbar', 'toolbar--overlay'];

  if (quickSearchOpen) {
    classNames.push('toolbar--is-open');
  }

  return (
    <div className={classNames.join(' ')}>
      <div className="toolbar__action toolbar__action--left">
        <a
          href="#!"
          className="action-icon toolbar__search-clear"
          onClick={onClickClear}>
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
