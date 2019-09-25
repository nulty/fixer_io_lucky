class Dashboard::ShowPage < MainLayout
  needs base_currencies : CurrencyQuery
  needs conversion_currencies : CurrencyQuery
  needs rates : RateQuery

  def content
    div class: "columns" do
      div do
        ul do
          @base_currencies.each do |curr|
            li do
              text curr.name
            end
          end
        end
      end
      div do
        ul do
          @conversion_currencies.each do |curr|
            li curr.name
          end
        end
      end
      div do
        ul do
          @rates.each do |rate|
            li rate.rate.to_s
          end
        end
      end
    end
  end
end
