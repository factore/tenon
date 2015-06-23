require 'spec_helper'
include RequestHelpers

describe 'An admin', js: true do
  let!(:admin) { create(:admin) }

  before do
    login(admin)
  end

  # When a Tenon app is configured to use i18n, and a particular model is set
  # up to have fields that are internationalized, then a Tenon user should
  # see a "Locale" nav in the sidebar of the model form.
  # EG, if posts are
  # supposed to have an English title and a French title, when they add a
  # post they will see a navigation item in the sidebar with two elements
  # that say "English" and "French".
  #
  # Clicking these nav elements will show or hide the internationalized fields.
  # The tests below make sure that these fields are rendered in the HTML
  #
  # However, there is a certain amount of configuration that is involved in
  # making this stuff work, which is relevant only to these tests, and also
  # happens to break stuff in other, non-internationalized tests.  Therefore,
  # we have all the setup and teardown below (see before(:all) and after(:all)
  # respectively).
  #
  # We are using Tenon::Post as a test model, but this should work with any
  # kind of model.

  describe 'visiting a form with i18n fields' do
    let!(:post) { create(:post) }

    before(:all) do
      # reset the Tenon:I18nLookup so that we use the thing defined in the
      # spec/dummy app
      Tenon::I18nLookup.class_variable_set :@@fields, nil

      # We need to set up Tenon to tell it what languages it supports.  We'll
      # reset it below in after(:all)
      @orig_languages = Tenon.config.languages
      Tenon.config.languages = { "French" => :fr }

      # Now that we've changed the langugages, we need to reload Tenon::Post
      # so that the "tenon_content :content, i18n: true" call re-fires
      # (otherwise, "association not found" errors happen)
      reload "app/models/tenon/post.rb"

      # Next we need to add the internationalized fields to the database so that
      # we can save the post when we try to test the create / update views. We
      # don't want to add a migration like that to the database, so we add it
      # manually and reset the column info in Tenon::Post.
      unless ActiveRecord::Base.connection.column_exists?(:tenon_posts, :title_fr)
        ActiveRecord::Base.connection.add_column :tenon_posts, :title_fr, :string
      end
      Tenon::Post.reset_column_information
    end

    context 'visiting the #new action' do
      it 'should render the i18n fields' do
        visit new_post_path
        expect(page).to have_css "input#post_title_fr"
      end
    end

    context 'visiting the #create action' do
      it 'should render the i18n fields' do
        visit new_post_path
        # don't need the post to save properly, just need to see the create page
        click_button 'Save'
        expect(page).to have_css "input#post_title_fr"
      end
    end

    context 'visiting the #edit action' do
      it 'should render the i18n fields' do
        visit edit_post_path(post)
        expect(page).to have_css "input#post_title_fr"
      end
    end

    context 'visiting the #update action' do
      it 'should render the i18n fields' do
        visit edit_post_path(post)
        click_button 'Save'
        expect(page).to have_css "input#post_title_fr"
      end
    end

    after(:all) do
      # remove the added column
      ActiveRecord::Base.connection.remove_column :tenon_posts, :title_fr
      Tenon::Post.reset_column_information

      # reset the languages Tenon is using
      Tenon.config.languages = @orig_languages

      # reload Tenon::Post
      reload 'app/models/tenon/post.rb'
    end
  end
end

def reload(file_name)
  load File.dirname(__FILE__) + '/../../../' + file_name
end
