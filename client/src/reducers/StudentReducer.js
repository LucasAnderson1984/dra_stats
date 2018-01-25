import { FETCH_STUDENTS_SUCCESS } from './../actions/index';

export default function studentReducer(state = [], action) {
  switch (action.type) {
    case FETCH_STUDENTS_SUCCESS: {
      return { ...state, all: action.students };
    }
    default: {
      return state;
    }
  }
}
