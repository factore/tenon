import fetch from 'isomorphic-fetch';
import { toQueryString, debounce } from 'lodash';
import * as types from '../constants/action-types';
import Cookies from 'cookies-js';

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

    dispatch(loadRecords());
    return fetch(state.config.baseUri + query, { credentials: 'same-origin' })
      .then((response) => response.json())
      .then((json) => dispatch(loadedRecords(json, append)));
  };
};

export const reorderRecords = (ids) => {
  return (dispatch, getState) => {
    const state = getState().data;

    fetch(`${state.config.reorderUri}.json`, {
      credentials: 'same-origin',
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      },
      method: 'POST',
      body: JSON.stringify({ ids: ids })
    })
    .then(() => Tenon.features.Flash.draw('Saved successfully.'));
  };
};

const debouncedFetchRecords = debounce((dispatch, append = false) => {
  dispatch(fetchRecords(append));
}, 500);

const debouncedPushState = _.debounce((a, b, c) => {
  history.pushState(a, b, c);
}, 500);

const updateQueryString = (query) => {
  const queryString = toQueryString(query);

  debouncedPushState({ query: query }, queryString, queryString);
};

const updateQueryCookie = (query, baseUri) => {
  Cookies.set(`last-query-${baseUri}`, JSON.stringify(query));
};

const queryChange = (type, query, append, dispatch, getState) => {
  dispatch({
    type: type,
    query: query
  });

  const { data } = getState();

  if (data.config.manageQueryString) {
    updateQueryString(data.query);
    updateQueryCookie(data.query, data.config.baseUri);
  }

  debouncedFetchRecords(dispatch, append);
};

export const updateQuery = (query, append = false) => {
  return (dispatch, getState) => {
    queryChange(types.UPDATE_QUERY, query, append, dispatch, getState);
  };
};

export const replaceQuery = (query, append = false) => {
  return (dispatch, getState) => {
    queryChange(types.REPLACE_QUERY, query, append, dispatch, getState);
  };
};

export const loadNextPage = () => {
  return function(dispatch, getState) {
    const nextPage = getState().data.pagination.current_page + 1;
    dispatch(loadRecords());
    dispatch(updateQuery({ page: nextPage }, true));
  };
};


