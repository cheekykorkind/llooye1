# spec/models/post_spec.rb
require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:content) }
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:comments).dependent(:destroy) }
    it { should have_many(:post_tags).dependent(:destroy) }
    it { should have_many(:tags).through(:post_tags) }
  end

  describe 'enum' do
    it { should define_enum_for(:status).with_values(draft: 0, published: 1) }
  end

  describe 'defaults' do
    it 'defaults status to draft' do
      # Note: This test can be fulfilled by a DB default or an after_initialize callback
      expect(Post.new.status).to eq('draft')
    end
  end
end