defmodule ExPartisan do
  @moduledoc """
  Documentation for ExPartisan.
  """

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

  def forward_message(name, channel, server_ref, message, options) do
    :partisan_pluggable_peer_service_manager.forward_message(
      name,
      channel,
      server_ref,
      message,
      options
    )
  end

  def cast_message(name, channel, server_ref, message, options) do
    :partisan_pluggable_peer_service_manager.cast_message(
      name,
      channel,
      server_ref,
      message,
      options
    )
  end
end
