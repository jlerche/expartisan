defmodule ExPartisan do
  @moduledoc """
  Documentation for ExPartisan.
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

  """
  @spec myself() :: partisan_node
  def myself do
    :partisan_pluggable_peer_service_manager.myself()
  end

  @doc """

  """
  @spec join(node :: partisan_node) :: :ok
  def join(%{} = node) do
    :partisan_pluggable_peer_service_manager.join(node)
  end

  @doc """

  """
  @spec members() :: [partisan_node]
  def members() do
    :partisan_pluggable_peer_service_manager.members()
  end

  @doc """

  """
  @spec leave() :: :ok
  def leave() do
    :partisan_pluggable_peer_service_manager.leave()
  end

  @doc """

  """
  @spec leave(node :: partisan_node) :: :ok
  def leave(node) do
    :partisan_pluggable_peer_service_manager.leave(node)
  end

  @doc """

  """
  @spec forward_message(node :: partisan_node, server_ref :: server, message :: term) :: :ok
  def forward_message(node, server_ref, message) do
    forward_message(node, :undefined, server_ref, message, [{:transitive, true}])
  end

  @doc """

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
