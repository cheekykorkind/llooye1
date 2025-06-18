require 'rails_helper'

RSpec.describe Author, type: :model do
  describe 'Associations' do
    it { should have_many(:books) }
  end

  describe 'Validations' do
    it { should validate_presence_of(:name) }

    it 'is valid with valid attributes' do
      author = Author.new(name: 'Jane Doe', date_of_birth: '1980-01-01', nationality: 'American')
      expect(author).to be_valid
    end

    it 'is not valid without a name' do
      author = Author.new(name: nil)
      expect(author).to_not be_valid
      expect(author.errors[:name]).to include("can't be blank")
    end
  end
end