() => {
  class Tabs {
    constructor(opts = {}) {
      this.opts = { ...Tabs.defaultOptions, ...opts };
      $(`.${this.opts.tabClass} a`).on('click', this.onTabClicked.bind(this));
    }

    onTabClicked(e) {
      e.preventDefault();
      const $link = $(e.currentTarget);
      const $tab = $link.closest(`.${this.opts.tabClass}`);

      this._activateTab($tab);
      this._activateTabSection($link.attr('href'));
    }

    _activateTab($tab) {
      const { tabClass, activeTabClass } = this.opts;

      $tab.siblings(`.${tabClass}`).removeClass(activeTabClass);
      $tab.addClass(activeTabClass);
    }

    _activateTabSection(href) {
      const { tabSectionClass, activeTabSectionClass } = this.opts;

      $(href)
        .addClass(activeTabSectionClass)
        .siblings(`.${tabSectionClass}`).removeClass(activeTabSectionClass);
    }
  }

  Tabs.defaultOptions = {
    tabsListClass: 'tabs',
    tabClass: 'tabs__tab',
    activeTabClass: 'tabs__tab--is-active',
    tabSectionClass: 'tab-section',
    activeTabSectionClass: 'tab-section--is-active'
  };

  window.Tenon.features.Tabs = Tabs;
}();
