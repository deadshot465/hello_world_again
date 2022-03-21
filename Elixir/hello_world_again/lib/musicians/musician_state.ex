defmodule MusicianState do
  defstruct [
    :name, :role, :skill
  ]

  @type t :: %__MODULE__{
    name: String.t(),
    role: String.t(),
    skill: atom()
  }

  def new(role, skill) do
    %__MODULE__{
      name: pick_name(),
      role: role,
      skill: skill
    }
  end

  def name(%MusicianState{name: name}), do: name

  def role(%MusicianState{role: role}), do: role

  def pick_name() do
    first_name = Enum.random(first_names())
    last_name = Enum.random(last_names())
    "#{first_name} #{last_name}"
  end

  def first_names do
    ["Valerie", "Arnold", "Carlos", "Dorothy", "Keesha",
      "Phoebe", "Ralphie", "Tim", "Wanda", "Janet",
      "Leo", "Yuhei", "Carson"]
  end

  def last_names do
    ["Frizzle", "Perlstein", "Ramon", "Ann", "Franklin",
      "Terese", "Tennelli", "Jamal", "Li", "Perlstein",
      "Fujioka", "Ito", "Hage"]
  end
end
