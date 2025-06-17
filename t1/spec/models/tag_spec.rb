# spec/models/tag_spec.rb
require 'rails_helper'

RSpec.describe Tag, type: :model do
  describe 'validations' do
    # Create a dummy record first to test uniqueness
    subject { Tag.create(name: 'Technology') }
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name).case_insensitive }
  end

  describe 'associations' do
    it { should have_many(:post_tags).dependent(:destroy) }
    it { should have_many(:posts).through(:post_tags) }
  end
end