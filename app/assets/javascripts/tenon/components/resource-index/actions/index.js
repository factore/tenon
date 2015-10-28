import fetch from 'isomorphic-fetch';
import _ from 'lodash'

export const REQUEST_RECORDS = 'REQUEST_RECORDS';
export const FETCH_RECORDS = 'FETCH_RECORDS';
export const RECEIVE_RECORDS = 'RECEIVE_RECORDS';
export const DELETE_RECORD = 'DELETE_RECORD';
export const UPDATE_QUERY = 'UPDATE_QUERY';
export const QUICK_SEARCH_RECORDS = 'QUICK_SEARCH_RECORDS';
export const SET_BASE_URI = 'SET_BASE_URI';
export const LOAD_NEXT_PAGE = 'LOAD_NEXT_PAGE';

export function setBaseUri (baseUri) {
  return {
    type: SET_BASE_URI,
    baseUri: baseUri
  }
}

export function requestRecords () {
  return {
    type: REQUEST_RECORDS
  }
}

export function receiveRecords (json, append) {
  return {
    type: RECEIVE_RECORDS,
    records: json.records,
    pagination: json.pagination,
    append: append
  }
}

export function fetchRecords (append = false) {
  return function (dispatch, getState) {
    const state = getState();
    let query = _.toQueryString(state.query);
    dispatch(requestRecords);
    return fetch(state.baseUri + query, { credentials: 'same-origin'})
      .then( response => response.json() )
      .then( json => dispatch(receiveRecords(json, append)) );
  };
}

export function updateQuery (query) {
  return {
    type: UPDATE_QUERY,
    query: query
  }
}

export function loadNextPage () {
  return function (dispatch, getState) {
    let nextPage = getState().pagination.currentPage + 1;
    dispatch(updateQuery({ page: nextPage }));
    dispatch(fetchRecords(true));
  }
}

export function quickSearchRecords (query) {
  return function (dispatch) {
    dispatch(updateQuery({ q: query, page: 1 }))
    dispatch(fetchRecords())
  }
}

export function deleteRecord (record) {
  // Don't rely on this call to dispatch the action,
  // we're just going to naively assume that it will
  // never fail.
  fetch(`${record.destroy_path}.json`, {
    credentials: 'same-origin',
    method: 'DELETE'
  })
  return {
    type: DELETE_RECORD,
    record: record
  }
}
