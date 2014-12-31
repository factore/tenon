MediumEditor.prototype.toolbarFormAnchor = function () {
  var anchor = document.createElement('div'),
      input = document.createElement('input'),
      cancel = document.createElement('a'),
      asset_button = document.createElement('a'),
      target_wrap = document.createElement('div'),
      target_label = document.createElement('label'),
      target = document.createElement('input'),
      icon = document.createElement('i');

  cancel.setAttribute('href', '#');
  cancel.className = 'medium-editor-cancel';

  asset_button.id = 'medium-editor-link-to-asset';
  asset_button.setAttribute('href', '/tenon/item_assets/new?hide_upload=true');
  asset_button.setAttribute('data-modal-remote', 'true');
  asset_button.setAttribute('data-tooltip', 'true');
  asset_button.setAttribute('title', 'Link to an Asset');
  asset_button.setAttribute('data-modal-title', 'Link to Asset');
  asset_button.setAttribute('data-modal-handler', 'Tenon.features.tenonContent.AssetLink');

  target.setAttribute('type', 'checkbox')
  target.setAttribute('title', 'Open in New Window?')
  target.setAttribute('data-tooltip', 'true');
  target.className = 'medium-editor-toolbar-anchor-target';
  target_label.className = 'medium-editor-toolbar-anchor-target-label';
  target_wrap.className = 'medium-editor-toolbar-anchor-target-wrap';
  target_wrap.insertBefore(target_label, target_wrap.firstChild);
  target_wrap.insertBefore(target, target_wrap.firstChild);

  input.setAttribute('type', 'text');
  input.setAttribute('placeholder', this.options.anchorInputPlaceholder);

  anchor.className = 'medium-editor-toolbar-form-anchor';
  anchor.id = 'medium-editor-toolbar-form-anchor';
  anchor.appendChild(asset_button);
  anchor.appendChild(input);
  anchor.appendChild(target_wrap);
  anchor.appendChild(cancel);

  return anchor;
};

MediumEditor.prototype.bindAnchorForm = function () {
    var linkCancel = this.anchorForm.querySelector('a.medium-editor-cancel'),
        self = this;
    this.anchorForm.addEventListener('click', function (e) {
      if ( !$(e.target).is('#medium-editor-link-to-asset *, #medium-editor-link-to-asset') ) {
        e.stopPropagation();
      }
    });
    this.anchorInput.addEventListener('keyup', function (e) {
        if (e.keyCode === 13) {
            e.preventDefault();
            self.createLink(this);
        }
    });
    this.anchorInput.addEventListener('click', function (e) {
        // make sure not to hide form when cliking into the input
        e.stopPropagation();
        self.keepToolbarAlive = true;
    });
    this.anchorInput.addEventListener('blur', function () {
        // self.keepToolbarAlive = false;
        self.checkSelection();
    });
    linkCancel.addEventListener('click', function (e) {
        e.preventDefault();
        self.showToolbarActions();
        restoreSelection(self.savedSelection);
    });
    return this;
};