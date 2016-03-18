window.ResourceIndexComponents.DefaultList = (props) => {
  const { Record, LoadMoreButton, RecordsCount, ClearFiltersLink }  = props.childComponents;
  const { deleteRecord, updateRecord, toggleExpandedRecord } = props.handlers;
  const { records, isFetching } = props.data;
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
          key={i}
          isExpanded={expandedRecordIds.indexOf(record.id) !== -1}
          onDelete={(e) => deleteRecord(e, record)}
          onUpdate={(e, payload) => updateRecord(e, record, payload)}
          onToggleExpand={(e) => toggleExpandedRecord(e, record)} />
      );
    });
  }

  return (
    <div>
      <RecordsCount { ...props } />
      <ClearFiltersLink { ...props } />
      <ul className="">
        <ReactCSSTransitionGroup
          transitionName="fade-"
          transitionEnterTimeout={250}
          transitionLeaveTimeout={250}>
          {output}
        </ReactCSSTransitionGroup>

      </ul>

      <LoadMoreButton { ...props } />
    </div>
  );
};
