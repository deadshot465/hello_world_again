defmodule Enemy do
  defstruct [
    :hp,
    :defense,
    :attack,
    :flee,
    :hit,
    :name,
    :level
  ]

  @type t :: %__MODULE__ {
    hp: integer(),
    defense: integer(),
    attack: integer(),
    flee: integer(),
    hit: integer(),
    name: String.t(),
    level: integer()
  }

  def new(level, name, hp, defense, attack, flee, hit) do
    %__MODULE__{
      level: level,
      name: name,
      hp: hp,
      defense: defense,
      attack: attack,
      flee: flee,
      hit: hit
    }
  end

  @spec make_enemy(any) :: {:goblin, Enemy.t()} | {:golem, Enemy.t()} | {:slime, Enemy.t()}
  def make_enemy(0) do
    level = Enum.random(1..Constants.max_golem_level)
    enemy = Enemy.new(level,
      "ゴーレム",
      level * 50 + 100,
      level * 10 + 40,
      level * 10 + 40,
      Constants.golem_flee,
      Constants.golem_hit)
    {:golem, enemy}
  end
  
  def make_enemy(1) do
    level = Enum.random(1..Constants.max_goblin_level)
    enemy = Enemy.new(level,
      "ゴブリン",
      level * 30 + 75,
      level * 5 + 20,
      level * 5 + 20,
      Constants.goblin_flee,
      Constants.goblin_hit)
    {:goblin, enemy}
  end

  def make_enemy(2) do
    level = Enum.random(1..Constants.max_slime_level)
    enemy = Enemy.new(level,
      "スライム",
      level * 10 + 50,
      level * 2 + 10,
      level * 2 + 10,
      Constants.slime_flee,
      Constants.slime_hit)
    {:slime, enemy}
  end

  def make_enemy(_), do: make_enemy(0)
end
