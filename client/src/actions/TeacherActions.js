import { request, post } from './../lib/jsonapi';

export const FETCH_TEACHERS_FAILURE = 'FETCH_TEACHERS_FAILURE';
export const FETCH_TEACHERS_SUCCESS = 'FETCH_TEACHERS_SUCCESS';
export const FETCH_TEACHER_FAILURE = 'FETCH_TEACHER_FAILURE';
export const FETCH_TEACHER_SUCCESS = 'FETCH_TEACHER_SUCCESS';
export const CREATE_TEACHER_FAILURE = 'CREATE_TEACHER_FAILURE';
export const CREATE_TEACHER_SUCCESS = 'CREATE_TEACHER_SUCCESS';
export const CREATE_TEACHER_REQUEST = 'CREATE_TEACHER_REQUEST';

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

export function createTeacherRequest() {
  return {
    type: CREATE_TEACHER_REQUEST,
  };
}

export function createTeacherFailure(error) {
  return {
    type: CREATE_TEACHER_FAILURE,
    error,
  };
}

export function createTeacherSuccess(teacher) {
  return {
    type: CREATE_TEACHER_SUCCESS,
    teacher,
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

export function postTeacher(attributes) {
  var active = attributes.Active || attributes.Active === undefined ? 1 : 0;

  const teacherData = {
    teacher: {
      first_name: attributes.firstName,
      grade: attributes.grade.value,
      is_active: active,
      last_name: attributes.lastName,
    },
  };

  return dispatch => {
    dispatch(createTeacherRequest());
    return post('teachers', teacherData)
      .then(json => (dispatch(createTeacherSuccess(json))))
      .catch(error => dispatch(createTeacherFailure(error)))
  };
}
