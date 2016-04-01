import { Component } from 'react';
import classNames from 'classnames';

export default class App extends Component {
  componentWillMount() {
    this.props.actions.updateConfig({
      baseUri: this.props.recordsPath,
      reorderUri: this.props.reorderPath
    });

    this.props.actions.fetchRecords();
  }

  render() {
    const {
      QuickSearchOverlay, Toolbar, List, Filtering,
      AddButton, ModalAddButton, ModalForm, ModalFields
    } = this.props.childComponents;
    const { addWithModal } = this.props;
    const { quickSearchOpen, filterDrawerOpen, modalFormOpen } = this.props.ui;
    const outerClassNames = classNames({
      'quick-search-open': quickSearchOpen || filterDrawerOpen,
      'filter-drawer-open': filterDrawerOpen,
      'modal-form-open': modalFormOpen
    });

    return (
      <div className={outerClassNames}>
        <Toolbar { ...this.props } />
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
