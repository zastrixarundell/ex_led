defmodule ExLed.Controller do

  def get_controllers do
    GenServer.call(:controller, :info)
    |> Map.get(:channels)
    |> Enum.map(fn {_pid, {_module, _leave, [id, name]}} -> {id, name} end)
  end

end
