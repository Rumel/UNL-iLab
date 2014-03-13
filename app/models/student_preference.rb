# == Schema Information
#
# Table name: student_preferences
#
#  id         :integer          not null, primary key
#  student_id :integer
#  project_id :integer
#  rating     :integer
#  created_at :datetime
#  updated_at :datetime
#

class StudentPreference < ActiveRecord::Base
	belongs_to :project
	belongs_to :student
  has_one :sponsor, through: :project, source_type: "Sponsor"
  has_attached_file :cover_letter
  has_attached_file :resume
  before_save :rename_cover_letter
  before_save :rename_resume

	validates :project_id, :resume, :cover_letter, presence: true
	validates :student_id, presence: true
	validates :rating, presence: true

  def rename_cover_letter
    extension = File.extname(cover_letter_file_name).downcase
    self.cover_letter.instance_write :file_name, "#{self.student.full_name}-#{self.project.name}-CoverLetter#{extension}"
  end

  def rename_resume
    extension = File.extname(resume_file_name).downcase
    self.resume.instance_write :file_name, "#{self.student.full_name}-#{self.project.name}-Resume#{extension}"
  end
end
