window.ErrorMessages = ({ errors }) => {
  if (!errors) {
    return <div></div>;
  }

  return (
    <div>
      {errors.map((error, i) => {
        return (
          <label
            className="input-block__error-message"
            key={i}>
            This field {error}.
          </label>
        );
      })}
    </div>
  );
};
