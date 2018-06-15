import React, { Component } from 'react';
import ReactModal from 'react-modal';
import PropTypes from 'prop-types';
import { CUSTOM_STYLES } from './../../lib/constants';
import TeacherForm from './TeacherForm';
import { postTeacher, fetchTeachers } from './../../actions/index'

export default class NewTeacher extends Component {
  submit = (values, dispatch) => {
    dispatch(postTeacher(values))
      .then(() => dispatch(fetchTeachers()))
      .then(() => this.props.handleModal(!this.props.openModal));
  }

  close = () => {
    this.props.handleModal(!this.props.openModal)
  }

   render() {
    return (
      <ReactModal
        isOpen={this.props.openModal}
        style={CUSTOM_STYLES}
      >
        <h2>New Teacher</h2>
        <div>
          <TeacherForm
            onClose={this.close}
            onSubmit={this.submit}
          />
        </div>
      </ReactModal>
    );
  }

  static propTypes = {
    handleModal: PropTypes.func,
    openModal: PropTypes.bool,
  }
}
