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
      <div className="input-block">
        <div className="input-block__inline">
          <input
            className="input-block__check-box"
            type="checkbox"
            name={name}
            checked={value}
            onChange={() => this._onChange()} />

          <div
            className="input-block__check-box-icon input-block__checked-icon">
            <i className="material-icon">check</i>
          </div>

          <label className="input-block__label input-block__label--inline">
            {label}
          </label>
        </div>
      </div>
    );
  }
}

window.CheckBoxField = CheckBoxField;
