import { Component } from 'react';
import { connect } from 'react-redux';
import { bindActionCreators } from 'redux';
import * as UiActionCreators from '../actions/ui';
import * as DataActionCreators from '../actions/data';

const DEFAULT_CHILD_COMPONENT_NAMES = {
  ActionButtons: 'DefaultActionButtons',
  Filtering: 'DefaultFiltering',
  FilterOverlay: 'DefaultFilterOverlay',
  FilterDrawerToggle: 'DefaultFilterDrawerToggle',
  QuickSearchToolbar: 'DefaultQuickSearchToolbar',
  QuickSearchInput: 'DefaultQuickSearchInput',
  QuickSearchOverlay: 'DefaultQuickSearchOverlay',
  SortOrder: 'DefaultSortOrder',
  List: 'DefaultList',
  Record: 'DefaultRecord',
  RecordTitle: 'DefaultRecordTitle',
  RecordActions: 'DefaultRecordActions',
  RecordExpandedContent: 'DefaultRecordExpandedContent',
  LoadMoreButton: 'DefaultLoadMoreButton'
};

class App extends Component {
  constructor(props) {
    super(props);
    this._setupHandlers();
    this._setupChildComponents();
  }

  componentWillMount() {
    this.props.actions.setBaseUri(this.props.recordsPath);
    this.props.actions.fetchRecords();
  }

  _setupHandlers() {
    this.props.handlers.updateQuery = this._updateQuery.bind(this);
    this.props.handlers.deleteRecord = this._deleteRecord.bind(this);
    this.props.handlers.loadNextPage = this._loadNextPage.bind(this);
    this.props.handlers.updateRecord = this._updateRecord.bind(this);
    this.props.handlers.orderBy = this._orderBy.bind(this);
    this.props.handlers.toggleExpandedRecord = this._toggleExpandedRecord.bind(this);
  }

  _setupChildComponents() {
    const names = {
      ...DEFAULT_CHILD_COMPONENT_NAMES,
      ...this.props.childComponentNames
    };
    let name;

    Object.keys(names).forEach((key) => {
      name = names[key];
      this.props.childComponents[key] = window.ResourceIndexComponents[name];
    });
  }

  _deleteRecord(e, record) {
    e.preventDefault();
    if (confirm('Are you sure?')) {
      this.props.actions.deleteRecord(record);
    }
  }

  _updateRecord(e, record, changes) {
    e.preventDefault();
    this.props.actions.updateRecord(record, changes);
  }

  _updateQuery(e, changes, append = false) {
    e.preventDefault();
    this.props.actions.updateQuery(changes, append);
  }

  _orderBy(e, field, direction = 'asc') {
    e.preventDefault();
    const changes = {
      order_field: field,
      order_direction: direction,
      page: 1
    };
    const append = false;

    this.props.actions.updateQuery(changes, append);
  }

  _toggleExpandedRecord(e, record) {
    e.preventDefault();
    this.props.actions.toggleExpandedRecord(record);
  }

  _loadNextPage(e) {
    e.preventDefault();
    this.props.actions.loadNextPage();
  }

  render() {
    const {
      QuickSearchOverlay, QuickSearchToolbar, List, Filtering
    } = this.props.childComponents;
    const classNames = [];

    if (this.props.ui.quickSearchOpen) {
      classNames.push('quick-search-open');
    }

    if (this.props.ui.filterDrawerOpen) {
      classNames.push('filter-drawer--open');
    }

    return (
      <div className={classNames.join(' ')}>
        <QuickSearchToolbar { ...this.props } />
        <QuickSearchOverlay { ...this.props } />
        <Filtering { ...this.props } />
        <List {...this.props} />
      </div>
    );
  }
}

App.defaultProps = {
  childComponentNames: {},
  childComponents: {},
  handlers: {}
};

function mapStateToProps(state) {
  return state;
}

function mapDispatchToProps(dispatch) {
  const actionCreators = { ...DataActionCreators, ...UiActionCreators };

  return { actions: bindActionCreators(actionCreators, dispatch) };
}

export default connect(mapStateToProps, mapDispatchToProps)(App);
