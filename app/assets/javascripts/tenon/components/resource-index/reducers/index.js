import {
  REQUEST_RECORDS, RECEIVE_RECORDS, FETCH_RECORDS, DELETE_RECORD
} from '../actions/index'

const initialState = {
  records: [],
  page: 1,
  isFetching: false
}

export default (state = initialState, action) => {
  switch (action.type) {
  case REQUEST_RECORDS:
    state = { ...state, isFetching: true };
    return state;
  case RECEIVE_RECORDS:
    state = {
      ...state,
      isFetching: false,
      records: action.records
    };
    console.log(state);
    return state;
  case DELETE_RECORD:
    let newRecords = state.records.filter(el => el.id !== action.record.id);
    state = {
      ...state,
      records: newRecords
    }
    return state;
  default:
    return state;
  };
}
