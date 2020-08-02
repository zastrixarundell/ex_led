defmodule ExLedWeb.ControllerController do
  use ExLedWeb, :controller

  alias ExLed.Controllers
  alias ExLed.Controllers.Controller
  alias ExLedWeb.ControllerChannel

  def index(conn, _params) do
    controller = Controllers.get_controllers()
    render(conn, "index.html", controller: controller)
  end

  def show(conn, %{"id" => id}) do
    controller = Controllers.get_controller!(id)
    render(conn, "show.html", controller: controller)
  end

  def update(conn, %{"id" => id, "code" => code}) do
    ControllerChannel.send_ir_to_controller(id, code)
    redirect(conn, to: Routes.controller_path(conn, :index))
  end
end
