window.SelectField = (props) => {
  return (
    <div className="input-block">
      <label className="input-block__label">{props.label}</label>
      <select
        className="input-block__select"
        value={props.value}
        name={props.name}
        onChange={props.onChange}>
        {props.children}
      </select>
    </div>
  );
};
