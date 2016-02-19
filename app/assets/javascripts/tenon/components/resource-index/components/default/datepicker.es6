/* global React */
/* global ReactDOM */
/* global $ */
// How to get the pickadate to mount correcty in React.js component
// requires jQuery and pickadate.js (https://github.com/amsul/pickadate.js/)

class Datepicker extends React.Component {
  componentDidMount() {
    this.setupDatepicker();
  }

  componentDidUpdate() {
    this.setupDatepicker();
  }

  setupDatepicker() {
    const el = this.refs.datepicker;
    const { name, onChange } = this.props;

    $(ReactDOM.findDOMNode(el)).pickadate({
      format: 'yyyy-mm-dd',
      formatSubmit: 'yyyy-mm-dd',
      selectMonths: true,
      selectYears: 5,
      container: 'body',
      closeOnSelect: true,
      onSet: function() {
        const value = this.get('select', 'yyyy-mm-dd');
        const event = { target: { value: value, name: name } };

        onChange(event);
      }
    });
  }

  render() {
    return (
      <input
        className={this.props.className}
        type="date"
        ref="datepicker"
        name={this.props.name}
        defaultValue={this.props.value} />
    );
  }
}

window.Datepicker = Datepicker;
