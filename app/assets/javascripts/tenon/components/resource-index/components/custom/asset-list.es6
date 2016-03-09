window.ResourceIndexComponents.AssetList = (props) => {
  const { Record, LoadMoreButton }  = props.childComponents;
  const { deleteRecord, updateRecord, toggleExpandedRecord } = props.handlers;
  const { records, isFetching, pagination, query } = props.data;
  const { updateQuery } = props.actions;
  const { expandedRecordIds } = props.ui;
  let output;

  if (records.length === 0 && !isFetching) {
    output = (
      <li className="record">
        <div className="record__details">
          <p className="record__title">No {props.title.toLowerCase()} found.</p>
        </div>
      </li>
    );
  } else {
    output = records.map((record, i) => {
      return (
        <Record
          { ...props }
          record={record}
          key={record.id}
          isExpanded={expandedRecordIds.indexOf(record.id) !== -1}
          onDelete={(e) => deleteRecord(e, record)}
          onUpdate={(e, payload) => updateRecord(e, record, payload)}
          onToggleExpand={(e) => toggleExpandedRecord(e, record)} />
      );
    });
  }

  return (
    <div className="record-list">
      <p>
        <input
          type="text"
          value={query.q}
          onChange={(e) => updateQuery({ q: e.target.value, page: 1 })}
          placeholder="Search Assets" />
      </p>

      <ul>
        <ReactCSSTransitionGroup
          transitionName="fade-"
          transitionAppear={true}
          transitionEnterTimeout={250}
          transitionLeaveTimeout={250}>
          {output}
        </ReactCSSTransitionGroup>

      </ul>

      <div className="spacer"></div>

      <LoadMoreButton
        title={props.title}
        loadAction={(e) => props.handlers.loadNextPage(e)}
        pagination={pagination} />
    </div>
  );
};
