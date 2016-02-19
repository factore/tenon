/* global React */

class DefaultRecord extends React.Component {
  render() {
    const {
      edit_path, title, delete_path, onDelete,
      expanded, onToggleExpand
    } = this.props;
    const classNames = ['record'];

    if (expanded) {
      classNames.push('record--is-expanded');
    }

    return (
      <li className={classNames.join(' ')}>
        <div className="record__details">
          <div className="record__expand-toggle" onClick={onToggleExpand}>
            <p className="record__title">
              {title}
            </p>

            <p className="record__title--smallest">
              Posted on a Monday
            </p>
          </div>

          <div className="record__actions">
            <a
              className="record__action-icon"
              href={edit_path}
              title="Edit">
              <i className="material-icon">edit</i>
            </a>

            <a
              className="record__action-icon"
              href="#!"
              onClick={onDelete} title="Delete">
              <i className="material-icon">delete</i>
            </a>

            <a
              className="record__action-icon dropdown-button"
              href="#!"
              data-activates="record-dropdown">
              <i className="material-icon">more_vert</i>
            </a>

            <ul className="dropdown-content" id="record-dropdown">
              <li>
                <a href={edit_path} title="Edit">
                  <i className="material-icon">edit</i>
                  Test Edit
                </a>

                <a href="#" onClick={onDelete} title="Delete">
                  <i className="material-icon">delete</i>
                  Test Delete
                </a>
              </li>
            </ul>
          </div>
        </div>

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
            <a
              className="record__expanded-action-text"
              href={edit_path}
              title="Edit">
              Edit
            </a>
            <a
              className="record__expanded-action-text"
              onClick={onDelete}
              href="#!"
              title="Delete">
              Delete
            </a>
          </div>
        </div>
      </li>
    );
  }
}

window.ResourceIndexComponents.DefaultRecord = DefaultRecord;
