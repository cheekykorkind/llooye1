bundle exec rails g model Book title:text author:text published_year:integer isbn:text price:float stock_quantity:integer author:references

bundle exec rails g model Author name:text date_of_birth:datetime nationality:text

bundle exec rails g model Order order_number:text order_date:datetime total_price:float status:integer

bundle exec rails g model OrderItem quantity:integer unit_price:float order:references book:references
