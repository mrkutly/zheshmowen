defmodule Atomizer do
  # @doc false
  def atomize(string) when is_binary(string), do: String.to_atom(string)

  def atomize(atom) when is_atom(atom), do: atom

  def atomize(list) when is_list(list), do: Enum.map(list, &atomize/1)

  def atomize(map) when is_map(map) do
    Enum.reduce(map, %{}, fn
      {key, value}, acc when is_map(value) or is_list(value) ->
        Map.put(acc, atomize(key), atomize(value))

      {key, value}, acc ->
        Map.put(acc, atomize(key), value)
    end)
  end

  def atomize(something_else), do: something_else
end
