defmodule Player do
  defstruct [
    :hp,
    :defense
  ]

  @type t :: %__MODULE__{
    hp: integer(),
    defense: integer()
  }

  def new(hp, defense) do
    %__MODULE__{
      hp: hp,
      defense: defense
    }
  end
end
