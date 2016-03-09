import fetch from 'isomorphic-fetch';
import { toQueryString, debounce } from 'lodash';

export const REQUEST_RECORDS = 'REQUEST_RECORDS';
export const FETCH_RECORDS = 'FETCH_RECORDS';
export const RECEIVE_RECORDS = 'RECEIVE_RECORDS';
export const UPDATE_QUERY = 'UPDATE_QUERY';
export const QUICK_SEARCH_RECORDS = 'QUICK_SEARCH_RECORDS';
export const UPDATE_CONFIG = 'UPDATE_CONFIG';
export const LOAD_NEXT_PAGE = 'LOAD_NEXT_PAGE';

export const DELETE_RECORD = 'DELETE_RECORD';
export const START_UPDATE_RECORD = 'START_UPDATE_RECORD';
export const COMPLETE_UPDATE_RECORD = 'COMPLETE_UPDATE_RECORD';

export const updateConfig = (updates) => {
  return {
    type: UPDATE_CONFIG,
    updates: updates
  };
};

export const requestRecords = () => {
  return {
    type: REQUEST_RECORDS
  };
};

export const receiveRecords = (json, append) => {
  return {
    type: RECEIVE_RECORDS,
    records: json.records,
    pagination: json.pagination,
    append: append
  };
};

export const fetchRecords = (append = false) => {
  return function(dispatch, getState) {
    const state = getState().data;
    const query = toQueryString(state.query);

    dispatch(requestRecords);
    return fetch(state.config.baseUri + query, { credentials: 'same-origin' })
      .then((response) => response.json())
      .then((json) => dispatch(receiveRecords(json, append)));
  };
};

const debouncedFetchRecords = debounce((dispatch, append = false) => {
  dispatch(fetchRecords(append));
}, 500);

export const updateQuery = (query, append = false) => {
  return (dispatch) => {
    dispatch({
      type: UPDATE_QUERY,
      query: query
    });

    debouncedFetchRecords(dispatch, append);
  };
};

export const loadNextPage = () => {
  return function(dispatch, getState) {
    const nextPage = getState().data.pagination.currentPage + 1;

    dispatch(updateQuery({ page: nextPage }, true));
  };
};

export const deleteRecord = (record) => {
  // Don't rely on this call to dispatch the action,
  // we're just going to naively assume that it will
  // never fail.
  fetch(`${record.destroy_path}.json`, {
    credentials: 'same-origin',
    method: 'DELETE'
  });
  return {
    type: DELETE_RECORD,
    record: record
  };
};

export const startUpdateRecord = (record, payload) => {
  return {
    type: START_UPDATE_RECORD,
    record: record,
    payload: payload
  };
};

export const completeUpdateRecord = (record) => {
  return {
    type: COMPLETE_UPDATE_RECORD,
    record: record
  };
};

export const updateRecord = (record, payload) => {
  return function(dispatch) {
    dispatch(startUpdateRecord(record, payload));
    fetch(`${record.update_path}.json`, {
      credentials: 'same-origin',
      method: 'PUT',
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({ [record.resource_type]: payload })
    })
    .then((response) => response.json())
    .then((json) => dispatch(completeUpdateRecord(json)));
  };
};
