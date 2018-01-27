import React, { Component } from 'react';
import PropTypes from 'prop-types';
import { Link } from 'react-router-dom';
import { capitalize } from './../../lib/string_conversion';
import Students from './../student/Students';

export default class Teachers extends Component {
  state = {
    count: 0,
    students: [],
    teacher: {
      first_name: 'Teacher',
      grade: '',
      is_active: 0,
      last_name: '',
    },
  }

  componentDidMount() {
    this.props.fetchTeacher();
  }

  componentDidUpdate() {
    if(this.state.count === 0) {
      this.setState({
        count: 1,
        teacher: this.props.teacher,
        students: this.props.students,
      });
    }
  }

  render() {
    const full_name = this.state.teacher.first_name +
                      ' ' +
                      this.state.teacher.last_name;

    return(
      <div>
        <div className='page-header'>
          <h2>{ full_name }
            <span>
              <Link className='pull-right btn btn-link' to='/teachers'>
                Back to Teachers
              </ Link>
              </span>
          </h2>
        </div>
        <div className='form form-horizontal'>
          <div className='form-group'>
            <label className='col-md-1 control-label'>Grade:</label>
            <p className='col-md-1 form-control-static'>
              { capitalize(this.state.teacher.grade) }
            </p>
          </div>
          <div className='form-group'>
            <label className='col-md-1 control-label'>Active:</label>
            <p className='col-md-1 form-control-static'>
              { capitalize((!!this.state.teacher.is_active).toString()) }
            </p>
          </div>
        </div>
        {
          this.state.students.length > 0 &&
          <div>
            <h2 className='page-header'>Students</h2>
            <div>
              <table className='table table-striped'>
                <thead>
                  <tr>
                    <th>Student ID Number</th>
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
        }
      </div>
    );
  }

  static propTypes = {
    fetchTeacher: PropTypes.func,
    match: PropTypes.object,
    students: PropTypes.array,
    teacher: PropTypes.object,
  }
}
