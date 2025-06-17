# spec/models/post_tag_spec.rb
require 'rails_helper'

RSpec.describe PostTag, type: :model do
  describe 'associations' do
    it { should belong_to(:post) }
    it { should belong_to(:tag) }
  end

  describe 'validations' do
    # To test the uniqueness scoped to post_id, we need to create a record first.
    # This requires factory_bot or direct creation.
    it 'validates uniqueness of tag_id scoped to post_id' do
      user = User.create!(nickname: 'tester', email: 'test@example.com', password: 'password')
      post = Post.create!(title: 'Test Post', content: 'Hello', user: user)
      tag = Tag.create!(name: 'Test Tag')
      PostTag.create!(post: post, tag: tag)

      # Build a new, unsaved PostTag with the same post and tag
      duplicate_post_tag = PostTag.new(post: post, tag: tag)

      expect(duplicate_post_tag).not_to be_valid
      expect(duplicate_post_tag.errors[:tag_id]).to include('has already been taken')
    end
  end
end