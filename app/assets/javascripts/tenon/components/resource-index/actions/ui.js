export const TOGGLE_QUICK_SEARCH = 'TOGGLE_QUICK_SEARCH';
export const TOGGLE_FILTER_DRAWER = 'TOGGLE_FILTER_DRAWER';
export const TOGGLE_EXPANDED_RECORD = 'TOGGLE_EXPANDED_RECORD';

export const toggleQuickSearch = (to) => {
  return {
    type: TOGGLE_QUICK_SEARCH,
    to: to
  };
};

export const toggleFilterDrawer = (to = 'opposite') => {
  return {
    type: TOGGLE_FILTER_DRAWER,
    to: to
  };
};

export const toggleExpandedRecord = (record) => {
  return {
    type: TOGGLE_EXPANDED_RECORD,
    record: record
  };
};
