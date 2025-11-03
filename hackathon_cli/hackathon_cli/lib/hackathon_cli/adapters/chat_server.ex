defmodule HackathonCli.Adapters.ChatServer do
  use GenServer

  # API
  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, %{}, Keyword.put_new(opts, :name, __MODULE__))
  end

  def enviar_msg(equipo_id, usuario, msg) do
    GenServer.call(__MODULE__, {:enviar, equipo_id, %{usuario: usuario, msg: msg, ts: :os.system_time(:second)}})
  end

  def obtener_historial(equipo_id) do
    GenServer.call(__MODULE__, {:historial, equipo_id})
  end

  # Callbacks
  def init(state), do: {:ok, state}

  def handle_call({:enviar, equipo_id, mensaje}, _from, state) do
    historial = Map.get(state, equipo_id, [])
    nuevo = historial ++ [mensaje]
    {:reply, :ok, Map.put(state, equipo_id, nuevo)}
  end

  def handle_call({:historial, equipo_id}, _from, state) do
    {:reply, Map.get(state, equipo_id, []), state}
  end
end
