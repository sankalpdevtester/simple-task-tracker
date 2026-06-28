// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a separate file.
//
// This file is being referenced by config/webpacker.yml
//
// To use this file, add `%%= javascript_pack_tag 'application' %%` to your layout
//
// To use a separate file, create a new pack:
//   rails generate webpacker:pack <pack_name>
//
import React from 'react';
import ReactDOM from 'react-dom';
import App from '../components/App';

document.addEventListener('DOMContentLoaded', () => {
  ReactDOM.render(
    <React.StrictMode>
      <App />
    </React.StrictMode>,
    document.body.appendChild(document.createElement('div')),
  )
})