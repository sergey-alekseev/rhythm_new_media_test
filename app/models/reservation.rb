class Reservation < ActiveRecord::Base
  validates :start_time, :end_time, :table_number, presence: true
  validate :start_and_end_time

  private

  def start_and_end_time
    if Reservation.exists? table_number: table_number, start_time: (start_time..end_time)
      errors.add(:start_time, 'there is a reservation for this time')
    end
    if Reservation.exists? table_number: table_number, end_time: (start_time..end_time)
      errors.add(:end_time, 'there is a reservation for this time')
    end
    errors.add(:start_time, 'must be before end time') if start_time >= end_time
  end
end
