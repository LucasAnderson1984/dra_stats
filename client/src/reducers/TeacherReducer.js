import {
          FETCH_TEACHERS_SUCCESS,
          FETCH_TEACHER_SUCCESS,
          CREATE_TEACHER_SUCCESS,
       } from './../actions/index';

export default function teacherReducer(state = [], action) {
  switch (action.type) {
    case FETCH_TEACHER_SUCCESS: {
      return { ...state, teacher: action.teacher, students: action.students };
    }
    case FETCH_TEACHERS_SUCCESS: {
      return { ...state, all: action.teachers };
    }
    case CREATE_TEACHER_SUCCESS: {
      console.log('Post Teacher Success');
      return { ...state, teacher: action.teacher };
    }
    default: {
      return state;
    }
  }
}
