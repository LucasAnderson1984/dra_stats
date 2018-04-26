import React from 'react';
import ReactDOM from 'react-dom';
import ReactModal from 'react-modal';
import { Provider } from 'react-redux';
import { BrowserRouter } from 'react-router-dom';
import './../node_modules/bootstrap/dist/css/bootstrap.min.css';
import './assets/index.css';
import App from './components/App';
import registerServiceWorker from './registerServiceWorker';
import { store } from './store';

ReactModal.setAppElement('#root');

ReactDOM.render(
  <Provider store={ store }>
    <BrowserRouter basename='/'>
      <App />
    </BrowserRouter>
  </Provider>,
  document.getElementById('root')
);
registerServiceWorker();
