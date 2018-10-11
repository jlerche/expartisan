defmodule ExPartisan.MochiglobalTest do
  use ExUnit.Case
  alias ExPartisan.Mochiglobal

  test "put" do
    key = :put
    assert :ok == Mochiglobal.put(key, :value)
    assert :value == Mochiglobal.get(key)
  end

  test "delete" do
    key = :test_delete
    assert :ok == Mochiglobal.put(key, :value)
    assert :value == Mochiglobal.get(key)
    Mochiglobal.delete(key)
    assert :undefined == Mochiglobal.get(key)
  end

  test "getting never set value returns :undefined" do
    key = :never_set
    assert :undefined == Mochiglobal.get(key)
  end
end
