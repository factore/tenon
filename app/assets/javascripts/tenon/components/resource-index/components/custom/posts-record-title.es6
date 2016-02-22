window.ResourceIndexComponents.PostsRecordTitle = ({ record }) => {
  return (
    <div>
      <p className="record__title">
        {record.title}
      </p>

      <p className="record__title--smallest">
        Published on {record.publish_at}
      </p>
    </div>
  );
};
