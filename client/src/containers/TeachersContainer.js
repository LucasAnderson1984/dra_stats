import { connect } from 'react-redux';
import { fetchTeachers } from './../actions/index'
import TeacherList from './../components/teacher/TeacherList'

const mapDispatchToProps = (dispatch) => ({
   fetchTeachers: () => {
     dispatch(fetchTeachers());
   },
});

const mapStateToProps = (state) => {
  const teachers = state.teachers.all || [];
  return { teachers: teachers };
};

const TeachersContainer =
  connect(mapStateToProps, mapDispatchToProps)(TeacherList);

export default TeachersContainer;
