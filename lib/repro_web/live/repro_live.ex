defmodule ReproWeb.Live.ReproLive do
  use ReproWeb, :live_view

  @impl true
  def render(assigns) do
    ~H"""
    <.live_component id="calendar" module={ReproWeb.Component.Calendar} />
    """
  end
end
