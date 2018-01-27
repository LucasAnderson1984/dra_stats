import { connect } from 'react-redux';
import { fetchTeacher } from './../actions/index'
import Teacher from './../components/teacher/Teacher'

const mapDispatchToProps = (dispatch, ownProps) => ({
   fetchTeacher: () => {
     dispatch(fetchTeacher(ownProps.match.params.id));
   },
});

const mapStateToProps = (state) => {
  const students = state.teachers.students || [];
  return {
    students: students,
    teacher: state.teachers.teacher,
  };
};

const TeacherContainer =
  connect(mapStateToProps, mapDispatchToProps)(Teacher);

export default TeacherContainer;
