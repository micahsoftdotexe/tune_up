defmodule TuneUpWeb.Orders.OrderListLive do
  use TuneUpWeb, :live_view

  def render(assigns) do
    ~H"""
    <p>Order List</p>
    """
  end

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

end
