/* global React */
/* global classNames */

class DefaultRecord extends React.Component {
  render() {
    const {
      RecordTitle, RecordActions, RecordExpandedContent
    } = this.props.childComponents;
    const { isExpanded, onToggleExpand } = this.props;
    const classnames = classNames({
      'record': true,
      'record--is-expanded': isExpanded,
      'record--is-updating': this.props.record.isUpdating
    });
    let titleWrapProps = {};

    if (RecordExpandedContent) {
      titleWrapProps = {
        className: 'record__expand-toggle',
        onClick: onToggleExpand
      };
    }

    return (
      <div
        data-record-id={this.props.record.id} // For dragula :(
        className={classnames}>
        <div className="record__details">
          <div { ...titleWrapProps }>
            <RecordTitle { ...this.props } />
          </div>

        </div>

        <RecordActions { ...this.props } />
        { RecordExpandedContent ?
          <RecordExpandedContent { ...this.props} />
          :
          null
        }

      </div>
    );
  }
}

window.ResourceIndexComponents.DefaultRecord = DefaultRecord;
