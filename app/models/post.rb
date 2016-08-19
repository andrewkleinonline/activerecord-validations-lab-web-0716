class Post < ActiveRecord::Base
  validates :title, presence: true
  validates :content, length: { minimum: 250 }
  validates :summary, length: { maximum: 250 }
  validates :category, inclusion: { in: %w(Fiction Non-Fiction) }
  validate :title_must_contain_clickbait

  def title_must_contain_clickbait
    if title.present?
      required_phrases = [/Won't Believe/, /Secret/, /Top \d+/, /Guess/]

      match = required_phrases.any? do |phrase|
        title.match(phrase)
      end
      if !match
        errors.add(:title, "Title contains clickbait")
      end
    end
  end
end
