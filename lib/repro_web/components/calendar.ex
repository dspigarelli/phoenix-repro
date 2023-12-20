defmodule ReproWeb.Component.Calendar do
  use ReproWeb, :live_component

  @child_count 100

  @impl true
  def update(assigns, socket) do
    {
      :ok,
      socket
      |> assign(assigns)
      |> assign(:child_count, @child_count)
      |> fetch_data()
    }
  end

  defp fetch_data(socket) do
    # initial call to clear out the child components' data
    for day <- 0..@child_count do
      send_update(ReproWeb.Component.Day,
        id: component_id(day),
        data: []
      )
    end

    # fetch the data asynchronously
    start_async(socket, :load_data, fn ->
      [%{id: :foo}]
    end)
  end

  @impl true
  def handle_async(:load_data, {:ok, data}, socket) do
    # for each child, update their data
    for day <- 0..@child_count do
      send_update(ReproWeb.Component.Day,
        id: component_id(day),
        data: Enum.map(data, &%{id: "#{day}-#{&1.id}"})
      )
    end

    {:noreply, socket}
  end

  def handle_async(_message, {:exit, _reason}, socket) do
    {:noreply, socket}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div id={@id}>
      <div :for={day <- 1..@child_count}>
        <.live_component id={component_id(day)} module={ReproWeb.Component.Day} />
      </div>
    </div>
    """
  end

  defp component_id(day), do: "day-#{day}"
end
