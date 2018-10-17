defmodule ExPartisan do
  @moduledoc """
  """

  @opaque partisan_node :: map
  @type name :: atom | {:global, term} | {:via, module, term}
  @type server :: pid | name | {atom, node}

  @doc """
  Returns a map containing configuration settings about the node the
  function is executing on.

  ## Examples

      iex> ExPartisan.myself()
      %{
        channels: [:undefined],
        listen_addrs: [%{ip: {127, 0, 0, 1}, port: 51275}],
        name: :"119ee492-d000-11e8-b14a-80e0ef1a496c@127.0.0.1",
        parallelism: 1
      }

  * `channels` is a list of different named channels to open.
  * `listen_addrs` is a list of addresses and ports to bind to on the localhost
  * `name` is the node name, defaults to one generated with a uuid if not specified with `--name`
  * `parallelism` is the number of TCP connections to open per channel

  The are currently no exposed methods to change these in the API.
  """
  @spec myself() :: partisan_node
  def myself do
    :partisan_pluggable_peer_service_manager.myself()
  end

  @doc """
  Connects the calling node to the one specified by `node` which is a map
  of the same form as the one returned by `myself/0`

  ## Examples

      iex(foo@127.0.0.1)> bar = %{channels: [:undefined], listen_addrs: [%{ip: {127,0,0,1}, port: 56013}], name: :"bar@127.0.0.1", parallelism: 1}
      %{
        channels: [:undefined],
        listen_addrs: [%{ip: {127, 0, 0, 1}, port: 56013}],
        name: :"bar@127.0.0.1",
        parallelism: 1
      }
      iex(foo@127.0.0.1)> ExPartisan.join(bar)
      :ok

  """
  @spec join(node :: partisan_node) :: :ok
  def join(%{} = node) do
    :partisan_pluggable_peer_service_manager.join(node)
  end

  @doc """
  Returns a list with all of the nodes that the calling node is connected to.

  ## Examples

      iex(foo@127.0.0.1)> ExPartisan.members
      {:ok, [:"foo@127.0.0.1", :"bar@127.0.0.1"]}


  """
  @spec members() :: {:ok, [partisan_node]}
  def members() do
    :partisan_pluggable_peer_service_manager.members()
  end

  @doc """
  Disconnects the calling node from other nodes connected via `join/1`.

  ## Examples

  """
  @spec leave() :: :ok
  def leave() do
    :partisan_pluggable_peer_service_manager.leave()
  end

  @doc """
  Disconnects the specified `node`.
  """
  @spec leave(node :: partisan_node) :: :ok
  def leave(node) do
    :partisan_pluggable_peer_service_manager.leave(node)
  end

  @doc """
  Sends a message to a process living on `node`. This is analogous to
  `Kernel.send/2`.
  """
  @spec send_message(node :: partisan_node, server_ref :: server, message :: term) :: :ok
  def send_message(node, server_ref, message) do
    forward_message(node, :undefined, server_ref, message, [{:transitive, true}])
  end

  @doc """
  Sends a message to a GenServer. This is analogous to `GenServer.cast`.
  """
  @spec cast_message(node :: partisan_node, server_ref :: server, message :: term) :: :ok
  def cast_message(node, server_ref, message) do
    cast_message(node, :undefined, server_ref, message, [{:transitive, true}])
  end

  defp forward_message(
         name,
         channel,
         server_ref,
         message,
         options
       ) do
    :partisan_pluggable_peer_service_manager.forward_message(
      name,
      channel,
      server_ref,
      message,
      options
    )
  end

  defp cast_message(
         name,
         channel,
         server_ref,
         message,
         options
       ) do
    :partisan_pluggable_peer_service_manager.cast_message(
      name,
      channel,
      server_ref,
      message,
      options
    )
  end
end
