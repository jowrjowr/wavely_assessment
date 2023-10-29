defmodule Wavely.MoodDetection.Mood do
  use Ecto.Schema
  import Ecto.Changeset

  schema "moods" do


    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(mood, attrs) do
    mood
    |> cast(attrs, [])
    |> validate_required([])
  end
end
