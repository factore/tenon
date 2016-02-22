const component = (props) => {
  const {
    onClickClear, ui: { quickSearchOpen },
    childComponents: { QuickSearchInput, ActionButtons }
  } = props;
  const classNames = ['toolbar-overlay', 'toolbar-overlay--z1'];

  if (quickSearchOpen) {
    classNames.push('toolbar-overlay--is-open');
  }

  return (
    <div className={classNames.join(' ')}>
      <div className="toolbar-overlay__background"></div>

      <div className="toolbar-overlay__action">
        <div className="toolbar__action">
          <a
            href="#!"
            className="action-icon toolbar__search-clear"
            onClick={onClickClear}>
              <i className="material-icon">arrow_back</i>
            Clear
          </a>
        </div>
      </div>

      <div className="toolbar-overlay__content">
        <QuickSearchInput { ...props } />
        <ActionButtons { ...props } />
      </div>
    </div>
  );
};

window.ResourceIndexComponents.DefaultQuickSearchOverlay = component;
