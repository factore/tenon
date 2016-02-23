window.ResourceIndexComponents.DefaultFilterOverlay = (props) => {
  return (
    <div className="toolbar toolbar--overlay">
      <div className="filter-content">
        <a href="#!" className="toolbar__action">
          <i className="material-icons">close</i>
          Close
        </a>
        <div className="util-nav-content">
          {props.data.records.size} results.
        </div>
      </div>
    </div>
  );
};
