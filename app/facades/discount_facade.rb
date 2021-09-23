class DiscountFacade
  def holiday_api
    holiday_data = HolidayService.new.holiday
    @holidays = holiday_data[0..2].map do |holiday|
      Holiday.new(holiday)
    end
  end
end
