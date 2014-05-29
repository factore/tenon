MediumEditor.prototype.toolbarFormAnchor = function () {
  var anchor = document.createElement('div'),
    input = document.createElement('input'),
    a = document.createElement('a'),
    button = document.createElement('a');
    icon = document.createElement('i');

  a.setAttribute('href', '#');
  a.innerHTML = '&times;';
  a.className = 'medium-editor-cancel';

  button.id = 'medium-editor-link-to-asset';
  button.setAttribute('href', '/tenon/item_assets/new?hide_upload=true');
  button.setAttribute('data-modal-remote', 'true');
  button.setAttribute('data-tooltip', 'true');
  button.setAttribute('title', 'Link to an Asset');
  button.setAttribute('data-modal-title', 'Link to Asset');
  button.setAttribute('data-modal-handler', 'Tenon.features.tenonContent.AssetLink');

  icon.className = 'fa fa-file-pdf-o';

  button.appendChild(icon);

  input.setAttribute('type', 'text');
  input.setAttribute('placeholder', this.options.anchorInputPlaceholder);

  anchor.className = 'medium-editor-toolbar-form-anchor';
  anchor.id = 'medium-editor-toolbar-form-anchor';
  anchor.appendChild(input);
  anchor.appendChild(button);
  anchor.appendChild(a);

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