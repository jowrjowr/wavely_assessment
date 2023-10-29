defmodule Wavely.MoodDetectionFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Wavely.MoodDetection` context.
  """

  @doc """
  Generate a mood.
  """
  def mood_fixture(attrs \\ %{}) do
    {:ok, mood} =
      attrs
      |> Enum.into(%{

      })
      |> Wavely.MoodDetection.create_mood()

    mood
  end
end
