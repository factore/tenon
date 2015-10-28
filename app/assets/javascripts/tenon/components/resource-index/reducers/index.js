import {
  REQUEST_RECORDS, RECEIVE_RECORDS, FETCH_RECORDS, DELETE_RECORD,
  SET_BASE_URI, UPDATE_QUERY
} from '../actions/index'

const initialState = {
  records: [],
  isFetching: false,
  query: { page: 1 }
}

export default (state = initialState, action) => {
  switch (action.type) {
  case SET_BASE_URI:
    state = { ...state, baseUri: action.baseUri };
    return state;
  case UPDATE_QUERY:
    state = {
      ...state,
      query: { ...state.query, ...action.query }
    };
    return state;
  case REQUEST_RECORDS:
    state = { ...state, isFetching: true };
    return state;
  case RECEIVE_RECORDS:
    state = {
      ...state,
      isFetching: false,
      records: action.records
    };
    return state;
  case DELETE_RECORD:
    let newRecords = state.records.filter(el => el.id !== action.record.id);
    state = {
      ...state,
      records: newRecords
    };
    return state;
  default:
    return state;
  };
}
