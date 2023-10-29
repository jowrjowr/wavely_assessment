defmodule WavelyWeb.MoodLive.Index do
  use WavelyWeb, :live_view

  alias Wavely.MoodDetection
  alias Wavely.MoodDetection.Mood

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :moods, MoodDetection.list_moods())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Mood")
    |> assign(:mood, MoodDetection.get_mood!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Mood")
    |> assign(:mood, %Mood{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Moods")
    |> assign(:mood, nil)
  end

  @impl true
  def handle_info({WavelyWeb.MoodLive.FormComponent, {:saved, mood}}, socket) do
    {:noreply, stream_insert(socket, :moods, mood)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    mood = MoodDetection.get_mood!(id)
    {:ok, _} = MoodDetection.delete_mood(mood)

    {:noreply, stream_delete(socket, :moods, mood)}
  end
end
