defmodule ReproWeb.Component.Day do
  use ReproWeb, :live_component

  @impl true
  def update(%{data: data}, socket) do
    {:ok, stream(socket, :data, data, reset: true)}
  end

  def update(assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> stream(:data, [])}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div id={@id} phx-update="stream">
      <div :for={{id, data} <- @streams.data} id={id}>
        <%= id %>: <%= inspect(data) %>
      </div>
    </div>
    """
  end
end
