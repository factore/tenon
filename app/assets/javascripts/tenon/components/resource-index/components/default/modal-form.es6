/* global React */
/* global classNames */

() => {
  class ModalForm extends React.Component {
    _onSubmit(e) {
      const { currentRecord } = this.props.data;
      const { updateRecord, createRecord } = this.props.actions;

      e.preventDefault();
      if (currentRecord.updatePath) {
        updateRecord(currentRecord, currentRecord);
      } else {
        createRecord(currentRecord);
      }
    }

    _updateValue(e) {
      const { updateCurrentRecord } = this.props.actions;

      updateCurrentRecord({ [e.target.name]: e.target.value });
    }

    render() {
      const { ModalFields } = this.props.childComponents;
      const { modalFormActive } = this.props.ui;
      const { toggleModalForm } = this.props.handlers;
      const modalClassNames = classNames({
        'modal': true,
        'modal--is-active': modalFormActive
      });
      const overlayClassNames = classNames({
        'modal-overlay': true,
        'modal-overlay--is-active': modalFormActive
      });

      return (
        <div>
          <div className={modalClassNames}>
            <div className="modal__content">
              <form onSubmit={(e) => this._onSubmit(e)}>
                <ModalFields
                  { ...this.props }
                  onChange={(e) => this._updateValue(e)} />
              </form>
            </div>

            <div className="modal__footer">
              <a
                href="#!"
                onClick={(e) => toggleModalForm(e, 'off')}
                className="modal__action">
                Cancel
              </a>
            </div>
          </div>
          <div
            onClick={(e) => toggleModalForm(e, 'off')}
            className={overlayClassNames}>
          </div>
        </div>
      );
    }
  }

  window.ResourceIndexComponents.DefaultModalForm = ModalForm;
}();
