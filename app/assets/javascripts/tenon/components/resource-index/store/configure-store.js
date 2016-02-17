import { createStore, applyMiddleware, combineReducers } from 'redux';
import thunk from 'redux-thunk';
import uiReducer from '../reducers/ui';
import dataReducer from '../reducers/data';

const createStoreWithMiddleware = applyMiddleware(
  thunk
)(createStore);

export default function configureStore(initialState) {
  const reducers = combineReducers({
    ui: uiReducer,
    data: dataReducer
  });

  return createStoreWithMiddleware(reducers, initialState);
}
