require 'spec_helper'

describe 'Approving and unapproving comments in Tenon' do
  context 'approving a comment' do
    before do
      @post = Tenon::Post.create!(title: 'Test')
      @comment = @post.comments.create!(author: 'Sean', author_email: 'sean@factore.ca', content: 'Test')
    end

    it 'should mark the comment as approved' do
      visit comments_path

    end
  end
end
