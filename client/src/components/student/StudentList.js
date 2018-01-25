import React, { Component } from 'react';
import PropTypes from 'prop-types';
import StudentSearch from './StudentSearch';
import Students from './Student'

export default class StudentList extends Component {
  state = {
    count: 0,
    first_name: '',
    grade: '',
    last_name: '',
    students: [],
    tutored: '',
  };

  componentDidUpdate() {
    if(this.state.count === 0) {
      this.setState({
        count: 1,
        students: this.props.students,
      });
    }
  }

  componentDidMount() {
    this.props.fetchStudents();
  }

  filterFirstName = (name) => {
    this.setState({
      first_name: name,
    },
      () => this.setStudents()
    );
  };

  filterGrade = (grade) => {
    this.setState({
      grade: grade,
    },
      () => this.setStudents()
    );
  };

  filterLastName = (name) => {
    this.setState({
      last_name: name,
    },
      () => this.setStudents()
    );
  };

  filterStudents = () => {
    return this.props.students.filter(student =>
      student.first_name.toLowerCase().startsWith(
        this.state.first_name.toLowerCase()
      ) && student.last_name.toLowerCase().startsWith(
        this.state.last_name.toLowerCase()
      ) && student.grade.includes(
        this.state.grade
      ) && (student.is_tutored ? 'Yes' : 'No').includes(
        this.state.tutored
      )
    )
  }

  filterTutored = (tutored) => {
    this.setState({
      tutored: tutored,
    },
      () => this.setStudents()
    );
  };

  setStudents = () => {
    this.setState({
      students: this.filterStudents(),
    });
  };

  render() {
    return (
      <div>
        <h1 className='page-header'>Students</h1>
        <div>
          <StudentSearch
            filterGrade={this.filterGrade}
            filterFirstName={this.filterFirstName}
            filterLastName={this.filterLastName}
            filterTutored={this.filterTutored}
          />
        </div>
        <div>
          <table className='table table-striped'>
            <thead>
              <tr>
                <th>Last Name</th>
                <th>First Name</th>
                <th>Grade</th>
                <th>Tutored</th>
                <th>Active</th>
                <th>&nbsp;</th>
              </tr>
            </thead>
            <tbody>
              {this.state.students.map((student) => (
                <Students key={student.id} student={student} />
              ))}
            </tbody>
          </table>
        </div>
      </div>
    );
  }

  static propTypes = {
    fetchStudents: PropTypes.func,
    students: PropTypes.array,
  }
}
