window.ResourceIndexComponents.PostCategoryFields = (props) => {
  const { currentRecord } = props.data;
  const { onChange } = props;

  return (
    <div>
      <TextField
        name="title"
        value={currentRecord.title}
        onChange={onChange}
        label="Title" />
      <button type="submit" className="btn">Save</button>
    </div>
  );
};
