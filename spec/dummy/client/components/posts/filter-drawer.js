import React from 'react';
import TextField from 'tenon/components/shared/text-field';
import DatepickerField from 'tenon/components/shared/datepicker-field';
import SelectField from 'tenon/components/shared/select-field';
import CheckBoxField from 'tenon/components/shared/check-box-field';

module.exports = ({ data, onChange }) => {
  const query = data.query;

  return (
    <div>
      <div className="panel panel--tight-padded">
        <TextField
          label="Keywords"
          name="q"
          value={query.q}
          onChange={onChange} />

        <DatepickerField
          label="Start Date"
          name="start_date"
          value={query.start_date}
          onChange={onChange} />

        <DatepickerField
          label="End"
          name="end_date"
          value={query.end_date}
          onChange={onChange} />

        <SelectField
          label="Published"
          name="published"
          value={query.published}
          onChange={onChange}>
          <option value="">All</option>
          <option value="published">Published Only</option>
          <option value="unpublished">Unpublished Only</option>
        </SelectField>

        <CheckBoxField
          label="Hide Unpublished?"
          name="hide_unpublished"
          value={query.hide_unpublished}
          onChange={onChange} />
      </div>
    </div>
  );
};
