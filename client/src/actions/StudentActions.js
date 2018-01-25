import { request } from './../lib/jsonapi';

export const FETCH_STUDENTS_FAILURE = 'FETCH_STUDENTS_FAILURE';
export const FETCH_STUDENTS_SUCCESS = 'FETCH_STUDENTS_SUCCESS';

export function fetchStudentsFailure(error) {
  return {
    type: FETCH_STUDENTS_FAILURE,
    error,
  };
}

export function fetchStudentsSuccess(students) {
  return {
    type: FETCH_STUDENTS_SUCCESS,
    students,
  };
}

export function fetchStudents() {
  return dispatch => {
    return request('students')
      .then(json => (dispatch(fetchStudentsSuccess(json))))
      .catch(error => dispatch(fetchStudentsFailure(error)))
  };
}
