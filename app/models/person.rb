# == Schema Information
#
# Table name: people
#
#  id           :integer          not null, primary key
#  firstname    :string(255)
#  lastname     :string(255)
#  phone        :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#  household_id :integer
#  email        :string(255)
#

class Person < ActiveRecord::Base
#  has_notes
  has_and_belongs_to_many :notes
  belongs_to :household, autosave: true
  has_one :user, autosave: true
  validates_presence_of :firstname, :lastname, :household
  validates_associated :household

  def fullname
    if lastname
      "#{firstname} #{lastname}"
    else
      firstname
    end
  end

  def formal_name
    fn = lastname if lastname
    fn += ', ' if fn and firstname and fn.length > 0 and firstname.length > 0
    fn += firstname if firstname and firstname.length > 0
    fn
  end
end
