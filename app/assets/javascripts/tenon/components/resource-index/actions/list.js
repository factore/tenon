import fetch from 'isomorphic-fetch';
import { toQueryString, debounce } from 'lodash';
import * as types from '../constants/action-types';

export const loadRecords = () => {
  return {
    type: types.RECORDS_LOAD
  };
};

export const loadedRecords = (json, append = false) => {
  return {
    type: types.RECORDS_LOADED,
    records: json.records,
    pagination: json.meta.pagination,
    append: append
  };
};

export const fetchRecords = (append = false) => {
  return function(dispatch, getState) {
    const state = getState().data;
    const query = toQueryString(state.query);

    dispatch(loadRecords);
    return fetch(state.config.baseUri + query, { credentials: 'same-origin' })
      .then((response) => response.json())
      .then((json) => dispatch(loadedRecords(json, append)));
  };
};

const debouncedFetchRecords = debounce((dispatch, append = false) => {
  dispatch(fetchRecords(append));
}, 500);

export const updateQuery = (query, append = false) => {
  return (dispatch) => {
    dispatch({
      type: types.UPDATE_QUERY,
      query: query
    });

    debouncedFetchRecords(dispatch, append);
  };
};

export const loadNextPage = () => {
  return function(dispatch, getState) {
    const nextPage = getState().data.pagination.currentPage + 1;

    dispatch(updateQuery({ page: nextPage }, true));
  };
};
