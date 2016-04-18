/* global require */
window.React = require('react');
window.ReactDOM = require('react-dom');
window.Redux = require('redux');
window.reduxThunk = require('redux-thunk');
window.ReactRedux = require('react-redux');
window.ReactPortal = require('react-portal');
window.ReactCSSTransitionGroup = require('react-addons-css-transition-group');
window.ResourceIndexComponents = {};
window.ResourceIndexRoot = require('./components/resource-index/containers/root');
window.StandaloneList = require('./components/resource-index/containers/standalone-list-root');
window.classNames = require('classnames');
window.pluralize = require('pluralize');
window.reactDragula = require('react-dragula');
window.dragula = window.reactDragula;
require('./querystring.underscore');
require('./inflection.underscore');
window._ = require('lodash');
