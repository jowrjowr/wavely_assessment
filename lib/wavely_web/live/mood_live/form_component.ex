defmodule WavelyWeb.MoodLive.FormComponent do
  use WavelyWeb, :live_component

  alias Wavely.MoodDetection

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage mood records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="mood-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >

        <:actions>
          <.button phx-disable-with="Saving...">Save Mood</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{mood: mood} = assigns, socket) do
    changeset = MoodDetection.change_mood(mood)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"mood" => mood_params}, socket) do
    changeset =
      socket.assigns.mood
      |> MoodDetection.change_mood(mood_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"mood" => mood_params}, socket) do
    save_mood(socket, socket.assigns.action, mood_params)
  end

  defp save_mood(socket, :edit, mood_params) do
    case MoodDetection.update_mood(socket.assigns.mood, mood_params) do
      {:ok, mood} ->
        notify_parent({:saved, mood})

        {:noreply,
         socket
         |> put_flash(:info, "Mood updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_mood(socket, :new, mood_params) do
    case MoodDetection.create_mood(mood_params) do
      {:ok, mood} ->
        notify_parent({:saved, mood})

        {:noreply,
         socket
         |> put_flash(:info, "Mood created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
