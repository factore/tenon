window.ResourceIndexComponents.DefaultModalAddButton = (props) => {
  const { toggleModalForm } = props.handlers;

  return (
    <a
      className="fab fab--bottom-right"
      onClick={(e) => toggleModalForm(e, 'on')}
    >
      <i className="material-icon">add</i>
    </a>
  );
};
