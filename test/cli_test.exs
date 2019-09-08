defmodule CLITest do
  use ExUnit.Case
  doctest Issues

  import Issues.CLI, only: [parse_args: 1]

  test "help returned" do
    assert parse_args(["-h", "anything"]) == :help
    assert parse_args(["--help", "anything"]) == :help
  end

  test "three values" do
    assert parse_args(["user", "product", "3"]) == ["user", "product", 3]
  end

  test "two values" do
    assert parse_args(["user", "product"]) == ["user", "product", 4]
  end

end
