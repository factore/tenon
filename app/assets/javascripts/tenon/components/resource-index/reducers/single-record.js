import * as types from '../constants/action-types';

export default (records, action) => {
  let newRecords, index;

  const getIndex = (arr, id) => arr.map((el) => el.id).indexOf(id);

  switch (action.type) {
  case types.RECORD_DELETE:
    newRecords = records.filter((el) => el.id !== action.record.id);
    break;

  case types.RECORD_UPDATE:
    index = getIndex(records, action.record.id);
    newRecords = [
      ...records.slice(0, index),
      { ...records[index], ...action.payload, isUpdating: true },
      ...records.slice(index + 1)
    ];
    break;

  case types.RECORD_UPDATED:
  case types.RECORD_UPDATE_FAILED:
    index = getIndex(records, action.record.id);
    newRecords = [
      ...records.slice(0, index),
      { ...records[index], ...action.record, isUpdating: false },
      ...records.slice(index + 1)
    ];
    break;

  default:
    newRecords = records;
  }
  return newRecords;
};
