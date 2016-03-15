/* global React */
/* global classNames */

() => {
  class ModalForm extends React.Component {
    componentDidMount() {
      window.addEventListener('keydown', this._closeOnEsc.bind(this));
    }

    componentWillUnmount() {
      window.removeEventListener('keydown', this._closeOnEsc.bind(this));
    }

    _closeOnEsc(e) {
      if (e.which === 27) {
        this.props.actions.toggleModalForm('off');
      }
    }

    _onSubmit(e) {
      const { currentRecord } = this.props.data;
      const { updateRecordInModal, createRecordInModal } = this.props.actions;

      e.preventDefault();
      if (currentRecord.update_path) {
        updateRecordInModal(currentRecord);
      } else {
        createRecordInModal(currentRecord);
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
      const { currentRecordErrors } = this.props.data;
      const baseErrors = currentRecordErrors.base || [];

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
              <div
                className={baseErrors.length && 'input-block' }>
                {baseErrors.map((error) => {
                  return (
                    <label className="input-block__error-message">
                      {error}
                    </label>
                  );
                })}
              </div>

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
