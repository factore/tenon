import { Component } from 'react';
import { connect } from 'react-redux';
import { bindActionCreators } from 'redux';
import * as UiActionCreators from '../actions/ui';
import * as DataActionCreators from '../actions/data';

const DEFAULT_CHILD_COMPONENT_NAMES = {
  Sidebar: 'DefaultSidebar',
  Header: 'DefaultHeader',
  ActionButtons: 'DefaultActionButtons',
  Filtering: 'DefaultFiltering',
  QuickSearch: 'DefaultQuickSearch',
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
    this.props.handlers.deleteRecord = this._deleteRecord.bind(this);
    this.props.handlers.loadNextPage = this._loadNextPage.bind(this);
    this.props.handlers.updateRecord = this._updateRecord.bind(this);
    this.props.handlers.toggleExpandedRecord = this._toggleExpandedRecord.bind(this);
  }

  _setupChildComponents() {
    const names = Object.assign({}, DEFAULT_CHILD_COMPONENT_NAMES, this.props.childComponentNames);
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

  _updateRecord(e, record, payload) {
    e.preventDefault();
    this.props.actions.updateRecord(record, payload);
  }

  _toggleExpandedRecord(e, record) {
    e.preventDefault();
    this.props.actions.toggleExpandedRecord(record);
  }

  _loadNextPage(e) {
    e.preventDefault();
    this.props.actions.loadNextPage();
  }

  _outerClassNames() {
    const classNames = [];

    if (this.props.ui.quickSearchOpen) {
      classNames.push('quick-search-open');
    }

    if (this.props.ui.filterDrawerOpen) {
      classNames.push('filter-drawer-open');
    }

    return classNames.join(' ');
  }

  render() {
    const { Header, List } = this.props.childComponents;
    const classNames = this._outerClassNames();

    return (
      <div className={classNames}>
        <div className='drawer-pusher'>
          <Header {...this.props} />
          <List {...this.props} />
        </div>
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
