defmodule ExPartisan do
  @moduledoc """
  Documentation for ExPartisan.
  """
  use Application

  def start(_, _) do
    ExPartisan.Supervisor.start_link(name: ExPartisan.Supervisor)
  end
end
