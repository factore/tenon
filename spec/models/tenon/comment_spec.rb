require 'spec_helper'

describe Comment do
  describe '.create_comment' do
    let(:object) { double(id: 1) }

    context 'when a session is passed' do
      it "should create a comment with the session's attributes" do
        session = {one: 'one', two: 'two'}
        expect(Comment).to receive(:new).with(session)
        Comment.create_comment(object, session)
      end
    end

    context 'when session is nil' do
      it "should create a comment with the object's details" do
        info = {commentable_type: object.class.to_s, commentable_id: 1}
        expect(Comment).to receive(:new).with(info)
        Comment.create_comment(object, nil)
      end
    end
  end

  # TODO: The fact that we're testing behaviour that's encapsulated
  # in a private method called by a callback tells me that we need
  # rethink how this is handled.
  describe '#save' do
    before do
      @comment = Comment.new
      @comment.stub(:valid?).and_return(true)
      @comment.stub(:approved?).and_return(true)
    end

    it 'creates a comment subscriber' do
      @comment.subscribe = 1
      @comment.stub_chain(:commentable, :subscribers).and_return([])

      CommentSubscriber.should_receive(:create)
      @comment.save
    end

    it 'notifies subscribers' do
      @comment.subscribe = 0
      subscriber = double('subscriber', :email => 'something@something.com')
      @comment.stub_chain(:commentable, :subscribers).and_return([subscriber])
      CommentMailer.stub_chain(:comment_notification, :deliver)

      CommentMailer.should_receive(:comment_notification)
      @comment.save
    end
  end

  describe '#approve!' do
    let(:comment) { Comment.new }
    it "should set approved to true and save the comment" do
      expect(comment).to receive(:approved=).with(true)
      expect(comment).to receive(:save)
      comment.approve!
    end
  end

  describe '#unapprove!' do
    let(:comment) { Comment.new }
    it "should set approved to true and save the comment" do
      expect(comment).to receive(:approved=).with(false)
      expect(comment).to receive(:save)
      comment.unapprove!
    end
  end

  describe '#approve!' do
    let(:comment) { Comment.new }
    it "should set approved to true" do
      expect(comment).to receive(:approved=).with(true)
      comment.approve
    end
  end
end
