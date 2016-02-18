import {
  TOGGLE_QUICK_SEARCH, TOGGLE_EXPANDED_RECORD
} from '../actions/ui';

const initialState = {
  expandedRecordIds: [],
  quickSearchOpen: false
};

export default (state = initialState, action) => {
  switch (action.type) {
  case TOGGLE_QUICK_SEARCH:
    let newState;

    if (action.to === 'on') {
      newState = { ...state, quickSearchOpen: true };
    } else {
      newState = { ...state, quickSearchOpen: false };
    }
    return newState;
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
