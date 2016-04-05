/* global React */
/* global ReactDOM */
/* global reactDragula */

() => {
  class List extends React.Component {
    componentDidMount() {
      if (this.props.reorderPath) {
        const node = ReactDOM.findDOMNode(this._transitionGroup);
        const drake = reactDragula([node]);

        drake.on('drop', this._onRecordDrop.bind(this));
      }
    }

    _onRecordDrop(el, target) {
      const children = [...target.childNodes];
      const ids = children.map((n) => n.getAttribute('data-record-id'));

      this.props.actions.reorderRecords(ids);
    }

    _onToggleExpand(e, record) {
      e.preventDefault();
      this.props.actions.toggleExpandedRecord(record);

      $(e.target)
        .closest('.record')
        .find('.record__expanded-content')
        .slideToggle(250);
    }

    render() {
      const {
        Record, LoadMoreButton, RecordsCount, ClearFiltersLink, SortOrder
      } = this.props.childComponents;
      const { deleteRecord, updateRecord } = this.props.handlers;
      const { records } = this.props.data;
      const { expandedRecordIds } = this.props.ui;

      return (
        <div className="records-list">
          <div className="records-list__tools">
            <RecordsCount { ...this.props } />
            <ClearFiltersLink { ...this.props } />
            <SortOrder {...this.props} />
          </div>

          <ReactCSSTransitionGroup
            transitionName="fade-"
            transitionEnterTimeout={250}
            transitionLeaveTimeout={250}
            ref={(group) => this._transitionGroup = group}>

            {records.map((record, i) => {
              return (
                <Record
                  { ...this.props }
                  record={record}
                  key={i}
                  isExpanded={expandedRecordIds.indexOf(record.id) !== -1}
                  onDelete={(e) => deleteRecord(e, record)}
                  onUpdate={(e, payload) => updateRecord(e, record, payload)}
                  onToggleExpand={(e) => this._onToggleExpand(e, record)} />
              );
            })}
          </ReactCSSTransitionGroup>

          <LoadMoreButton { ...this.props } />
        </div>
      );
    }
  }

  window.ResourceIndexComponents.DefaultList = List;
}();
