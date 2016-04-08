import fetch from 'isomorphic-fetch';
import * as types from '../constants/action-types';
import { fetchRecords } from './list';
import { isEmpty } from 'lodash';

const jsonDefaults = {
  credentials: 'same-origin',
  headers: {
    'Accept': 'application/json',
    'Content-Type': 'application/json'
  }
};

const checkStatus = (response) => {
  const { status, statusText } = response;

  if (status < 200 || (status > 299 && status !== 422)) {
    const error = new Error(statusText);

    error.response = response;
    throw error;
  } else {
    return response;
  }
};

export const editRecordInModal = (record) => {
  return {
    type: types.EDIT_RECORD_IN_MODAL,
    record: record
  };
};

export const newRecordInModal = () => {
  return {
    type: types.NEW_RECORD_IN_MODAL
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
    type: types.RECORD_DELETE,
    record: record
  };
};

const invalidateCurrentRecord = (errors) => {
  return {
    type: types.INVALIDATE_CURRENT_RECORD,
    errors: errors
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
  window.Tenon.features.Flash.draw('Saved successfully.');
  return {
    type: types.RECORD_UPDATED,
    record: record
  };
};

const failUpdateRecord = (record) => {
  return {
    type: types.RECORD_UPDATE_FAILED,
    record: record
  };
};

export const updateRecord = (record, payload) => {
  return function(dispatch) {
    dispatch(startUpdateRecord(record, payload));
    return fetch(`${record.update_path}.json`, {
      ...jsonDefaults,
      method: 'PUT',
      body: JSON.stringify(payload)
    })
    .then(checkStatus)
    .then((response) => response.json())
    .then((json) => {
      if (json.errors) {
        dispatch(invalidateCurrentRecord(json.errors));

        // Revert edits
        dispatch(startUpdateRecord(record, record));
        dispatch(failUpdateRecord(record));
      } else {
        dispatch(completeUpdateRecord(json.record));
      }
    }).catch(() => {
      const msg = 'There was an error saving this.  Make sure you filled out ' +
                  'all the fields.';

      dispatch(invalidateCurrentRecord({ base: [msg] }));
    });
  };
};

export const updateRecordInModal = (payload) => {
  return function(dispatch, getState) {
    const records = getState().data.records;
    const record = records.filter((r) => r.id === payload.id)[0];

    dispatch(updateRecord(record, payload))
    .then(() => {
      if (isEmpty(getState().data.currentRecordErrors)) {
        dispatch({
          type: types.RECORD_IN_MODAL_UPDATED,
          record: record
        });
      }
    });
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

export const createRecord = (record) => {
  return function(dispatch, getState) {
    dispatch(startCreateRecord(record));
    return fetch(getState().data.config.baseUri, {
      ...jsonDefaults,
      method: 'POST',
      body: JSON.stringify(record)
    })
    .then((response) => response.json())
    .then(checkStatus)
    .then((json) => {
      if (json.errors) {
        dispatch(invalidateCurrentRecord(json.errors));
      } else {
        dispatch(completeCreateRecord(json.record));
        dispatch(fetchRecords());
      }
    }).catch(() => {
      const msg = 'There was an error saving this.  Make sure you filled out ' +
                  'all the fields.';

      dispatch(invalidateCurrentRecord({ base: [msg] }));
    });
  };
};

export const createRecordInModal = (record) => {
  return function(dispatch, getState) {
    dispatch(createRecord(record))
    .then(() => {
      if (isEmpty(getState().data.currentRecordErrors)) {
        dispatch({
          type: types.RECORD_IN_MODAL_CREATED,
          record: record
        });
      }
    });
  };
};
