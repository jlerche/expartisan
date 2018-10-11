defmodule ExPartisan.Vclock do
  @moduledoc """
  Vector clock implementation
  """

  @type counter :: integer
  @type vclock_node :: term
  @type vc_entry :: {vclock_node, counter}
  @type binary_vclock :: binary
  @type vclock :: [vc_entry]

  @spec fresh :: vclock
  def fresh, do: []

  @doc """
  Return true if vec_a is a direct descendant ov vec_b, else false -- remember a vclock is its own descendant!
  """
  @spec descends(vclock, vclock) :: boolean
  def descends(_, []), do: true

  def descends(vec_a, vec_b) do
    [{node_b, counter_b} | tail_b] = vec_b

    case List.keyfind(vec_a, node_b, 1) do
      nil ->
        false

      {_, counter_a} ->
        counter_a >= counter_b and descends(vec_a, tail_b)
    end
  end

  @spec dominates(vclock, vclock) :: boolean
  def dominates(vec_a, vec_b), do: descends(vec_a, vec_b) and not descends(vec_b, vec_a)

  @spec subtract_dots(vclock, vclock) :: vclock
  def subtract_dots(dot_list, vclock) do
    drop_dots(dot_list, vclock, [])
  end

  defp drop_dots([], _clock, new_dots) do
    Enum.sort(new_dots)
  end

  defp drop_dots([{actor, count} = dot | rest], clock, acc) do
    case get_counter(actor, clock) do
      cnt when cnt >= count -> drop_dots(rest, clock, acc)
      _ -> drop_dots(rest, clock, [dot | acc])
    end
  end

  @spec get_counter(vclock_node, vclock) :: counter
  def get_counter(node, vclock) do
    case List.keyfind(vclock, node, 1) do
      {_, counter} -> counter
      nil -> 0
    end
  end

  @spec increment(node :: vclock_node, vclock :: vclock) :: vclock
  def increment(node, vclock) do
    {ctr, new_v} =
      case List.keytake(node, vclock, 1) do
        nil -> {1, vclock}
        {{_other_node, counter}, mod_v} -> {counter + 1, mod_v}
      end

    [{node, ctr} | new_v]
  end

  def all_nodes(vclock) do
    for {x, _} <- Enum.sort(vclock) do
      x
    end
  end
end
