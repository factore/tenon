import React, { Component } from 'react';
import { connect } from 'react-redux';
import { bindActionCreators } from 'redux';
import actionCreators from '../actions/index';

const DEFAULT_CHILD_COMPONENT_NAMES = {
  AddButton: 'DefaultAddButton',
  ActionButtons: 'DefaultActionButtons',
  ClearFiltersLink: 'DefaultClearFiltersLink',
  Filtering: 'DefaultFiltering',
  FilterOverlay: 'DefaultFilterOverlay',
  FilterDrawerToggle: 'DefaultFilterDrawerToggle',
  List: 'DefaultList',
  LoadMoreButton: 'DefaultLoadMoreButton',
  ModalAddButton: 'DefaultModalAddButton',
  ModalForm: 'DefaultModalForm',
  QuickSearchInput: 'DefaultQuickSearchInput',
  QuickSearchOverlay: 'DefaultQuickSearchOverlay',
  QuickSearchToggle: 'DefaultQuickSearchToggle',
  SortOrder: 'DefaultSortOrder',
  SortOrderItem: 'DefaultSortOrderItem',
  Record: 'DefaultRecord',
  RecordTitle: 'DefaultRecordTitle',
  RecordActions: 'DefaultRecordActions',
  RecordsCount: 'DefaultRecordsCount',
  RecordExpandedContent: 'DefaultRecordExpandedContent',
  Toolbar: 'DefaultToolbar'
};

class Wrapper extends Component {
  constructor(props) {
    super(props);
    this._setupHandlers();
    this._setupChildComponents();
  }

  _setupHandlers() {
    this.props.handlers.updateQuery = this._updateQuery.bind(this);
    this.props.handlers.replaceQuery = this._replaceQuery.bind(this);
    this.props.handlers.deleteRecord = this._deleteRecord.bind(this);
    this.props.handlers.loadNextPage = this._loadNextPage.bind(this);
    this.props.handlers.updateRecord = this._updateRecord.bind(this);
    this.props.handlers.orderBy = this._orderBy.bind(this);
    this.props.handlers.toggleExpandedRecord = this._toggleExpandedRecord.bind(this);
    this.props.handlers.toggleModalForm = this._toggleModalForm.bind(this);
    this.props.handlers.editRecordInModal = this._editRecordInModal.bind(this);
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

  _replaceQuery(e, newQuery, append = false) {
    e.preventDefault();
    this.props.actions.replaceQuery(newQuery, append);
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

  _toggleModalForm(e, to) {
    e.preventDefault();
    this.props.actions.toggleModalForm(to);
  }

  _editRecordInModal(e, record) {
    e.preventDefault();
    this.props.actions.editRecordInModal(record);
  }

  _loadNextPage(e) {
    e.preventDefault();
    this.props.actions.loadNextPage();
  }

  render() {
    const { children } = this.props;
    const childrenWithProps = React.Children.map(children, (child) => {
      return React.cloneElement(child, { ...this.props });
    });

    return (
      <div>
        {childrenWithProps}
      </div>
    );
  }
}

Wrapper.defaultProps = {
  childComponentNames: {},
  childComponents: {},
  handlers: {}
};

function mapStateToProps(state) {
  return state;
}

function mapDispatchToProps(dispatch) {
  return { actions: bindActionCreators(actionCreators, dispatch) };
}

export default connect(mapStateToProps, mapDispatchToProps)(Wrapper);
