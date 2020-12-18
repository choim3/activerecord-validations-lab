class Post < ActiveRecord::Base
  validates_presence_of :title
  validates :content, length: {minimum: 250}
  validates :summary, length: {maximum: 250}
  validates :category, inclusion: { in: %w(fiction non-fiction)}
  validate :clickbait_y

  CLICKBAIT_PATTERNS = [
  /Won't Believe/i,
  /Secret/i,
  /Top [0-9]*/i,
  /Guess/i,
]
  def clickbait_y
    if CLICKBAIT_PATTERNS.none? { |pat| pat.match title }
      errors.add(:title, "must be clickbait")
    end
  end
end

#
# create_table "posts", force: :cascade do |t|
#   t.string   "title"
#   t.text     "content"
#   t.text     "summary"
#   t.string   "category"
