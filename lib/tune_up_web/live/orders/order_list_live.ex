defmodule TuneUpWeb.Orders.OrderListLive do
  alias TuneUpWeb.Datatable
  alias TuneUp
  use TuneUpWeb, :live_view

  def render(assigns) do
    ~H"""
    <p>Order List</p>
    <.live_component id="123" module={Datatable}
    rows={@order_information.entries} cols={[{"id", "Id"}, {"full_name", "Name"}]}
    paginate={true}
    page={@order_information.page_number}
    page_size={@order_information.page_size}
    total_pages={@order_information.total_pages}
    />
    """
  end

  @spec mount(any(), any(), any()) :: {:ok, any()}
  def mount(_params, _session, socket) do
    {:ok, socket
      |> assign(order_information: TuneUp.Orders.createOrderList())}
  end

  @spec handle_info(any(), any()) :: none()
  def handle_info({:changed_page, page}, socket) do
    { :noreply, socket |> assign(order_information: TuneUp.Orders.createOrderList(page)) }
  end

end
