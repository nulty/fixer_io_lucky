class FetchRates < LuckyCli::Task
  summary "Add database records required for the app to work"
  AVAILABLE_BASE = ["EUR"]

  def call
    all_rates = ENV["ALL_RATES"]?
    unless ENV["DATE"]?
      Lucky.logger.error("DATE is required")
      exit
    end

    Lucky.logger.info "Date: #{date_arg}"
    Lucky.logger.info "Calling the Fixer.io API to create rates in the Database"

    if all_rates
      CurrencyQuery.all.code(AVAILABLE_BASE).each do |curr|
        perform(curr)
      end
    else
      perform
    end

    Lucky.logger.info "Done!"
  end

  private def perform
    response = FixerIoService.new.historical(date_arg)

    rates = RatesResponse.from_json(response.body)

    Lucky.logger.info "Saving the rates to the database"

    SaveRate.import(rates)
  end

  def perform(curr)
    response = FixerIoService.new.historical(date_arg, curr.code)

    rates = RatesResponse.from_json(response.body)

    if rates.success == true
      Lucky.logger.info "Saving the rates to the database"

      SaveRate.import(rates)
    elsif rates.success == false && (error = rates.error)
      Lucky.logger.info "An error occurred:\n"
      Lucky.logger.info error.type
    end
  end

  def date_arg : String
    ENV["DATE"]? || yesterday
  end

  def yesterday
    Time::Format.new("%F",Time::Location.local).format(Time.local - 1.day)
  end

end
