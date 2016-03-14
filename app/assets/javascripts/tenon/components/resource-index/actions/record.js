import fetch from 'isomorphic-fetch';
import * as types from '../constants/action-types';
import { fetchRecords } from './list';

const jsonDefaults = {
  credentials: 'same-origin',
  headers: {
    'Accept': 'application/json',
    'Content-Type': 'application/json'
  }
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
    type: types.RECORD_DELETE,
    record: record
  };
};

const startUpdateRecord = (record, payload) => {
  return {
    type: types.RECORD_UPDATE,
    record: record,
    payload: payload
  };
};

const completeUpdateRecord = (record) => {
  return {
    type: types.RECORD_UPDATED,
    record: record
  };
};

export const updateRecord = (record, payload) => {
  return function(dispatch) {
    dispatch(startUpdateRecord(record, payload));
    fetch(`${record.update_path}.json`, {
      ...jsonDefaults,
      method: 'PUT',
      body: JSON.stringify(payload)
    })
    .then((response) => response.json())
    .then((json) => dispatch(completeUpdateRecord(json.record)));
  };
};

const startCreateRecord = (record) => {
  return {
    type: types.RECORD_CREATE,
    record: record
  };
};

const completeCreateRecord = (record) => {
  window.Tenon.features.Flash.draw('Saved successfully.');
  return {
    type: types.RECORD_CREATED,
    record: record
  };
};

const invalidateCurrentRecord = (errors) => {
  return {
    type: types.INVALIDATE_CURRENT_RECORD,
    errors: errors
  };
};

export const createRecord = (record) => {
  return function(dispatch, getState) {
    dispatch(startCreateRecord(record));
    fetch(getState().data.config.baseUri, {
      ...jsonDefaults,
      method: 'POST',
      body: JSON.stringify(record)
    })
    .then((response) => response.json())
    .then((json) => {
      if (json.errors) {
        dispatch(invalidateCurrentRecord(json.errors));
      } else {
        dispatch(completeCreateRecord(json.record));
        dispatch(fetchRecords());
      }
    });
  };
};
