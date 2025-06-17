- 커멘드1
  - gem install rails --version 7.0.3.1
  - gem uninstall concurrent-ruby
  - gem install concurrent-ruby -v 1.3.4
  - rails new . -d postgresql
- Gemfile에 추가
  - gem 'concurrent-ruby', '1.3.4'
  - gem "rspec-rails"
  - gem 'factory_bot_rails'
  - gem 'faker'
  bundle install
  bundle exec rails generate rspec:install
  database.yml 수정
  bundle exec rails db:create db:migrate
  bundle exec rspec

bundle exec rails g model User nickname:string email:text password_digest:text
bundle exec rails g model Post title:string content:text published_at:datetime status:integer user:references

has many는 references로 만든다. one의 모델 파일에 has many는 직접 적어줘야 한다.
bundle exec rails g model Comment body:string user:references post:references

유니크는 마이그레이션과 모델파일에 따로 적는다
bundle exec rails g model Tag name:string
# app/models/user.rb
class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true
end
# db/migrate/YYYY..._create_users.rb
class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :name
      # 아래와 같이 email 컬럼에 인덱스 옵션을 추가합니다.
      t.string :email, index: { unique: true }

      t.timestamps
    end
  end
end

중간 모델 만들기.
bundle exec rails g model PostTag post:references tag:references

