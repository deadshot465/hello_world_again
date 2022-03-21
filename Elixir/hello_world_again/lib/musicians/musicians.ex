defmodule Musicians do
  use GenServer

  @spec delay :: 750
  def delay, do: 750

  def start_link(role, skill) do
    GenServer.start_link(__MODULE__, [role, skill])
  end

  @spec init([...]) :: {:ok, MusicianState.t(), non_neg_integer()}
  def init([role, skill]) do
    Process.flag(:trap_exit, :true)
    time_to_play = Enum.random(0..3000)
    musician = MusicianState.new(role, skill)
    IO.puts("Musician #{MusicianState.name(musician)}, playing the #{MusicianState.role(musician)} entered the room.")
    {:ok, musician, time_to_play}
  end

  def handle_call(:stop, _from, state) do
    {:stop, :normal, :ok, state}
  end

  def handle_call(_, _, state) do
    {:noreply, state, delay()}
  end

  def handle_cast(_, state) do
    {:noreply, state, delay()}
  end

  def handle_info(:timeout, state = %MusicianState{name: name, skill: :good}) do
    IO.puts("#{name} produced sound!")
    {:noreply, state, delay()}
  end

  def handle_info(:timeout, state = %MusicianState{name: name, skill: :bad}) do
    case Enum.random(0..4) do
      1 ->
        IO.puts("#{name} played a false note. Uh oh.")
        {:stop, :bad_note, state}
      _ ->
        IO.puts("#{name} produced sound!")
        {:noreply, state, delay()}
    end
  end

  def handle_info(_, state) do
    {:noreply, state, delay()}
  end

  def code_change(_, state, _) do
    {:ok, state}
  end

  def terminate(:normal, %MusicianState{name: name, role: role}) do
    IO.puts("#{name} left the room (#{role}).")
  end

  def terminate(:bad_note, %MusicianState{name: name, role: role}) do
    IO.puts("#{name} sucks! kicked that member out of the band! (#{role})")
  end

  def terminate(:shutdown, %MusicianState{name: name}) do
    IO.puts("The manager is mad and fired the whole band! #{name} just got back to playing in the subway.")
  end

  def terminate(_, %MusicianState{name: name, role: role}) do
    IO.puts("#{name} has been kicked out (#{role}).")
  end
end
