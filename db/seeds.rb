# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Permission.create(name: "Post", description: "Ability to post.")
Permission.create(name: "Create", description: "Ability to start a topic.")
Permission.create(name: "View", description: "Ability to view a topic.")
Permission.create(name: "Delete Posts", description: "Ability to delete posts.")
Permission.create(name: "Delete Topics", description: "Ability to delete topics.")
Permission.create(name: "Close", description: "Ability to close topics.")

user_role = Role.create(name: "User", description: "A user capable of posting and editing their profile.")
user_role.permissions = [Permission.find(1), Permission.find(2), Permission.find(3)]

admin_role = Role.create(name: "Admin", description: "A user capable of accessing the Admin Dashboard.")
admin_role.permissions = Permission.all

User.create(name: "Admin", email: "admin@istrator.com", password: "Echidna5")

Category.create(name: "Neopets", description: "A virtual pets site.", position: 0)
Forum.create(name: "Types of pets", description: "There are many different types of pets.", position: 0, parent_id: 1, parent_type: "Category")
