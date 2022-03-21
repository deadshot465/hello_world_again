defmodule BandSupervisor do
  use Supervisor

  def start_link(type) do
    Supervisor.start_link(__MODULE__, type, [])
  end

  @spec init(
          :angry
          | :jerk
          | :lenient
          | {:one_for_all, non_neg_integer, pos_integer}
          | {:one_for_one, non_neg_integer, pos_integer}
          | {:rest_for_one, non_neg_integer, pos_integer}
        ) :: {:ok, {map, list}}
  def init(:lenient) do
    init({:one_for_one, 3, 60})
  end

  def init(:angry) do
    init({:rest_for_one, 2, 60})
  end

  def init(:jerk) do
    init({:one_for_all, 1, 60})
  end

  def init({restart_strategy, max_restart, max_time}) do
    children = [
      %{
        id: :singer,
        start: {Musicians, :start_link, [:singer, :good]},
        restart: :permanent,
        shutdown: 1000,
        type: :worker,
        modules: [Musicians]
      },
      %{
        id: :bass,
        start: {Musicians, :start_link, [:bass, :good]},
        restart: :temporary,
        shutdown: 1000,
        type: :worker,
        modules: [Musicians]
      },
      %{
        id: :drum,
        start: {Musicians, :start_link, [:drum, :bad]},
        restart: :transient,
        shutdown: 1000,
        type: :worker,
        modules: [Musicians]
      },
      %{
        id: :guitar,
        start: {Musicians, :start_link, [:guitar, :good]},
        restart: :transient,
        shutdown: 1000,
        type: :worker,
        modules: [Musicians]
      }
    ]

    Supervisor.init(children, strategy: restart_strategy, max_restarts: max_restart, max_seconds: max_time)
  end
end
