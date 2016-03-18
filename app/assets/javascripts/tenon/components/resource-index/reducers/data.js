import * as types from '../constants/action-types';
import queryStringObject from '../query-string-object';
import { toQueryString } from 'lodash';
import singleRecordReducer from './single-record';

const initialState = {
  // The record list
  records: [],
  pagination: { currentPage: 1 },
  isFetching: true,
  query: queryStringObject,

  // The record currently being edited
  currentRecord: {},
  currentRecordErrors: {},

  // Configuration for this instance
  config: {
    manageQueryString: true
  }
};

export default (state = initialState, action) => {
  let records, query;

  state = { ...state, records: singleRecordReducer(state.records, action) };
  switch (action.type) {
  case types.UPDATE_CONFIG:
    return { ...state, config: { ...state.config, ...action.updates } };

  case types.UPDATE_QUERY:
    query = { ...state.query, ...action.query };
    return { ...state, query: query };

  case types.REPLACE_QUERY:
    return { ...state, query: action.query };

  case types.UPDATE_CURRENT_RECORD:
    return {
      ...state,
      currentRecord: { ...state.currentRecord, ...action.updates }
    };

  case types.INVALIDATE_CURRENT_RECORD:
    return {
      ...state,
      currentRecordErrors: action.errors
    };

  case types.EDIT_RECORD_IN_MODAL:
    return {
      ...state,
      currentRecord: { ...action.record },
      currentRecordErrors: {}
    };

  case types.NEW_RECORD_IN_MODAL:
  case types.RECORD_UPDATED:
  case types.RECORD_CREATED:
    return {
      ...state,
      currentRecord: {},
      currentRecordErrors: {}
    };

  case types.RECORDS_LOAD:
    return { ...state, isFetching: true };

  case types.RECORDS_LOADED:
    if (action.append) {
      records = state.records.concat(action.records);
    } else {
      records = action.records;
    }

    return {
      ...state,
      isFetching: false,
      records: records,
      pagination: action.pagination
    };
  default:
    return state;
  }
};
