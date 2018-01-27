import { request } from './../lib/jsonapi';

export const FETCH_TEACHERS_FAILURE = 'FETCH_TEACHERS_FAILURE';
export const FETCH_TEACHERS_SUCCESS = 'FETCH_TEACHERS_SUCCESS';
export const FETCH_TEACHER_FAILURE = 'FETCH_TEACHER_FAILURE';
export const FETCH_TEACHER_SUCCESS = 'FETCH_TEACHER_SUCCESS';

export function fetchTeacherFailure(error) {
  return {
    type: FETCH_TEACHER_FAILURE,
    error,
  };
}

export function fetchTeachersFailure(error) {
  return {
    type: FETCH_TEACHERS_FAILURE,
    error,
  };
}

export function fetchTeacherSuccess(teacher, students) {
  return {
    type: FETCH_TEACHER_SUCCESS,
    teacher,
    students,
  };
}

export function fetchTeachersSuccess(teachers) {
  return {
    type: FETCH_TEACHERS_SUCCESS,
    teachers,
  };
}

export function fetchTeacher(teacher_id) {
  return dispatch => {
    const teacher_url = `teachers/${teacher_id}`;
    return request(teacher_url)
      .then(teacher_json => {
        dispatch(
          request(`${teacher_url}/students`)
          .then(student_json => {
            dispatch(fetchTeacherSuccess(teacher_json, student_json))
          })
          .catch(error => dispatch(fetchTeachersFailure(error)))
        )
      })
      .catch(error => dispatch(fetchTeachersFailure(error)))
  };
}

export function fetchTeachers() {
  return dispatch => {
    return request('teachers')
      .then(json => (dispatch(fetchTeachersSuccess(json))))
      .catch(error => dispatch(fetchTeachersFailure(error)))
  };
}
