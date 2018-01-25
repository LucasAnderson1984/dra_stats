import React, { Component } from 'react';
import { Route, Switch } from 'react-router-dom';
import Menue from './Menue';
import StudentsContainer from './../containers/StudentsContainer';
import TeachersContainer from './../containers/TeachersContainer';

class App extends Component {
  render() {
    return (
      <div>
        <header><Menue /></header>
        <div>
          <Switch>
            <Route path='/students' component={StudentsContainer} />
            <Route path='/teachers' component={TeachersContainer} />
          </Switch>
        </div>
        <footer></footer>
      </div>
    );
  }
}

export default App;
