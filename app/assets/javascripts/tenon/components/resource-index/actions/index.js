import fetch from 'isomorphic-fetch';

export const REQUEST_RECORDS = 'REQUEST_RECORDS';
export const FETCH_RECORDS = 'FETCH_RECORDS';
export const RECEIVE_RECORDS = 'RECEIVE_RECORDS';
export const DELETE_RECORD = 'DELETE_RECORD';

export function requestRecords () {
  return {
    type: REQUEST_RECORDS
  }
}

export function receiveRecords (records) {
  return {
    type: RECEIVE_RECORDS,
    records: records
  }
}

export function fetchRecords (baseUri) {
  return function (dispatch) {
    dispatch(requestRecords);
    return fetch(baseUri, { credentials: 'same-origin'})
      .then( response => response.json() )
      .then( json => dispatch(receiveRecords(json.records)) );
  };
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
