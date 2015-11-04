class DefaultList extends React.Component {
  render() {
    const { Record, LoadMoreButton }  = this.props.childComponents;
    return(
      <div className="main-content">
        <ul className="record-list">
          <ReactCSSTransitionGroup transitionName="record" transitionEnterTimeout={250} transitionLeaveTimeout={250} >
            {this.props.records.map((record, i) =>
              <Record
                {...record}
                key={i}
                onDelete={(e) => this.props.handlers.deleteRecord(e, record)} />
            )}
          </ReactCSSTransitionGroup>
        </ul>

        <LoadMoreButton
          title={this.props.title}
          loadAction={(e) => this.props.handlers.loadNextPage(e)}
          pagination={this.props.pagination} />
      </div>
    )
  }
}

window.ResourceIndexComponents.DefaultList = DefaultList;
