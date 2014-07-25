class Tutoringsession < ActiveRecord::Base
	belongs_to :user
	belongs_to :tutor, class_name: 'User'
end
