defmodule TuneUpWeb.Datatable do
  use Phoenix.LiveComponent

  def render(assigns) do
    ~H"""
    <div class="overflow-x-auto">
      <table class="table table-lg">
        <thead>
          <tr>
            <%= for {_col,title} <- @cols do %>
              <th><%= title %></th>
            <% end %>
          </tr>
        </thead>
        <tbody>
          <%= for row <- @rows do %>
            <tr>
              <%= for {col,_title} <- @cols do %>
                <td><%= Map.get(row, String.to_atom(col)) %></td>
              <% end %>
            </tr>
          <% end %>
        </tbody>
      </table>
      <div class="join">
        <%= if @page > 1 do %>
          <button
            phx-click="change_page"
            phx-value-increment={-1}
            phx-target={@myself}
            class="join-item btn"
          >
            «
          </button>
        <% else %>
          <button class="join-item btn" disabled>«</button>
        <% end %>
        <button class="join-item btn" disabled><%= @page %></button>
        <%= if @page < @total_pages do %>
          <button
            phx-click="change_page"
            phx-value-increment={1}
            phx-target={@myself}
            class="join-item btn"
          >
            »
          </button>
        <% else %>
          <button class="join-item btn" disabled>»</button>
        <% end %>
      </div>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    if socket.assigns[:page] == nil do
      {:ok, assign(socket, page: 1)}
    end
  end

  def handle_event("change_page", %{"increment" => value}, socket) do
    IO.puts("Here #{value}")
    send(self(), {:changed_page, String.to_integer(value) + socket.assigns[:page]})
    {:noreply, socket}
  end
end
