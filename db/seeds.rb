# Create Users
5.times do
 User.create!(
  username: Faker::Internet.user_name,
  email: Faker::Internet.email,
  password: 'alicia1234',
  role: 'user'
 )
end
users = User.all
50.times do
 Wiki.create!(
   user:   users.sample,
   title:  Faker::Name.title,
   body:   Faker::Hipster.paragraph
 )
end
wikis = Wiki.all

admin = User.create!(
 username:     'AdminUser',
 email:    'admin@example.com',
 password: 'helloworld',
 role:     'admin'
)

# )
puts "Seed finished"
puts "#{User.count} users created"
puts "#{Wiki.count} wikis created"
