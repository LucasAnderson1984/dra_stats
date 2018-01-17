import { FETCH_TEACHERS_SUCCESS } from './../actions/index';

export default function teacherReducer(state = [], action) {
  switch (action.type) {
    case FETCH_TEACHERS_SUCCESS: {
      return { ...state, all: action.teachers };
    }
    default: {
      return state;
    }
  }
}
