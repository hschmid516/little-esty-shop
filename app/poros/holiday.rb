class Holiday
  attr_reader :name, :date

  def initialize(holiday_data)
    @name = holiday_data[:name]
    @date = holiday_data[:date]
  end
end
