# Announcement class
class Announcement < ApplicationRecord
  # changing an announcement needs to make the lecture cache key expire
  belongs_to :lecture, optional: true, touch: true
  belongs_to :announcer, class_name: 'User'

  validates :details,
            presence: { message: 'Es muss ein Text vorhanden sein.' }

  paginates_per 10

  # does there (still) exist a notification for the announcement for
  # the given user
  def active?(user)
    user.notifications.where(notifiable_type: 'Announcement',
                             notifiable_id: id).exists?
  end
end