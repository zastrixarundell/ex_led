defmodule ExLedWeb.ControllerChannel do
  use Phoenix.Channel
  alias ExLed.Controllers.Watcher

  def join("controller:" <> controller_name, payload, socket) do
    socket = socket |> assign(:name, payload["name"])
    :ok = Watcher.monitor(:controller, self(), {__MODULE__, :leave, [controller_name, payload["name"]]})
    {:ok, socket}
  end

  def send_ir_to_controller(controller_id, code) do
    ExLedWeb.Endpoint.broadcast!("controller:#{controller_id}", "ir_write", %{code: code})
  end

  require Logger

  def leave(room_id, user_id) do
    Logger.info("Left #{room_id} #{user_id}")
  end
end
