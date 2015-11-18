import {
  REQUEST_RECORDS, RECEIVE_RECORDS, DELETE_RECORD,
  SET_BASE_URI, UPDATE_QUERY, START_UPDATE_RECORD
} from '../actions/index';

const initialState = {
  records: [],
  pagination: {currentPage: 1},
  isFetching: false,
  query: {page: 1}
};

export default(state = initialState, action) => {
  let records;

  switch (action.type) {
  case SET_BASE_URI:
    return {...state, baseUri: action.baseUri};
  case UPDATE_QUERY:
    return {
      ...state,
      query: {...state.query, ...action.query}
    };
  case REQUEST_RECORDS:
    return {...state, isFetching: true};
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
    const newRecords = state.records.filter((el) => el.id !== action.record.id);

    return {...state, records: newRecords};
  case START_UPDATE_RECORD:
    records = state.records;
    const index = records.index(action.record);

    records[index].isUpdating = true;
    return {...state, records: records};
  default:
    return state;
  }
};
