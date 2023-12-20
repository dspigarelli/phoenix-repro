defmodule ReproWeb.Component.Day do
  use ReproWeb, :live_component

  @impl true
  def update(%{data: data}, socket) do
    {:ok, assign(socket, data: data)}
  end

  def update(assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:data, fn -> [] end)}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div id={@id}>
      <div :for={data <- @data} id={data.id}>
        <%= inspect(@data) %>
      </div>
    </div>
    """
  end
end
