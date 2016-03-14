import * as types from '../constants/action-types';
import queryStringObject from '../query-string-object';
import { toQueryString } from 'lodash';
import singleRecordReducer from './single-record';

const initialState = {
  records: [],
  currentRecord: {},
  pagination: { currentPage: 1 },
  isFetching: true,
  query: queryStringObject,
  config: {
    manageQueryString: true
  }
};

const slowPushState = _.debounce((a, b, c) => {
  history.pushState(a, b, c);
}, 500);

export default (state = initialState, action) => {
  let records, query, queryString;

  switch (action.type) {
  case types.RECORD_DELETE:
  case types.RECORD_UPDATE:
  case types.RECORD_UPDATED:
  case types.RECORD_UPDATE_FAIL:
  case types.RECORD_CREATE:
  case types.RECORD_CREATED:
  case types.RECORD_CREATE_FAIL:
    return { ...state, records: singleRecordReducer(state.records, action) };

  case types.UPDATE_CONFIG:
    return { ...state, config: { ...state.config, ...action.updates } };

  case types.UPDATE_QUERY:
    query = { ...state.query, ...action.query };
    if (state.config.manageQueryString) {
      queryString = toQueryString(query);
      slowPushState({ query: query }, queryString, queryString);
    }
    return { ...state, query: query };

  case types.UPDATE_CURRENT_RECORD:
    return {
      ...state,
      currentRecord: { ...state.currentRecord, ...action.updates }
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
