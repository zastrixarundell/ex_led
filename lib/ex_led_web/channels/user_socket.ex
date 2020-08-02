defmodule ExLedWeb.UserSocket do
  use Phoenix.Socket

  channel "user:*", ExLedWeb.UserChannel

  def connect(_params, socket, _connect_info) do
    {:ok, socket}
  end

  def id(_socket), do: nil
end
