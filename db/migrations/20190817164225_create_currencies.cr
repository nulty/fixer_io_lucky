class CreateCurrencies::V20190817164225 < Avram::Migrator::Migration::V1
  def migrate
    create table_for(Currency) do
      primary_key id : Int64
      add name : String
      add code : String, index: true, unique: true

      add_timestamps
    end
  end

  def rollback
    drop table_for(Currency)
  end
end
