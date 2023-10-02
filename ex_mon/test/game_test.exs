defmodule ExMon.GameTest do
  use ExUnit.Case

  alias ExMon.{Game, Player}

  describe "start/2" do
    test "starts the game state" do
      player = Player.build("Felippe", :chute, :soco, :cura)
      computer = Player.build("Felippe", :chute, :soco, :cura)

      assert {:ok, _pid} = Game.start(player, computer)
    end
  end

  describe "info/0" do
    test "returns the current game state" do
      player = Player.build("Felippe", :chute, :soco, :cura)
      computer = Player.build("Felippe", :chute, :soco, :cura)

      {:ok, _pid} = Game.start(player, computer)

      expected_response = %{
        computer: %Player{
          life: 100,
          moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute},
          name: "Felippe"
        },
        player: %Player{
          life: 100, moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute},
          name: "Felippe"
        },
        status: :started,
        turn: :player
      }

      assert expected_response == Game.info()
    end
  end

  describe "update/1" do
    test "returns the game state updated" do
      player = Player.build("Felippe", :chute, :soco, :cura)
      computer = Player.build("Felippe", :chute, :soco, :cura)

      {:ok, _pid} = Game.start(player, computer)

      expected_response = %{
        computer: %Player{
          life: 100,
          moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute},
          name: "Felippe"
        },
        player: %Player{
          life: 100, moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute},
          name: "Felippe"
        },
        status: :started,
        turn: :player
      }

      assert expected_response == Game.info()

      new_state = %{
        computer: %Player{
          life: 80,
          moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute},
          name: "Felippe"
        },
        player: %Player{
          life: 50, moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute},
          name: "Felippe"
        },
        status: :started,
        turn: :player
      }

      Game.update(new_state)

      expected_response = %{
        computer: %Player{
          life: 80,
          moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute},
          name: "Felippe"
        },
        player: %Player{
          life: 50, moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute},
          name: "Felippe"
        },
        status: :continue,
        turn: :computer
      }

      assert expected_response == Game.info()
    end
  end

  describe "fetch_player/1" do
    test "returns the actual player" do
      player = Player.build("Felippe", :chute, :soco, :cura)
      computer = Player.build("Felippe", :chute, :soco, :cura)

      Game.start(player, computer)

      assert Game.fetch_player(computer) == nil
      assert Game.fetch_player(player) == nil
    end
  end
end
