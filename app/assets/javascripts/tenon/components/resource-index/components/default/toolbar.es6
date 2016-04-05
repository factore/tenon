/* global React */
/* global classNames */

() => {
  class DefaultToolbar extends React.Component {
    constructor(props) {
      super(props);
      this.state = {
        quickSearchTyping: props.data.query.q && props.data.query.q.length
      };
    }

    _toggleQuickSearchTyping(to) {
      if (to === 'on') {
        this.setState({ quickSearchTyping: true });
      } else {
        this.setState({ quickSearchTyping: false });
      }
    }

    render() {
      const {
        QuickSearchInput, QuickSearchToggle, FilterDrawerToggle
      } = this.props.childComponents;

      const classnames = classNames({
        'toolbar': true,
        'toolbar--is-quick-search-typing': this.state.quickSearchTyping
      });

      return (
        <div>
          <div className={classnames}>
            <Breadcrumbs breadcrumbs={this.props.breadcrumbs} />
            <div className="toolbar__content">
              <QuickSearchInput
                { ...this.props }
                onFocus={() => this._toggleQuickSearchTyping('on')}
                onBlur={(e) => {
                  if (!e.target.value || !e.target.value.length) {
                    this._toggleQuickSearchTyping('off');
                  }
                }}
                className="hide-on-min" />
            </div>

            <div className="toolbar__actions toolbar__actions--right">
              <QuickSearchToggle {...this.props} />
              <FilterDrawerToggle {...this.props} className="hide-on-min" />
            </div>
          </div>
        </div>
      );
    }
  }

  window.ResourceIndexComponents.DefaultToolbar = DefaultToolbar;
}();
