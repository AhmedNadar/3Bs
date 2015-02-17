class Post < ActiveRecord::Base
  default_scope -> { order('created_at DESC') }

  extend FriendlyId
  friendly_id :title, use: [:slugged, :history]

  # valicdations
  validates_presence_of :title, :slug, :intro, :content

  def should_generate_new_friendly_id?
    title_changed?
  end
end
