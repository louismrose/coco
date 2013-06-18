# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

transformation_seeds = Dir.glob(File.join(File.dirname(__FILE__), "transformation_seeds", "**", "*.*"))

transformation_seeds.each_slice(3) do |transformation_seed|
  Transformation.create(
    code: File.read(transformation_seed[0]),
    source_metamodel: File.read(transformation_seed[1]),
    target_metamodel: File.read(transformation_seed[2])
  )
end