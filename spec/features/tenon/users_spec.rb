require 'spec_helper'
include RequestHelpers

describe 'An admin', js: true do
  let!(:admin) { create(:admin) }

  before do
    login(admin)
  end

  describe 'viewing the users index' do
    context 'when there is a user' do
      let!(:user) { build(:user) }

      before do
        user.save
      end

      it 'should see the user in a list' do
        visit users_path
        expect(page).to have_content(user.email)
      end

      it 'should be able to delete the user' do
        visit users_path
        within "ul#users li[data-record-id='#{user.id}']" do
          click_on 'Delete'
        end
        expect(page).not_to have_content(user.email)
      end
    end

    context 'when there is a super admin' do
      let!(:super_admin_role) { create(:role, title: 'Super Admin') }
      let!(:super_admin) { create(:user, roles: [super_admin_role]) }

      it 'should not see the super admin in a list' do
        visit users_path
        expect(page).not_to have_content(super_admin.email)
      end
    end
  end

  describe 'creating a new user' do
    before { create(:member_role) }

    context 'when doing everything right' do
      it 'should be able to save the user' do
        visit new_user_path
        within('form#new_user') do
          fill_in 'user[email]', with: 'test@user.com'
          fill_in 'user[password]', with: 'password123'
          fill_in 'user[password_confirmation]', with: 'password123'
          click_button 'Save'
        end
        expect(page).to have_content('test@user.com')
        expect(page).to have_content('User saved successfully.')
      end
    end

    context 'when doing something wrong' do
      it 'should see validation errors' do
        visit new_user_path
        within('form#new_user') do
          click_button 'Save'
        end
        expect(page).to have_content("Password can't be blank")
      end
    end
  end

  describe 'editing a user' do
    let!(:user) { build(:user) }
    before { user.save }

    context 'when doing everything right' do
      it 'should save the user' do
        visit edit_user_path(user)
        within('form.edit_user') do
          fill_in 'user[email]', with: 'test@user.com'
          click_button 'Save'
        end
        expect(page).to have_content('test@user.com')
        expect(page).to have_content('User saved successfully.')
      end
    end

    context 'when doing something wrong' do
      it 'should see validation errors' do
        visit edit_user_path(user)
        within('form.edit_user') do
          fill_in 'user[email]', with: ''
          click_button 'Save'
        end
        expect(page).to have_content("Email can't be blank")
      end
    end
  end

end
