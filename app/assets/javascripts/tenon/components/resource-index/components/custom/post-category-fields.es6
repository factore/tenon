window.ResourceIndexComponents.PostCategoryFields = (props) => {
  const { currentRecord, currentRecordErrors } = props.data;
  const { onChange } = props;

  return (
    <div>
      <TextField
        name="title"
        value={currentRecord.title}
        onChange={onChange}
        errors={currentRecordErrors.title}
        label="Title" />
      <button type="submit" className="btn">Save</button>
    </div>
  );
};
