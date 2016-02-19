import {
  REQUEST_RECORDS, RECEIVE_RECORDS, DELETE_RECORD,
  SET_BASE_URI, UPDATE_QUERY, START_UPDATE_RECORD
} from '../actions/data';

import queryStringObject from '../query-string-object';
import { toQueryString } from 'lodash';

const initialState = {
  records: [],
  pagination: { currentPage: 1 },
  isFetching: false,
  query: queryStringObject
};

const slowPushState = _.debounce((a, b, c) => {
  history.pushState(a, b, c);
}, 500);

export default (state = initialState, action) => {
  let records, index, query, queryString;

  switch (action.type) {
  case SET_BASE_URI:
    return { ...state, baseUri: action.baseUri };

  case UPDATE_QUERY:
    query = { ...state.query, ...action.query };
    queryString = toQueryString(query);
    slowPushState({ query: query }, queryString, queryString);
    return { ...state, query: query };

  case REQUEST_RECORDS:
    return { ...state, isFetching: true };

  case RECEIVE_RECORDS:
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

  case DELETE_RECORD:
    records = state.records.filter((el) => el.id !== action.record.id);
    return { ...state, records: records };

  case START_UPDATE_RECORD:
    records = state.records;
    index = records.index(action.record);
    records[index].isUpdating = true;
    return { ...state, records: records };
  default:
    return state;
  }
};
