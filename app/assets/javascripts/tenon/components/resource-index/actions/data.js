import fetch from 'isomorphic-fetch';
import _ from 'lodash';

export const REQUEST_RECORDS = 'REQUEST_RECORDS';
export const FETCH_RECORDS = 'FETCH_RECORDS';
export const RECEIVE_RECORDS = 'RECEIVE_RECORDS';
export const UPDATE_QUERY = 'UPDATE_QUERY';
export const QUICK_SEARCH_RECORDS = 'QUICK_SEARCH_RECORDS';
export const SET_BASE_URI = 'SET_BASE_URI';
export const LOAD_NEXT_PAGE = 'LOAD_NEXT_PAGE';

export const DELETE_RECORD = 'DELETE_RECORD';
export const UPDATED_RECORD = 'UPDATED_RECORD';
export const START_UPDATE_RECORD = 'START_UPDATE_RECORD';

export const setBaseUri = (baseUri) => {
  return {
    type: SET_BASE_URI,
    baseUri: baseUri
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
    const query = _.toQueryString(state.query);

    dispatch(requestRecords);
    return fetch(state.baseUri + query, { credentials: 'same-origin' })
      .then((response) => response.json())
      .then((json) => dispatch(receiveRecords(json, append)));
  };
};

export const updateQuery = (query, append = false) => {
  return (dispatch) => {
    dispatch({
      type: UPDATE_QUERY,
      query: query
    });

    dispatch(fetchRecords(append));
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

export const startUpdate = (record) => {
  return {
    type: START_UPDATE_RECORD,
    record: record
  };
};

export const updatedRecord = (record) => {
  return {
    type: UPDATED_RECORD,
    record: record
  };
};

export const updateRecord = (record, payload) => {
  return function(dispatch) {
    dispatch(startUpdate(record));
    fetch(`${record.update_path}.json`, {
      credentials: 'same-origin',
      method: 'POST',
      body: payload
    })
    .then((response) => response.json())
    .then((json) => dispatch(updatedRecord(json.record)));
  };
};
