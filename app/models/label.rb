class Label < ApplicationRecord
  belongs_to :sensor
  has_many :results

  validates :title, presence: true,
            length: {minimum: 1}
  validates :group_mode, presence: true

  def current_value
    @result = self.results.last
    if @result.present?
      @result.value
    else
      "No data"
    end
  end

  def average_value
    sum = 0

    self.results.each do |result|
      sum += result.value
    end

    if self.results.count != 0
      sum / self.results.count
    else
      "No data"
    end
  end

  def graph_object
    case self.group_mode
           when "second"
             self.results.group_by_second(:created_at, "avg", "value")
           when "minute"
             self.results.group_by_minute(:created_at, "avg", "value")
           when "hour"
             self.results.group_by_hour(:created_at, "avg", "value")
           when "day"
             self.results.group_by_day(:created_at, "avg", "value")
           when "week"
             self.results.group_by_week(:created_at, "avg", "value")
           when "month"
             self.results.group_by_month(:created_at, "avg", "value")
           when "quarter"
             self.results.group_by_quarter(:created_at, "avg", "value")
           when "year"
             self.results.group_by_year(:created_at, "avg", "value")
           else
             self.results.group(:created_at).maximum(:value)
    end
  end
end
