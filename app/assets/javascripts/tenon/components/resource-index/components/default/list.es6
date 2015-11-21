class DefaultList extends React.Component {
  render() {
    const { Record, LoadMoreButton }  = this.props.childComponents;
    const { deleteRecord, updateRecord } = this.props.handlers;
    let noRecordsWarning;

    if (this.props.records.length === 0) {
      noRecordsWarning = <li className="collection-item">No {this.props.title.toLowerCase()} found.</li>;
    }

    return (
      <div className="panel with-btn-floating">
        <a className="btn-floating" href={this.props.newPath}>
          <i className="icon ion-android-add"></i>
        </a>

        <div className="tool-toggles">
          <a href="#">
            <i className="icon ion-android-search"></i>
          </a>

          <a href="#">
            <i className="icon ion-android-more-vertical"></i>
          </a>
        </div>

        <div className="spacer"></div>

        <ul className="record-list">
          <ReactCSSTransitionGroup transitionName="record" transitionEnterTimeout={250} transitionLeaveTimeout={250} >
            {noRecordsWarning}
            {this.props.records.map((record, i) =>
              <Record
                {...record}
                key={i}
                onDelete={(e) => deleteRecord(e, record)}
                onUpdate={(e, payload) => updateRecord(e, record, payload)} />
            )}
          </ReactCSSTransitionGroup>
        </ul>

        <LoadMoreButton
          title={this.props.title}
          loadAction={(e) => this.props.handlers.loadNextPage(e)}
          pagination={this.props.pagination} />
      </div>
    );
  }
}

window.ResourceIndexComponents.DefaultList = DefaultList;
