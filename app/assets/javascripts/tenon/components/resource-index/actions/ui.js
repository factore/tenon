import * as types from '../constants/action-types';

export const toggleQuickSearch = (to) => {
  return {
    type: types.TOGGLE_QUICK_SEARCH,
    to: to
  };
};

export const toggleModalForm = (to) => {
  return {
    type: types.TOGGLE_MODAL_FORM,
    to: to
  };
};

export const toggleFilterDrawer = (to = 'opposite') => {
  return {
    type: types.TOGGLE_FILTER_DRAWER,
    to: to
  };
};

export const toggleExpandedRecord = (record) => {
  return {
    type: types.TOGGLE_EXPANDED_RECORD,
    record: record
  };
};
