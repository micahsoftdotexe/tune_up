defmodule TuneUp.Orders do
  import Ecto.Query

  def createOrderList(
        %{"page" => page, "page_size" => pagesize},
        filters \\ [],
        %{"column" => order_by_column, "direction" => order_by_direction} \\ %{
          "column" => "date",
          "direction" => "desc"
        }
      ) do
    query =
      from o in TuneUp.Orders.Order,
        join: c in assoc(o, :customer),
        as: :customers,
        join: a in assoc(o, :automobile),
        as: :automobiles,
        order_by: ^apply_order_by(order_by_column, order_by_direction),
        select: {o.id, o.date, o.stage, o.tax, c.first_name, c.last_name, a.make, a.model, a.year}

    results = TuneUp.Repo.paginate(query, page: page, page_size: pagesize)

    %{
      results
      | entries:
          Enum.map(
            results.entries,
            fn {id, date, stage, tax, first_name, last_name, make, model, year} ->
              %{
                id: id,
                date: date,
                stage: stage,
                tax: Decimal.to_string(tax),
                full_name: "#{first_name} #{last_name}",
                make: make,
                model: model,
                year: year
              }
            end
          )
    }
  end

  defp apply_order_by(column, direction) do
    order_by =
      case column do
        "full_name" ->
          if direction == "desc",
            do: [desc: dynamic([customers: c], c.last_name)],
            else: [asc: dynamic([customers: c], c.last_name)]

        "make" ->
          if direction == "desc",
            do: [desc: dynamic([automobiles: a], a.make)],
            else: [asc: dynamic([automobiles: a], a.make)]

        "model" ->
          if direction == "desc",
            do: [desc: dynamic([automobiles: a], a.model)],
            else: [asc: dynamic([automobiles: a], a.model)]

        "date" ->
          if direction == "desc", do: [desc: :date], else: [asc: :date]
      end

    order_by
  end
end
