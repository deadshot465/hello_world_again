defmodule Golem do
  defstruct [
    :hp,
    :defense,
    :attack
  ]

  @type hp :: integer()
  @type defense :: integer()
  @type attack :: integer()

  @type t :: %__MODULE__{
    hp: hp,
    defense: defense,
    attack: attack
  }

  @spec new(integer(), integer(), integer()) :: Golem.t()
  def new(hp \\ 300, defense \\ 80, attack \\ 50) do
    %__MODULE__{
      hp: hp,
      defense: defense,
      attack: attack
    }
  end
end
