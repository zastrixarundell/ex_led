defmodule ExLedWeb.ControllerChannel do
  use Phoenix.Channel

  require Logger

  def join("controller:" <> controller_name, _payload, socket) do
    Logger.info "Controller '#{controller_name}' has joined!"

    {:ok, socket}
  end

  def send_ir_to_controller(controller_id, code) do
    ExLedWeb.Endpoint.broadcast!("controller:#{controller_id}", "ir_write", %{code: code})
  end
end
