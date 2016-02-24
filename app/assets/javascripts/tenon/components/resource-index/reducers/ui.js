import {
  TOGGLE_QUICK_SEARCH, TOGGLE_FILTER_DRAWER, TOGGLE_EXPANDED_RECORD
} from '../actions/ui';
import queryStringObject from '../query-string-object';
import { omit } from 'lodash';

const filterKeys = Object.keys(
  omit(queryStringObject, 'q', 'page', 'order_field', 'order_direction')
);

const initialState = {
  expandedRecordIds: [],
  quickSearchOpen: (queryStringObject.q && queryStringObject.q.length),
  filterDrawerOpen: filterKeys.length
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
  case TOGGLE_QUICK_SEARCH:
    result = toggle(action.to, state.quickSearchOpen);
    return { ...state, quickSearchOpen: result };

  case TOGGLE_FILTER_DRAWER:
    result = toggle(action.to, state.filterDrawerOpen);
    return { ...state, filterDrawerOpen: result };

  case TOGGLE_EXPANDED_RECORD:
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
  default:
    return state;
  }
};
