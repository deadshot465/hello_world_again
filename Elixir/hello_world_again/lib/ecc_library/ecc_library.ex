defmodule EccLibrary do
  def start_link() do
    EccLibraryServer.start_link(__MODULE__, [])
  end

  def init(_) do
    []
  end

  def borrow_book(pid, name) do
    EccLibraryServer.call(pid, {:borrow, name})
  end

  def return_book(pid, name) do
    EccLibraryServer.cast(pid, {:return, name})
  end

  def close_library(pid), do: EccLibraryServer.call(pid, :terminate)

  def handle_call({:borrow, name}, from, library) do
    if Enum.empty?(library) do
      EccLibraryServer.reply(from, "ECC " <> name)
      library
    else
      EccLibraryServer.reply(from, hd(library))
      tl(library)
    end
  end

  def handle_call(:terminate, from, library) do
    EccLibraryServer.reply(from, :ok)
    terminate(library)
  end

  def handle_cast({:return, name}, library) do
    [name | library]
  end

  def terminate(library) do
    for s <- library, do: IO.puts("#{s} was burnt.")
    exit(:normal)
  end
end
