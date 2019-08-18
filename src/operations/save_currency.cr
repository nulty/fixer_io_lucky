class SaveCurrency < Currency::SaveOperation
  def self.import(response)
    response.each do |code, name|
      begin
        currency = CurrencyQuery.new.code(code).first
        if currency.name != name
          SaveCurrency.update!(currency, name: name)
        end
      rescue Avram::RecordNotFoundError
        SaveCurrency.create!(name: name, code: code)
      end
    end
  end
end
