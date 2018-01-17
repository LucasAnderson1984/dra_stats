import { request } from './../lib/jsonapi';

export const FETCH_TEACHERS_FAILURE = 'FETCH_TEACHERS_FAILURE';
export const FETCH_TEACHERS_SUCCESS = 'FETCH_TEACHERS_SUCCESS';

export function fetchTeachersFailure(error) {
  return {
    type: FETCH_TEACHERS_FAILURE,
    error,
  };
}

export function fetchTeachersSuccess(teachers) {
  return {
    type: FETCH_TEACHERS_SUCCESS,
    teachers,
  };
}

export function fetchTeachers() {
  return dispatch => {
    return request('teachers')
      .then(json => (dispatch(fetchTeachersSuccess(json))))
      .catch(error => dispatch(fetchTeachersFailure(error)))
  };
}
