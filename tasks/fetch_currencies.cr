#require "../spec/support/boxes/**"

# Add seeds here that are *required* for your app to work.
# For example, you might need at least one admin user or you might need at least
# one category for your blog posts for the app to work.
#
# Use `Db::CreateSampleSeeds` if your only want to add sample data helpful for
# development.
class FetchCurrencies < LuckyCli::Task
  summary "Add database records required for the app to work"

  def call
    puts "Calling the Fixer.io API to create currencies in the Database"
    response = FixerIoService.new.currencies

    currencies = CurrenciesResponse.from_json(response.body)

    puts "Saving the currencies to the database"
    SaveCurrency.import(currencies)

    puts "Done!"
  end
end
