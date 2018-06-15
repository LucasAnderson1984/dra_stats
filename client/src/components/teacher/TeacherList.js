import React, { Component } from 'react';
import PropTypes from 'prop-types';
import TeacherSearch from './TeacherSearch';
import Teachers from './Teachers';
import NewTeacher from './NewTeacher';

export default class TeacherList extends Component {
  state = {
    count: 0,
    first_name: '',
    grade: '',
    last_name: '',
    openModal: false,
    teachers: [],
  };

  componentDidUpdate() {
    if(this.state.count === 0) {
      this.setState({
        count: 1,
        teachers: this.props.teachers,
      });
    }
  }

  componentDidMount() {
    this.props.fetchTeachers();
  }

  filterFirstName = (name) => {
    this.setState({
      first_name: name,
    }, () => this.setTeachers());
  };

  filterGrade = (grade) => {
    this.setState({
      grade: grade,
    }, () => this.setTeachers());
  };

  filterLastName = (name) => {
    this.setState({
      last_name: name,
    }, () => this.setTeachers());
  };

  filterTeachers = () => {
    return this.props.teachers.filter(teacher =>
      teacher.last_name.toLowerCase().startsWith(
        this.state.last_name.toLowerCase()
      ) && teacher.first_name.toLowerCase().startsWith(
        this.state.first_name.toLowerCase()
      ) && teacher.grade.includes(
        this.state.grade
      )
    );
  };

  handleModal = (status) => {
    this.setState({
      openModal: status,
      teachers: this.props.teachers,
    }, () => this.setTeachers());
  };

  openModal = () => {
    this.setState({
      openModal: true,
    });
  };

  setTeachers = () => {
    this.setState({
      teachers: this.filterTeachers(),
    });
  };

  render() {
    return (
      <div>
        <NewTeacher
          handleModal={this.handleModal}
          openModal={this.state.openModal}
        />
        <h2 className='page-header'>Teachers</h2>
        <div>
          <TeacherSearch
            filterFirstName={this.filterFirstName}
            filterLastName={this.filterLastName}
            filterGrade={this.filterGrade}
          />
        </div>
        <div>
          <table className='table table-striped'>
            <thead>
              <tr>
                <th>Last Name</th>
                <th>First Name</th>
                <th>Grade</th>
                <th>Number of Students</th>
                <th>Active</th>
                <th>
                  <button
                    className='btn btn-primary glyphicon glyphicon-plus'
                    onClick={this.openModal}
                  />
                </th>
              </tr>
            </thead>
            <tbody>
              {this.state.teachers.map((teacher) => (
                <Teachers key={teacher.id} teacher={teacher} />
              ))}
            </tbody>
          </table>
        </div>
      </div>
    );
  }

  static propTypes = {
    fetchTeachers: PropTypes.func,
    teachers: PropTypes.array,
  }
}
