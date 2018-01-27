import React, { Component } from 'react';
import PropTypes from 'prop-types';
import Select from 'react-select';
import 'react-select/dist/react-select.css';
import { GRADE_LEVELS } from './../../lib/constants';

class TeacherSearch extends Component {
  state = {
    selectedOption: '',
  }

  handleChange = (selectedOption) => {
    const grade = selectedOption ? selectedOption.value : ''

    this.setState({ selectedOption });
    this.props.filterGrade(grade);
  }

  onFirstNameFilter = (input) => {
    this.props.filterFirstName(input.target.value);
  }

  onLastNameFilter = (input) => {
    this.props.filterLastName(input.target.value);
  }

  render() {
    const { selectedOption } = this.state;
    const value = selectedOption && selectedOption.value;
    const gradeOptions = Object.keys(GRADE_LEVELS).map(key => (
      { label: GRADE_LEVELS[key], value: key }
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
                  placeholder='Please select a grade'
                  style={{width: '180px'}}
                  value={value}
                  onChange={this.handleChange}
                  options={ gradeOptions }
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
  }
}

export default TeacherSearch;
