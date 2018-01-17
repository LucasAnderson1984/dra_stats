import React, { Component } from 'react';
import { Link } from 'react-router-dom'

class Menue extends Component {
  render() {
    return (
      <nav className='navbar navbar-default navbar-fixed-top'>
        <div className='container-fluid'>
          <div className='navbar-header'>
            <button
              type="button"
              className="navbar-toggle collapsed"
              data-toggle="collapse"
              data-target="#navbar"
              aria-expanded="false"
              aria-controls="navbar">
              <span className="sr-only">Toggle navigation</span>
              <span className="icon-bar"></span>
              <span className="icon-bar"></span>
              <span className="icon-bar"></span>
            </button>
            <Link className='navbar-brand' to='/'>DRA Score</Link>
          </div>
          <div className="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul className="nav navbar-nav">
              <li className="active">
                <Link className='nav-item nav-link active' to='/teachers'>
                  Teacher
                  <span className='sr-only'>(current)</span>
                </Link>
              </li>
            </ul>
          </div>
        </div>
      </nav>
    );
  };
}

export default Menue;
