import { connect } from 'react-redux';
import { fetchStudents } from './../actions/index'
import StudentList from './../components/student/StudentList'

const mapDispatchToProps = (dispatch) => ({
   fetchStudents: () => {
     dispatch(fetchStudents());
   },
});

const mapStateToProps = (state) => {
  const students = state.students.all || [];
  return { students: students };
};

const StudentsContainer =
  connect(mapStateToProps, mapDispatchToProps)(StudentList);

export default StudentsContainer;
