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
Permission.create(name: "DeletePosts", description: "Ability to delete posts.")
Permission.create(name: "DeleteTopics", description: "Ability to delete topics.")
Permission.create(name: "Close", description: "Ability to close topics.")

user_role = Role.create(name: "User", description: "A user capable of posting and editing their profile.")
user_role.permissions = [Permission.find(1), Permission.find(2), Permission.find(3)]

admin_role = Role.create(name: "Administrator", description: "A user capable of accessing the Admin Dashboard.")
admin_role.permissions = Permission.all