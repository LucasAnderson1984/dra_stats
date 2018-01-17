import React, { Component } from 'react';
import { capitalize } from './../../lib/string_conversion'

export default class TeacherList extends Component {
  render() {
    return(
      <tr key={this.props.teacher.id}>
        <td>{this.props.teacher.last_name}</td>
        <td>{this.props.teacher.first_name}</td>
        <td>{capitalize(this.props.teacher.grade)}</td>
        <td>{this.props.teacher.student_count}</td>
        <td>{capitalize((!!this.props.teacher.is_active).toString())}</td>
        <td>&nbsp;</td>
      </tr>
    );
  }
}
