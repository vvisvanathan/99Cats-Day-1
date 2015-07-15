# == Schema Information
#
# Table name: cat_rental_requests
#
#  id         :integer          not null, primary key
#  cat_id     :integer          not null
#  start_date :date             not null
#  end_date   :date             not null
#  status     :string           default("PENDING")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class CatRentalRequest < ActiveRecord::Base
  validates :cat_id, :start_date, :end_date, :status, presence: true
  validates :status, inclusion: %w(APPROVED DENIED PENDING)
  validate :correctly_ordered_date
  validate :no_overlapping_approved_requests

  belongs_to(
    :cat,
    class_name: Cat,
    foreign_key: :cat_id,
    primary_key: :id
  )

  def approve!
    self.status = "APPROVED"
    to_deny = overlapping_pending_requests
    to_deny.each do |request|
      request.status = "DENIED"
    end
    CatRentalRequest.transaction do
      self.save
      to_deny.each do |request|
        request.save!
      end
    end
  end

  def deny!
    self.status = "DENIED"
    self.save
  end

  def pending?
    self.status == "PENDING"
  end

  private

  def overlapping_pending_requests
    overlapping_requests.select { |request| request.status == "PENDING"}
  end

  def correctly_ordered_date
    # TODO whaaa?
    if self.start_date && self.end_date && self.start_date > self.end_date
      errors[:start_date] << "dates are in wrong order"
    end
  end

  def overlapping_requests
    cat_dates = Cat.find_by_id(self.cat_id).cat_rental_requests
    cat_dates.select do |cat_date|
      # TODO want variables not symbols
      self.id != cat_date.id &&
      (self.start_date.between?(cat_date.start_date, cat_date.end_date) ||
      self.end_date.between?(cat_date.start_date, cat_date.end_date))
    end
  end

  def overlapping_approved_requests
    overlapping_requests.select { |request| request.status == "APPROVED"}
  end

  def no_overlapping_approved_requests
    unless status != "APPROVED" || overlapping_approved_requests.empty?
      errors[:start_date] << "overlapping approved requests!"
    end
  end
end
