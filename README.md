# ExPartisan

ExPartisan is an Elixir wrapper around the Erlang library Partisan, a membership
system that uses TCP.

## Usage

The current API exposes only a minimal set of methods, but enough to build something.
Nodes can be connected to each with `join/1`, and membership queried with
`members/0`. From there, messages can be sent to processes on nodes via
`send_message/3` and `cast_message/3`. The full API is listed in the documentation.

Note, neither ExPartisan nor Partisan provide a method to discover other nodes.
It is left up to the rest of the application to determine get that information.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `expartisan` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:expartisan, "~> 0.1.0"}
  ]
end
```
