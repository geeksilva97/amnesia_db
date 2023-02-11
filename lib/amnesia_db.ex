defmodule AmnesiaDb do
  @moduledoc """
  Documentation for `AmnesiaDb`.
  """

  # TODO: Create a new segment when the max file size is reached
  # TODO: Have a hash index struture for reading file

  @segment_file_path "./segments/segment.bin"
  @segment_max_file_size 256 # in bytes

  def insert(key, value) do
    size = get_segment_size!()

    # The string takes less space than a tuple or a map with a key value
    term_to_save = :erlang.term_to_binary("#{key}:#{value}")

    {:ok, file_descriptor} = File.open(@segment_file_path, [:append, :binary])

    IO.binwrite(file_descriptor, term_to_save)

    File.close(file_descriptor)

    IO.puts "To find this information, open the file at #{size} and read #{byte_size(term_to_save)} bytes"
  end

  def get(key) do
    {start_byte, amount_bytes} = fake_hash(key)

    {:ok, file_descriptor} = File.open(@segment_file_path, [:read, :binary])

    {:ok, content} = :file.pread(file_descriptor, start_byte, amount_bytes)

    :erlang.binary_to_term(content)
  end

  defp fake_hash(key) do
    %{
      email: {0, 38},
      name: {68, 14},
      email2: {38, 30}
    } |> Map.get(key)
  end

  defp get_segment_size! do
    case File.stat(@segment_file_path) do
      {:ok, %{size: size}} ->
        if size >= @segment_max_file_size do
            throw(:segmen_max_file_size) 
        end

        size

      _ -> 0
    end
  end
end
