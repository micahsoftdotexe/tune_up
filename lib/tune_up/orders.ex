defmodule TuneUp.Orders do
  import Ecto.Query



  def createOrderList(page \\ 1, pagesize \\ 10) do
    query  = from o in TuneUp.Orders.Order, join: c in assoc(o, :customer), join: a in assoc(o, :automobile),  select: {o.id, o.tax, c.first_name, c.last_name, a.make, a.model, a.year}
    results =  TuneUp.Repo.paginate(query, page: page, page_size: pagesize)
    %{results | entries: Enum.map(results.entries, fn {id, tax, first_name, last_name, make, model, year} -> %{id: id, tax: Decimal.to_string(tax), full_name: "#{first_name} #{last_name}", make: make, model: model, year: year} end)}
  end
end
