# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Category.find_or_create_by_title('Домакинска работа')
Category.find_or_create_by_title('Монтажни')
Category.find_or_create_by_title('Хамалски')
Category.find_or_create_by_title('Ремонт')
Category.find_or_create_by_title('Транспорт')
Category.find_or_create_by_title('Пазаруване')
Category.find_or_create_by_title('Промотиране')
Category.find_or_create_by_title('Дом. любимци')
Category.find_or_create_by_title('Градина')
Category.find_or_create_by_title('Козметични')
Category.find_or_create_by_title('Писане')
Category.find_or_create_by_title('Преводи')
