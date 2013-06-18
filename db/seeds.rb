# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

transformation_seed_folders = Dir.glob(File.join(File.dirname(__FILE__), "transformation_seeds", "*"))

transformation_seed_folders.each do |transformation_seed_folder|
  params = {
    code: File.read(File.join(transformation_seed_folder, "code.etl")),
    source_metamodel: File.read(File.join(transformation_seed_folder, "source.emf")),
    target_metamodel: File.read(File.join(transformation_seed_folder, "target.emf"))
  }
  
  extra_params = JSON.parse(File.read(File.join(transformation_seed_folder, "params.json")), symbolize_names: true)
  
  Transformation.create(params.merge(extra_params))
end