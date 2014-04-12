require 'spec_helper'

describe Reservation do
  subject { Reservation }
  let(:start_time)   { Time.new(2014, 4, 12, 21) }
  let(:duration)     { 2.hours }
  let(:end_time)     { start_time + duration }
  let(:table_number) { 1 }

  describe 'booking' do
    before(:each) do
      subject.create!(start_time: start_time,
                      end_time: end_time,
                      table_number: table_number)
    end
    after { subject.destroy_all }

    it 'allows to book a free table' do
      expect(subject.new(start_time:   start_time,
                         end_time:     end_time,
                         table_number: table_number + 1)).to be_valid
      expect(subject.new(start_time:   start_time - duration,
                         end_time:     end_time - duration - 1,
                         table_number: table_number)).to be_valid
      expect(subject.new(start_time:   start_time + duration + 1,
                         end_time:     end_time + duration,
                         table_number: table_number)).to be_valid
    end

    it 'disallows to book a reserved table' do
      expect(subject.new(start_time:   start_time,
                         end_time:     end_time,
                         table_number: table_number)).not_to be_valid
      expect(subject.new(start_time:   start_time - duration,
                         end_time:     end_time - duration,
                         table_number: table_number)).not_to be_valid
      expect(subject.new(start_time:   start_time + duration,
                         end_time:     end_time + duration,
                         table_number: table_number)).not_to be_valid
      expect(subject.new(start_time:   start_time - (duration / 2),
                         end_time:     end_time - (duration / 2),
                         table_number: table_number)).not_to be_valid
      expect(subject.new(start_time:   start_time + (duration / 2),
                         end_time:     end_time + (duration / 2),
                         table_number: table_number)).not_to be_valid
    end
  end
end
