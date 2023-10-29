defmodule WavelyWeb.MoodLive.Show do
  use WavelyWeb, :live_view

  alias Wavely.MoodDetection

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:mood, MoodDetection.get_mood!(id))}
  end

  defp page_title(:show), do: "Show Mood"
  defp page_title(:edit), do: "Edit Mood"
end
