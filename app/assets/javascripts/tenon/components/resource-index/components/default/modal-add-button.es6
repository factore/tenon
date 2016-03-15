window.ResourceIndexComponents.DefaultModalAddButton = (props) => {
  const { newRecordInModal } = props.actions;

  return (
    <a
      className="fab fab--bottom-right"
      onClick={newRecordInModal}
    >
      <i className="material-icon">add</i>
    </a>
  );
};
