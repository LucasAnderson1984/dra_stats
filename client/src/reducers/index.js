import { combineReducers } from 'redux';
import studentReducer from './StudentReducer';
import teacherReducer from './TeacherReducer';

const initial = state => state || null;

const rootReducer = combineReducers({
  initial,
  students: studentReducer,
  teachers: teacherReducer,
});

export default rootReducer;
