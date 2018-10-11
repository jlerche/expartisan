defmodule ExPartisan do
  @moduledoc """
  Documentation for ExPartisan.
  """

  @opaque partisan_node :: map

  @spec myself() :: partisan_node
  def myself do
    :partisan_pluggable_peer_service_manager.myself()
  end

  @spec join(node :: partisan_node) :: :ok
  def join(%{} = node) do
    :partisan_pluggable_peer_service_manager.join(node)
  end

  def members() do
    :partisan_pluggable_peer_service_manager.members()
  end

  def leave() do
    :partisan_pluggable_peer_service_manager.leave()
  end

  def leave(node) do
    :partisan_pluggable_peer_service_manager.leave(node)
  end

  def forward_message(name, server_ref, message) do
    forward_message(name, :undefined, server_ref, message, [{:transitive, true}])
  end

  def cast_message(name, server_ref, message) do
    cast_message(name, :undefined, server_ref, message, [{:transitive, true}])
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
