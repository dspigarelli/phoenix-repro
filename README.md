# Repro Steps

1. `mix deps.get`
2. `mix phx.server`
3. Open a browser to http://localhost:4000/repro and observe
4. Run the test with `mix test test/repro_web/live/repro_live_test.exs`

Here's some some sample output from the test. Note how the "render_async" awaits ~5seconds

```
13:52:50.364 request_id=F6Ke8bucBsE11o8AAADG [error] live /repro ==> 202.032ms
13:52:55.916 request_id=F6Ke8bucBsE11o8AAADG [error] render_async ==> 5551.976ms
13:52:55.949 request_id=F6Ke8xIRYDk11o8AAAAB [error] live /repro ==> 32.343ms
13:53:01.412 request_id=F6Ke8xIRYDk11o8AAAAB [error] render_async ==> 5463.278ms
```
