import React, { Component } from 'react';
import PropTypes from 'prop-types';
import Select from 'react-select';
import 'react-select/dist/react-select.css';
import { GRADE_LEVELS, TUTORED_OPTIONS } from './../../lib/constants';

class StudentSearch extends Component {
  state = {
    gradeOption: '',
    tutorOption: '',
  }

  handleGradeChange = (gradeOption) => {
    const grade = gradeOption ? gradeOption.value : ''

    this.setState({ gradeOption });
    this.props.filterGrade(grade);
  }

  handleTutoredChange = (tutorOption) => {
    const tutored = tutorOption ? tutorOption.value : ''

    this.setState({ tutorOption });
    this.props.filterTutored(tutored);
  }

  onFirstNameFilter = (input) => {
    this.props.filterFirstName(input.target.value);
  }

  onLastNameFilter = (input) => {
    this.props.filterLastName(input.target.value);
  }

  render() {
    const { gradeOption, tutorOption } = this.state;
    const gradeValue = gradeOption && gradeOption.value;
    const turtorValue = tutorOption && tutorOption.value;
    const gradeOptions = Object.keys(GRADE_LEVELS).map(key => (
      { label: GRADE_LEVELS[key], value: key }
    ));
    const tutoredOptions = Object.keys(TUTORED_OPTIONS).map(key => (
      { label: TUTORED_OPTIONS[key], value: key }
    ));

    return (
      <div className='panel panel-default'>
        <div className='panel-heading'>
          <h3 className='panel-title'>Filters</h3>
        </div>
        <div className='panel-body'>
          <div className='row'>
            <div className='col-md-2'>
              <div className='form-group'>
                <input
                  className='form-control'
                  onInput={this.onLastNameFilter}
                  placeholder='Last Name'
                  type='text'
                />
              </div>
            </div>
            <div className='col-md-2'>
              <div className='form-group'>
                <input
                  className='form-control'
                  onInput={this.onFirstNameFilter}
                  placeholder='First Name'
                  type='text'
                />
              </div>
            </div>
            <div className='col-md-2'>
              <div className='form-group'>
                <Select
                  onChange={this.handleGradeChange}
                  options={ gradeOptions }
                  placeholder='Please select a grade'
                  value={gradeValue}
                />
              </div>
            </div>
            <div className='col-md-2'>
              <div className='form-group'>
                <Select
                  onChange={this.handleTutoredChange}
                  options={ tutoredOptions }
                  placeholder='Tutored?'
                  style={{ marginLeft: '25px' }}
                  value={turtorValue}
                />
              </div>
            </div>
          </div>
        </div>
      </div>
    );
  }

  static propTypes = {
    filterGrade: PropTypes.func,
    filterFirstName: PropTypes.func,
    filterLastName: PropTypes.func,
    filterTutored: PropTypes.func,
  }
}

export default StudentSearch;
