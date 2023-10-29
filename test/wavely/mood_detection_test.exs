defmodule Wavely.MoodDetectionTest do
  use Wavely.DataCase

  alias Wavely.MoodDetection

  describe "moods" do
    alias Wavely.MoodDetection.Mood

    import Wavely.MoodDetectionFixtures

    @invalid_attrs %{}

    test "list_moods/0 returns all moods" do
      mood = mood_fixture()
      assert MoodDetection.list_moods() == [mood]
    end

    test "get_mood!/1 returns the mood with given id" do
      mood = mood_fixture()
      assert MoodDetection.get_mood!(mood.id) == mood
    end

    test "create_mood/1 with valid data creates a mood" do
      valid_attrs = %{}

      assert {:ok, %Mood{} = mood} = MoodDetection.create_mood(valid_attrs)
    end

    test "create_mood/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = MoodDetection.create_mood(@invalid_attrs)
    end

    test "update_mood/2 with valid data updates the mood" do
      mood = mood_fixture()
      update_attrs = %{}

      assert {:ok, %Mood{} = mood} = MoodDetection.update_mood(mood, update_attrs)
    end

    test "update_mood/2 with invalid data returns error changeset" do
      mood = mood_fixture()
      assert {:error, %Ecto.Changeset{}} = MoodDetection.update_mood(mood, @invalid_attrs)
      assert mood == MoodDetection.get_mood!(mood.id)
    end

    test "delete_mood/1 deletes the mood" do
      mood = mood_fixture()
      assert {:ok, %Mood{}} = MoodDetection.delete_mood(mood)
      assert_raise Ecto.NoResultsError, fn -> MoodDetection.get_mood!(mood.id) end
    end

    test "change_mood/1 returns a mood changeset" do
      mood = mood_fixture()
      assert %Ecto.Changeset{} = MoodDetection.change_mood(mood)
    end
  end
end
