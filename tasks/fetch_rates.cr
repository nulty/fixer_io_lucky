class FetchRates < LuckyCli::Task
  summary "Add database records required for the app to work"

  def call
    puts "Calling the Fixer.io API to create rates in the Database"
    response = FixerIoService.new.latest

    rates = RatesResponse.from_json(response.body)

    puts "Saving the rates to the database"
    SaveRate.import(rates)

    puts "Done!"
  end
end
