class Dashboard::ShowPage < MainLayout
  needs base_currencies : CurrencyQuery
  needs conversion_currencies : CurrencyQuery

  def content
    div class: "columns" do
      form id: "converter-form", action: "/rates", method: "POST", "data-remote": "true" do
        div do
          select_tag id: "base-currency", name: "base-currency" do
            option "Pick a Base Currency"
            @base_currencies.each do |curr|
              option curr.name, value: curr.id.to_s
            end
          end
        end
        div do
          select_tag id: "conversion-currency", name: "conversion-currency"  do
            option "Pick a Conversion Currency"
            @conversion_currencies.each do |curr|
              option curr.name, value: curr.id.to_s
            end
          end
        end
        button "Submit", type: "submit"
        div do
          span id: "converted-rate"
        end
      end
    end
  end
end
