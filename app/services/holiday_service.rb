class HolidayService < ApiService
  def holiday
    get_data("https://date.nager.at/api/v2/NextPublicHolidays/us")
  end
end
