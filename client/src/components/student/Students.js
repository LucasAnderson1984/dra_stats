import React, { Component } from 'react';
import PropTypes from 'prop-types';
import { capitalize } from './../../lib/string_conversion';

export default class Students extends Component {
  render() {
    return(
      <tr key={this.props.student.id}>
        <td>{this.props.student.student_id_number}</td>
        <td>{this.props.student.last_name}</td>
        <td>{this.props.student.first_name}</td>
        <td>{capitalize(this.props.student.grade)}</td>
        <td>{this.props.student.is_tutored ? 'Yes' : 'No'}</td>
        <td>{capitalize((!!this.props.student.is_active).toString())}</td>
        <td>&nbsp;</td>
      </tr>
    );
  }

  static propTypes = {
    student: PropTypes.object.isRequired,
  }
}
