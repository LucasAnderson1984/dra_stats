import { combineReducers } from 'redux';
import teacherReducer from './TeacherReducer';

const initial = state => state || null;

const rootReducer = combineReducers({
  initial,
  teachers: teacherReducer,
});

export default rootReducer;
