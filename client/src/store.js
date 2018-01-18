import rootReducer from './reducers';
import { applyMiddleware, createStore } from 'redux';
import thunkMiddleware from 'redux-thunk';

const initialState = {};

export const store = createStore(
  rootReducer,
  initialState,
  applyMiddleware(thunkMiddleware)
);
