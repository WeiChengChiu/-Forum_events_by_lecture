class Event < ActiveRecord::Base
	has_many :attendees, :dependent => :destroy
	has_one :location, :dependent => :destroy
	has_many :event_groupships
	has_many :groups, :through => :event_groupships
	belongs_to :category
	validates_presence_of :name
end
