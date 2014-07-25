# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#   create all the tutors with empty tutor things
User.delete_all
Tutoringsession.delete_all
Tutorability.delete_all
Request.delete_all
tutors=["isamol1@nths219.org"]#emails are unique
klasses=["Algebra 1 Regular","Algebra 1 Honors", "Algebra 1 Advanced", "Geometry Regular", "Geometry Advanced", "Geometry Honors", "Algebra 2 Regular", "Algebra 2 Advanced", "Algebra 2 Honors"]
tutors.each do |tutor|
u=User.create(email:tutor)
	klasses.each do |klass|
		u.tutorabilities<<Tutorability.create(class_name:klass,ability:0)
	end
end