/* global classNames */

window.TextField = ({ label, type, name, value, onChange, errors }) => {
  const errorClassNames = classNames({
    'input-block__field-with-errors': errors
  });

  return (
    <div className="input-block">
      <label className="input-block__label">{label}</label>

      <div className={errorClassNames}>
        <input
          className="input-block__text-field"
          type={type || 'text'}
          name={name}
          value={value}
          onChange={onChange} />

        <ErrorMessages errors={errors} />
      </div>
    </div>
  );
};
