import {
  TOGGLE_QUICK_SEARCH, TOGGLE_EXPANDED_RECORD
} from '../actions/ui';

const initialState = {
  expandedRecordIds: [],
  quickSearchOpen: false
};

export default (state = initialState, action) => {
  switch(action.type) {
  case TOGGLE_QUICK_SEARCH:
    let newState;

    if (action.to === 'on') {
      newState = { ...state, quickSearchOpen: true };
    } else {
      newState = { ...state, quickSearchOpen: false };
    }
    return newState;
  case TOGGLE_EXPANDED_RECORD:
    // c onst id = action.record.id;
    return state;
  default:
    return state;
  }
};
