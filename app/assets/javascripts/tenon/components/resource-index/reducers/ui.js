import * as types from '../constants/action-types';
import queryStringObject from '../query-string-object';
import { omit } from 'lodash';

const filterKeys = Object.keys(
  omit(queryStringObject, 'q', 'page', 'order_field', 'order_direction')
);

const initialState = {
  expandedRecordIds: [],
  quickSearchOpen: (queryStringObject.q && queryStringObject.q.length),
  filterDrawerOpen: filterKeys.length,
  modalFormActive: false
};

const toggle = (to, obj) => {
  if (to === 'on') {
    return true;
  } else if (to === 'off') {
    return false;
  } else {
    return !obj;
  }
};

export default (state = initialState, action) => {
  let result;

  switch (action.type) {
  case types.TOGGLE_QUICK_SEARCH:
    result = toggle(action.to, state.quickSearchOpen);
    return { ...state, quickSearchOpen: result };

  case types.TOGGLE_FILTER_DRAWER:
    result = toggle(action.to, state.filterDrawerOpen);
    return { ...state, filterDrawerOpen: result };

  case types.TOGGLE_MODAL_FORM:
    result = toggle(action.to, state.modalFormActive);
    return { ...state, modalFormActive: result };

  case types.TOGGLE_EXPANDED_RECORD:
    const id = action.record.id;
    const index = state.expandedRecordIds.indexOf(action.record.id);
    let newExpandedRecordIds;

    if (index === -1) {
      newExpandedRecordIds = [...state.expandedRecordIds, id];
    } else {
      newExpandedRecordIds = [
        ...state.expandedRecordIds.slice(0, index),
        ...state.expandedRecordIds.slice(index + 1)
      ];
    }

    return { ...state, expandedRecordIds: newExpandedRecordIds };

  case types.RECORD_IN_MODAL_UPDATED:
  case types.RECORD_IN_MODAL_CREATED:
    return { ...state, modalFormActive: false };

  case types.NEW_RECORD_IN_MODAL:
  case types.EDIT_RECORD_IN_MODAL:
    return { ...state, modalFormActive: true };

  default:
    return state;
  }
};
