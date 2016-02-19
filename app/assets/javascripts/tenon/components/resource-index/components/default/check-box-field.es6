/* global React */

class CheckBoxField extends React.Component {
  _onChange() {
    const { name, value, onChange } = this.props;
    const newValue = value ? '' : true;

    onChange({ target: { name: name, value: newValue } });
  }

  render() {
    const { name, label, value } = this.props;

    return (
      <div className="input-block input-block--with-check-box">
        <label className="input-block__label">
          {label}
          {' '}
          <input
            className="input-block__check-box"
            type="checkbox"
            name={name}
            checked={value}
            onChange={() => this._onChange()} />
        </label>
      </div>
    );
  }
}

window.CheckBoxField = CheckBoxField;
