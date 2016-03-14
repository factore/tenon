import * as types from '../constants/action-types';

export const updateConfig = (updates) => {
  return {
    type: types.UPDATE_CONFIG,
    updates: updates
  };
};

export const updateCurrentRecord = (updates) => {
  return {
    type: types.UPDATE_CURRENT_RECORD,
    updates: updates
  };
};
