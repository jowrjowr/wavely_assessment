defmodule Wavely.Repo.Migrations.CreateMoods do
  use Ecto.Migration

  def change do
    create table(:moods) do

      timestamps(type: :utc_datetime)
    end
  end
end
