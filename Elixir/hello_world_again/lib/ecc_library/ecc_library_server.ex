defmodule EccLibraryServer do
  def start(module, initial_state) do
    spawn(fn -> init(module, initial_state) end)
  end

  def start_link(module, initial_state) do
    spawn_link(fn ->
      IO.puts("Spawned!")
      init(module, initial_state)
    end)
  end

  def init(module, initial_state) do
    loop(module, module.init(initial_state))
  end

  def call(pid, msg) do
    ref = Process.monitor(pid)
    send(pid, {:sync, self(), ref, msg})
    receive do
      { ^ref, reply } ->
        Process.demonitor(ref, [:flush])
        reply
      { :DOWN, ^ref, _, ^pid, reason } ->
        :erlang.error(reason)
    after 5000 ->
      :erlang.error(:timeout)
    end
  end

  def cast(pid, msg) do
    send(pid, {:async, msg})
    :ok
  end

  def reply({pid, ref}, reply) do
    send(pid, {ref, reply})
  end

  def loop(module, state) do
    receive do
      {:async, msg} ->
        loop(module, module.handle_cast(msg, state))
      {:sync, pid, ref, msg} ->
        loop(module, module.handle_call(msg, {pid, ref}, state))
    end
  end
end
