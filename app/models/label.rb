class Label < ApplicationRecord
  belongs_to :sensor
  has_many :results

  validates :title, presence: true,
            length: {minimum: 1}
  validates :group_mode, presence: true
  validates :time_range, presence: true

  validates_inclusion_of :group_mode, :in => :time_selection_values
  validates_inclusion_of :time_range, :in => :time_selection_values

  enum time_mode: [ :period, :current ]

  def current_value
    @result = results_in_time_range.last unless results_in_time_range.nil?
    if @result.present?
      @result.value
    else
      "No data"
    end
  end

  def average_value
    if not results_in_time_range.nil?

      sum = 0

      results_in_time_range.each do |result|
        sum += result.value
      end

      if results_in_time_range.count != 0
        sum / results_in_time_range.count
      else
        "No data"
      end

    else
      "No data"
    end
  end

  def graph_object
    results_by_group_mode
  end

  def results_by_group_mode
    unless results_in_time_range.nil?
      group_by_method = 'group_by_' + self.group_mode
      if self.results.respond_to? group_by_method
        results_in_time_range.public_send(group_by_method, :created_at, "avg", "value")
      else
        results_in_time_range.group(:created_at).average(:value)
      end
    end
  end

  def results_in_time_range
    if self.time_range == 'default' or self.time_range.nil?
      return self.results
    end

    if self.time_mode == 'period'
      if 1.respond_to? self.time_range
        self.results.where(:created_at => 1.public_send(self.time_range).ago..Time.now)
      end
    else
      time_method = 'beginning_of_' + self.time_range
      if Time.now.respond_to? time_method
        self.results.where(:created_at => Time.now.public_send(time_method)..Time.now)
      end
    end
  end

  def time_selection_values
    %w(default second minute hour day week month quarter year)
  end
end
