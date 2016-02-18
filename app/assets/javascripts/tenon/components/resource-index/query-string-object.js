import _ from 'lodash';

const queryString = location.search ? location.search.slice(1).split('&') : '';
const queryStringObject = _.chain(queryString)
  .map(function(item) {
    var p = item.split('=');

    return [p[0], decodeURI(p[1])];
  })
  .object()
  .omit(_.isEmpty)
  .toJSON();

export default queryStringObject;
