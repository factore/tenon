window.ResourceIndexComponents.posts.RecordExpandedContent = (props) => {
  const editPath = props.record.edit_path;
  const onDelete = props.onDelete;

  return (
    <div className="record__expanded-content">
      <div dangerouslySetInnerHTML={{ __html: props.record.excerpt }} />
      <div className="record__expanded-actions">
        <div className="record__expanded-action-text">
          <a
            className="action-text"
            href={editPath}
            title="Edit">
            Edit
          </a>
        </div>

        <div className="record__expanded-action-text">
          <a
            className="action-text"
            onClick={onDelete}
            href="#!"
            title="Delete">
            Delete
          </a>
        </div>
      </div>
    </div>
  );
};
