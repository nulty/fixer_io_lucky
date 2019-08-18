class CreateRates::V20190818113947 < Avram::Migrator::Migration::V1
  def migrate
    create table_for(Rate) do
      primary_key id : Int64

      add_belongs_to base_currency : Currency, on_delete: :restrict
      add_belongs_to conversion_currency : Currency, on_delete: :restrict

      add rate : Float64
      add date : Time

      add_timestamps
    end
  end

  def rollback
    drop table_for(Rate)
  end
end
