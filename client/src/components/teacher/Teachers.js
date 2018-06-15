import React, { Component } from 'react';
import PropTypes from 'prop-types';
import { Link } from 'react-router-dom';
import { capitalize } from './../../lib/string_conversion';

export default class Teachers extends Component {
  render() {
    return(
      <tr key={this.props.teacher.id}>
        <td>{this.props.teacher.last_name}</td>
        <td>{this.props.teacher.first_name}</td>
        <td>{capitalize(this.props.teacher.grade)}</td>
        <td>{this.props.teacher.student_count}</td>
        <td>{capitalize((!!this.props.teacher.is_active).toString())}</td>
        <td>
          <Link className='btn btn-success btn-sm glyphicon glyphicon-search'
                to={`teachers/${this.props.teacher.id}`} />
        </td>
      </tr>
    );
  }

  static propTypes = {
    teacher: PropTypes.object.isRequired,
  }
}
