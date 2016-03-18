/* global React */

class DefaultRecord extends React.Component {
  render() {
    const {
      RecordTitle, RecordActions, RecordExpandedContent
    } = this.props.childComponents;
    const { isExpanded, onToggleExpand } = this.props;
    const classNames = ['record'];

    if (isExpanded) {
      classNames.push('record--is-expanded');
    }

    if (this.props.record.isUpdating) {
      classNames.push('record--is-updating');
    }

    return (
      <li className={classNames.join(' ')}>
        <div className="record__details">
          <div className="record__expand-toggle" onClick={onToggleExpand}>
            <RecordTitle { ...this.props } />
          </div>

        </div>

        <RecordActions { ...this.props } />
        <RecordExpandedContent { ...this.props} />
      </li>
    );
  }
}

window.ResourceIndexComponents.DefaultRecord = DefaultRecord;
