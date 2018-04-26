import React, { Component } from 'react';
import PropTypes from 'prop-types';
import Select from 'react-select';
import { Field, reduxForm } from 'redux-form';
import { GRADE_LEVELS } from './../../lib/constants';

export class TeacherForm extends Component {
  state = {
    selectedOption: '',
  }

  handleChange = (selectedOption) => {
    this.setState({ selectedOption });
  }

  render() {
    const { handleSubmit, onClose } = this.props;
    const { selectedOption } = this.state;
    const value = selectedOption && selectedOption.value;
    const gradeOptions = Object.keys(GRADE_LEVELS).map(key => (
      { label: GRADE_LEVELS[key], value: key }
    ));

    const renderSelect = ({input, options}) => {
      return <Select
        placeholder='Please select a grade'
        style={{width: '180px'}}
        value={ input.value }
        onChange={ input.onChange }
        options={ options }
      />
    }

    const checkbox = props => {
      var checked = props.input.value === '' ? true : props.input.value;
      return (
        <input
          { ...props.input }
          type="checkbox"
          checked={ checked }
          value={ checked }
        />
      );
    }

    return(
      <form className='form' onSubmit={ handleSubmit }>
        <div className="form-group">
          <Field
            className="form-control"
            component="input"
            name="firstName"
            placeholder="First Name"
            type="text"
          />
        </div>
        <div className="form-group">
          <Field
            className="form-control"
            component="input"
            name="lastName"
            placeholder="Last Name"
            type="text"
          />
        </div>
        <div className="form-group">
          <Field
            className="form-control"
            component={ renderSelect }
            name="grade"
            onChange={ this.handleChange }
            options={ gradeOptions }
            value={ value }
          />
        </div>
        <div className="form-group">
          <div className="checkbox">
            <label>
              <Field
                component={checkbox}
                id="active"
                name="Active"
                value="true"
              />
              Active
            </label>
          </div>
        </div>
        <div className="form-group text-center">
          <button
            className="btn btn-primary"
            type="submit"
          >
            Submit
          </button>
          <button className="btn btn-default" onClick={ onClose }>
            Cancel
          </button>
        </div>
      </form>
    )
  }

  static propTypes = {
    handleSubmit: PropTypes.func,
    onClose: PropTypes.func,
    onSubmit: PropTypes.func,
  }
}

export default reduxForm({
  form: 'teacher',
})(TeacherForm);
