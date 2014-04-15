require 'spec_helper'

describe Tenon::Comment do
  describe '.create_comment' do
    let(:object) { double(id: 1) }

    context 'when a session is passed' do
      it "should create a comment with the session's attributes" do
        session = { one: 'one', two: 'two' }
        expect(Tenon::Comment).to receive(:new).with(session)
        Tenon::Comment.create_comment(object, session)
      end
    end

    context 'when session is nil' do
      it "should create a comment with the object's details" do
        info = { commentable_type: object.class.to_s, commentable_id: 1 }
        expect(Tenon::Comment).to receive(:new).with(info)
        Tenon::Comment.create_comment(object, nil)
      end
    end
  end

  # TODO: The fact that we're testing behaviour that's encapsulated
  # in a private method called by a callback tells me that we need
  # rethink how this is handled.
  describe '#save' do
    before do
      @comment = Tenon::Comment.new
      @comment.stub(:valid?).and_return(true)
      @comment.stub(:approved?).and_return(true)
    end

    it 'creates a comment subscriber' do
      @comment.subscribe = 1
      @comment.stub_chain(:commentable, :subscribers).and_return([])

      Tenon::CommentSubscriber.should_receive(:create)
      @comment.save
    end

    it 'notifies subscribers' do
      @comment.subscribe = 0
      subscriber = double('subscriber', email: 'something@something.com')
      @comment.stub_chain(:commentable, :subscribers).and_return([subscriber])
      Tenon::CommentMailer.stub_chain(:comment_notification, :deliver)

      Tenon::CommentMailer.should_receive(:comment_notification)
      @comment.save
    end
  end

  describe '#toggle_approved!' do
    let(:comment) { Tenon::Comment.new(approved: approved) }
    context 'when approved is true' do
      let(:approved) { true }
      it 'should set approved to false and save the comment' do
        expect(comment).to receive(:approved=).with(false)
        expect(comment).to receive(:save)
        comment.toggle_approved!
      end
    end

    context 'when approved is false' do
      let(:approved) { false }
      it 'should set approved to true and save the comment' do
        expect(comment).to receive(:approved=).with(true)
        expect(comment).to receive(:save)
        comment.toggle_approved!
      end
    end
  end

  describe '#approve' do
    let(:comment) { Tenon::Comment.new }
    it 'should set approved to true' do
      expect(comment).to receive(:approved=).with(true)
      comment.approve
    end
  end
end
