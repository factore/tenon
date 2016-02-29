window.ResourceIndexComponents.DefaultRecordExpandedContent = (props) => {
  const editPath = props.record.edit_path;
  const onDelete = props.onDelete;

  return (
    <div className="record__expanded-content">
      <p className="record__expanded-title">
        This is another title about things
      </p>
      <p className="record__expanded-title--smallest">
        <strong className="color-light-fg">Notes:</strong>
        <br/>
        Lorem ipsum dolor sit amet, consectetur adipisicing elit,
        sed do eiusmod tempor incididunt ut labore et dolore magna
        aliqua. Lorem ipsum dolor sit amet, consectetur adipisicing
        elit, sed do eiusmod tempor incididunt ut labore et dolore magna
        aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco
        laboris nisi ut aliquip ex ea commodo consequat.
      </p>
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
