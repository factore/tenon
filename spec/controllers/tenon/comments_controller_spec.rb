require 'spec_helper'

describe Tenon::CommentsController do
  routes { Tenon::Engine.routes }

  let(:user) do
    double(
      :staff? => true,
      :is_super_admin? => false,
      :is_admin? => true
    )
  end

  let(:comment) { double.as_null_object }

  before do
    controller.stub(:current_user) { user }
    controller.stub(:polymorphic_index_path) { '/tenon/comments' }

  end

  describe 'GET index.html' do
    it 'should get the comment counts' do
      expect(Tenon::Comment).to receive(:count) { [] }
      expect(Tenon::Comment).to receive(:approved) { [] }
      expect(Tenon::Comment).to receive(:unapproved) { [] }
      get :index, format: 'html'
    end

    it 'should assign the comment counts' do
      get :index, format: 'html'
      expect(assigns[:counts]).not_to be_nil
    end
  end

  describe 'GET index.json' do
    before do
      [:all, :where, :approved, :unapproved, :paginate].each do |query|
        Tenon::Comment.stub(query) { Tenon::Comment }
      end
    end

    context 'without params[:q] and without params[:type]' do
      it 'should find and paginate, and decorate the Comments' do
        expect(Tenon::Comment).to receive(:all) { Tenon::Comment }
        expect(Tenon::Comment).to receive(:paginate) { Tenon::Comment }
        expect(Tenon::PaginatingDecorator).to receive(:decorate).with(Tenon::Comment)
        get :index, format: 'json'
      end

      it "shouldn't search or sort the comments by type" do
        expect(Tenon::Comment).not_to receive(:where)
        expect(Tenon::Comment).not_to receive(:approved)
        expect(Tenon::Comment).not_to receive(:unapproved)
        get :index, format: 'json'
      end
    end

    context 'with params[:q] = "search"' do
      it 'should search the comments with the query' do
        args = [
          'author ILIKE :q OR author_url ILIKE :q OR author_email ILIKE :q OR content ILIKE :q OR user_ip ILIKE :q',
          { q: '%search%' }
        ]
        expect(Tenon::Comment).to receive(:all) { Tenon::Comment }
        expect(Tenon::Comment).to receive(:where).with(args) { Tenon::Comment }
        get :index, format: 'json', q: 'search'
      end

      it 'should not sort the comments by type' do
        expect(Tenon::Comment).not_to receive(:with_type)
        get :index, format: 'json', q: 'search'
      end
    end

    %w(approved unapproved).each do |type|
      context "with params[:type] = #{type}" do
        it 'should search the comments with the type' do
          expect(Tenon::Comment).to receive(type)
          get :index, format: 'json', type: type
        end

        it 'should not search the comments by type' do
          expect(Tenon::Comment).not_to receive(:where)
          get :index, format: 'json', type: 'images'
        end
      end

      context "with params[:q] = 'search' and params[:type] = '#{type}'" do
        it 'should search the comments and sort them by type' do
          args = [
            'author ILIKE :q OR author_url ILIKE :q OR author_email ILIKE :q OR content ILIKE :q OR user_ip ILIKE :q',
            { q: '%search%' }
          ]
          expect(Tenon::Comment).to receive(:where).with(args)
          expect(Tenon::Comment).to receive(type)
          get :index, format: 'json', type: type, q: 'search'
        end
      end
    end
  end

  %w(toggle_approved).each do |action|
    describe "GET #{action}.json" do
      let(:comment) { double }
      before { Tenon::Comment.stub(:find) { comment } }

      context 'when successful' do
        before do
          comment.stub("#{action}!") { true }
        end

        it 'should render the comment to json' do
          get action, id: 1, format: 'json'
          expect(response.body).to eq double.to_json
        end

        it 'should be successful' do
          get action, id: 1, format: 'json'
          expect(response).to be_success
        end
      end

      context 'when not successful' do
        before do
          comment.stub("#{action}!") { false }
        end

        it 'should return an error' do
          get action, id: 1, format: 'json'
          expect(response).not_to be_success
        end
      end
    end

    describe "GET #{action}.html" do
      let(:comment) { double }
      before { Tenon::Comment.stub(:find) { comment } }

      context 'when successful' do
        before do
          comment.stub("#{action}!") { true }
        end

        it 'should set the flash[:notice]' do
          get action, id: 1, format: 'html'
          expect(controller.flash[:notice]).not_to be_blank
        end

        it 'should redirect to index' do
          get action, id: 1, format: 'html'
          expect(response).to redirect_to '/tenon/comments'
        end
      end

      context 'when not successful' do
        before do
          comment.stub("#{action}!") { false }
        end

        it 'should set the flash[:warning]' do
          get action, id: 1, format: 'html'
          expect(controller.flash[:warning]).not_to be_blank
        end

        it 'should redirect to index' do
          get action, id: 1, format: 'html'
          expect(response).to redirect_to '/tenon/comments'
        end
      end
    end
  end
end
