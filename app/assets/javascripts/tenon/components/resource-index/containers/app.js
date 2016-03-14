import { Component } from 'react';
import classNames from 'classnames';

export default class App extends Component {
  componentWillMount() {
    this.props.actions.updateConfig({ baseUri: this.props.recordsPath });
    this.props.actions.fetchRecords();
  }

  render() {
    const {
      QuickSearchOverlay, QuickSearchToolbar, List, Filtering,
      AddButton, ModalAddButton, ModalForm, ModalFields
    } = this.props.childComponents;
    const { addWithModal } = this.props;
    const outerClassNames = classNames({
      'quick-search-open': this.props.ui.quickSearchOpen,
      'filter-drawer-open': this.props.ui.filterDrawerOpen,
      'modal-form-open': this.props.ui.modalFormOpen
    });

    return (
      <div className={outerClassNames}>
        <QuickSearchToolbar { ...this.props } />
        <QuickSearchOverlay { ...this.props } />
        <Filtering { ...this.props } />
        <div className="drawer-pusher">
          <main>
            {addWithModal && <ModalAddButton { ...this.props } />}
            {!addWithModal && <AddButton { ...this.props } />}

            <List { ...this.props } />
          </main>
        </div>
        {ModalFields && <ModalForm { ...this.props } />}
      </div>
    );
  }
}
