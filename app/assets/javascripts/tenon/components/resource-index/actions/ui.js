export const TOGGLE_QUICK_SEARCH = 'TOGGLE_QUICK_SEARCH';
export const TOGGLE_EXPANDED_RECORD = 'TOGGLE_EXPANDED_RECORD';

export const toggleQuickSearch = (to) => {
  return {
    type: TOGGLE_QUICK_SEARCH,
    to: to
  };
};

export const toggleExpandedRecord = (record) => {
  return {
    type: TOGGLE_EXPANDED_RECORD,
    record: record
  };
};
