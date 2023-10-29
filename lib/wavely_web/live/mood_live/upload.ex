defmodule WavelyWeb.MoodLive.Upload do
  use WavelyWeb, :live_view

  @impl Phoenix.LiveView
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:uploaded_files, [])
     |> allow_upload(:sound, accept: ~w(.wav .mp3), max_entries: 1)}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :upload, _params) do
    socket
    |> assign(:page_title, "Uploading new sound")
    |> assign(:mood, nil)
  end

  @impl true
  def handle_event("validate", _params, socket) do
    {:noreply, socket}
  end

  def handle_event("save", _params, socket) do
    uploaded_files =
      consume_uploaded_entries(socket, :sound, fn %{path: path}, entry ->
        filename = Path.join(["/tmp", Path.basename(path)])
        File.rename!(path, filename)

        sentiment = sentiment_analysis(filename)
        upload_to_cloud = upload_to_cloud(filename)
        purged = purge_local_copies(filename)

        result = %{
          client_name: entry.client_name,
          client_size: entry.client_size,
          client_type: entry.client_type,
          filename: filename,
          sentiment: sentiment,
          purged: purged,
          uploaded: upload_to_cloud
        }

        {:ok, result}
      end)

    {:noreply, update(socket, :uploaded_files, &(&1 ++ uploaded_files))}
  end

  defp sentiment_analysis(_file) do
    # placeholder for the actual function of doing the sentiment analysis
    Enum.random([:happy, :sad, :calm])
  end

  defp purge_local_copies(file) do
    # empty function.
    # we'd probably want to delete local copies of files once we are finished with them

    File.rm!(file)
    {:ok, file}
  end

  defp upload_to_cloud(file) do
    # this is an empty function.

    # with S3, the file would be easily uploaded with the ExAws.S3 module
    # https://hexdocs.pm/ex_aws_s3/ExAws.S3.html

    # with azure, this looks like a reasonable choice as well:
    # https://github.com/jakobht/azurex

    # basically this can be whatever we want it to be.

    {:ok, file}
  end
end
