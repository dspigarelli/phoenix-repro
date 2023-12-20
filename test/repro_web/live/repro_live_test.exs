defmodule ReproWeb.Live.ReproLiveTest do
  use ReproWeb.ConnCase

  require Logger

  import Phoenix.LiveViewTest

  test "repro", %{conn: conn} do
    # this shows that the first live render takes longer to "warm up"
    {:ok, view, _html} = elapsed(fn -> live(conn, ~p"/repro") end, "live /repro")
    elapsed(fn -> render_async(view) end, "render_async")

    {:ok, view, _html} = elapsed(fn -> live(conn, ~p"/repro") end, "live /repro")
    elapsed(fn -> render_async(view) end, "render_async")
  end

  defp elapsed(func, message) do
    :timer.tc(func)
    |> tap(fn {usec, _result} ->
      Logger.error("#{message} ==> #{usec / 1000}ms")
    end)
    |> elem(1)
  end
end
