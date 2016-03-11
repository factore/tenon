window.ResourceIndexComponents.PostsRecordTitle = ({ record }) => {
  let publishText;

  if (record.formatted_publish_at) {
    publishText = <span>Published on {record.formatted_publish_at}</span>;
  } else {
    publishText = <span>Not published.</span>;
  }

  return (
    <div>
      <p className="record__title">
        {record.title}
      </p>

      <p className="record__title--smallest">
        {publishText}
      </p>
    </div>
  );
};
