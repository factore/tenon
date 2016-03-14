/* global React */
/* global classNames */

() => {
  class ModalForm extends React.Component {
    _onSubmit(e) {
      const { currentRecord } = this.props.data;
      console.log(currentRecord);
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
      const isActive = this.props.ui.modalFormActive;
      const modalClassNames = classNames({
        'modal': true,
        'modal--is-active': isActive
      });
      const overlayClassNames = classNames({
        'modal-overlay': true,
        'modal-overlay--is-active': isActive
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
                href="#!" className="modal__action">
                Cancel
              </a>
            </div>
          </div>
          <div className={overlayClassNames}></div>
        </div>
      );
    }
  }

  window.ResourceIndexComponents.DefaultModalForm = ModalForm;
}();
