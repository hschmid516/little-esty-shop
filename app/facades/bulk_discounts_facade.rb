class BulkDiscountsFacade
  def holiday_api
    holiday_data = HolidayService.new.holiday
    @holidays = holiday_data.filter_map do |hol|
      Holiday.new(hol)
    end
  end
end
