defmodule Credo.CLI.Filename do
  @moduledoc false

  @doc """
  Returns `true` if a given `filename` contains a pos_suffix.

      iex> Credo.CLI.Filename.contains_line_no?("lib/credo/sources.ex:39:8")
      true

      iex> Credo.CLI.Filename.contains_line_no?("lib/credo/sources.ex:39")
      true

      iex> Credo.CLI.Filename.contains_line_no?("lib/credo/sources.ex")
      false
  """
  def contains_line_no?(filename) do
    count =
      filename
      |> String.split(":")
      |> Enum.count

    count == 2 || count == 3
  end

  @doc """
  Returns a suffix for a filename, which contains a line and column value.

      iex> Credo.CLI.Filename.pos_suffix(39, 8)
      ":39:8"

      iex> Credo.CLI.Filename.pos_suffix(39, nil)
      ":39"

  These are used in this way: lib/credo/sources.ex:39:8
  """
  def pos_suffix(nil, nil), do: ""
  def pos_suffix(line_no, nil), do: ":#{line_no}"
  def pos_suffix(line_no, column), do: ":#{line_no}:#{column}"

  @doc """
  Removes the pos_suffix for a filename.

      iex> Credo.CLI.Filename.remove_line_no_and_column("lib/credo/sources.ex:39:8")
      "lib/credo/sources.ex"
  """
  def remove_line_no_and_column(filename) do
    filename
    |> String.split(":")
    |> List.first
  end


  @doc """
  Adds a pos_suffix to a filename.

      iex> Credo.CLI.Filename.with("test/file.exs", %{:line_no => 1, :column => 2})
      "test/file.exs:1:2"
  """
  def with(filename, params) do
    filename <> pos_suffix(params[:line_no], params[:column])
  end

end
