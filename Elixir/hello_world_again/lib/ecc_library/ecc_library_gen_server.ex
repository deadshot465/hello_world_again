defmodule HalLibraryGenServer do
  use GenServer

  def start_link() do
    GenServer.start_link(__MODULE__, [])
  end

  def init([]) do
    {:ok, []}
  end

  def borrow_book(pid, name) do
    GenServer.call(pid, {:borrow, name})
  end

  def close_library(pid) do
    GenServer.call(pid, :terminate)
  end

  def return_book(pid, name) do
    GenServer.cast(pid, {:return, name})
  end

  def handle_call({:borrow, name}, _from, library) do
    if Enum.empty?(library) do
      {:reply, "HAL " <> name, library}
    else
      {:reply, hd(library), tl(library)}
    end
  end

  def handle_call(:terminate, _from, library) do
    {:stop, :normal, :ok, library}
  end

  def handle_cast({:return, name}, library) do
    {:noreply, [name | library]}
  end

  def handle_info(msg, library) do
    IO.puts("Unexpected message: #{msg}")
    {:noreply, library}
  end

  def terminate(:normal, library) do
    for s <- library, do: IO.puts("#{s} was burnt.")
    :ok
  end

  def code_change(_old_vsn, state, _extra) do
    {:ok, state}
  end
end
