defmodule TuneUpWeb.Orders.OrderListLive do
  alias TuneUpWeb.Components.Datatable
  alias TuneUp
  use TuneUpWeb, :live_view

  def render(assigns) do
    ~H"""
    <p>Order List</p>
    <form id="pickr-form" action="#" phx-change="validate">
      <div id="starts-at-pickr" phx-update="ignore" phx-hook="Pickr" data-pickr-alt-format="d M Y">
        <label for="starts-at">Starts at</label>
        <input
          type="text"
          class="flatpickr flatpickr-input"
          id="starts-at"
          name="pickr[starts_at]"
          placeholder="Select Start Date.."
          data-input
        />
      </div>
    </form>
    <.live_component
      id="123"
      module={Datatable}
      rows={@order_information.entries}
      cols={[
        {"full_name", "Name"},
        {"make", "Make"},
        {"model", "Model"},
        {"date", "Date"},
        {"stage", "Stage"}
      ]}
      filters={
        %{
          "full_name" => "string",
          "make" => "string",
          "model" => "string",
          "date" => "date",
          "stage" => "string"
        }
      }
      paginate={true}
      page={@order_information.page_number}
      page_size={@order_information.page_size}
      total_pages={@order_information.total_pages}
    />
    """
  end

  @spec mount(any(), any(), any()) :: {:ok, any()}
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(
       order_information:
         TuneUp.Orders.createOrderList(%{"page" => 1, "page_size" => 10}, [], %{
           "column" => "date",
           "direction" => "desc"
         })
     )}
  end

  @spec handle_info({:changed_page, any()}, any()) :: {:noreply, any()}
  def handle_info({:changed_page, page}, socket) do
    {:noreply,
     socket
     |> assign(
       order_information: TuneUp.Orders.createOrderList(%{"page" => page, "page_size" => 10})
     )}
  end
end
