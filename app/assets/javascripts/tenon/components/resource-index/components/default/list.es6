window.ResourceIndexComponents.DefaultList = (props) => {
  const { Record, LoadMoreButton }  = props.childComponents;
  const { deleteRecord, updateRecord, toggleExpandedRecord } = props.handlers;
  const { records, isFetching, pagination } = props.data;
  let output;

  if (records.length === 0 && !isFetching) {
    output = <li className="collection-item">No {props.title.toLowerCase()} found.</li>;
  } else {
    output = records.map((record, i) => {
      return (
        <Record
          {...record}
          key={i}
          onDelete={(e) => deleteRecord(e, record)}
          onUpdate={(e, payload) => updateRecord(e, record, payload)}
          onToggleExpand={(e) => toggleExpandedRecord(e, record)} />
      );
    });
  }

  return (
    <main>
      <a className="btn-fab btn-fab-bottom-right" href={props.newPath}>
        <i className="material-icons">add</i>
      </a>

      <div className="record-list with-btn-fab">
        <ul className="">
          <ReactCSSTransitionGroup
            transitionName="record"
            transitionEnterTimeout={250}
            transitionLeaveTimeout={250}>
            {output}
          </ReactCSSTransitionGroup>

        </ul>

        <LoadMoreButton
          title={props.title}
          loadAction={(e) => props.handlers.loadNextPage(e)}
          pagination={pagination} />
      </div>
    </main>
  );
};
