# Repro Steps

1. `mix deps.get`
2. `mix phx.server`
3. Open a browser to http://localhost:4000/repro and observe
4. Run the test with `mix test test/repro_web/live/repro_live_test.exs`

Here's some some sample output from the test. Note how the "render_async" awaits ~2.5 seconds

```
Running tests...
14:04:43.488 request_id=... [error] live /repro ==> 206.554ms
14:04:46.076 request_id=... [error] render_async ==> 2588.568ms
14:04:46.094 request_id=... [error] live /repro ==> 18.083ms
14:04:48.816 request_id=... [error] render_async ==> 2721.37ms
```
