import { combineReducers } from 'redux';
import { reducer as formReducer } from 'redux-form'
import studentReducer from './StudentReducer';
import teacherReducer from './TeacherReducer';

const initial = state => state || null;

const rootReducer = combineReducers({
  initial,
  form: formReducer,
  students: studentReducer,
  teachers: teacherReducer,
});

export default rootReducer;
