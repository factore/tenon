window.TextField = (props) => {
  return (
    <div className="input-block">
      <label className="input-block__label">{props.label}</label>
      <input
        className="input-block__text-input"
        type={props.type || 'text'}
        name={props.name}
        value={props.value}
        onChange={props.onChange} />
    </div>
  );
};
