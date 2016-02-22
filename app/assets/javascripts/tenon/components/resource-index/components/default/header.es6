/* global React */
class DefaultHeader extends React.Component {
  constructor(props) {
    super(props);
  }

  render() {
    const { Filtering, QuickSearch } = this.props.childComponents;

    return (
      <div>
        <QuickSearch
            { ...this.props }
            onClickClear={(e) => this._clearFilters(e)}
            onFocus={() => actions.toggleQuickSearch('on')}
            onChange={(e) => this._changeFilter(e)}
            onBlur={(e) => {
              if (e.target.value === '') {
                actions.toggleQuickSearch('off');
              }
            }} />

        // @sean: Put the Quicksearch overlay here
        // When we discussed this you said that the quick search component doesn't
        // need to know all the QuickSearchInput functions and as a result would
        // be moved into it's own smart component.
        // I added your sample tree below.

        <Filtering { ...this.props } />
      </div>
    );
  }
}

window.ResourceIndexComponents.DefaultHeader = DefaultHeader;



// <toolbar BASE>
//   <breadcrumbs>
//   <qsi>
//   <actions>
// </toolbar>
//
// <toolbar toolbar--overlay WHEN QUICK SEARCH IS FOCUSED>
//   <back button>
//   <qsi>
//   <actions>
// </toolbar>
//
// <toolbar toolbar--overlay WHEN FILTERING SHIT>
//   <back button>
//   <number of record results>
//   <actions>
// </toolbar>
