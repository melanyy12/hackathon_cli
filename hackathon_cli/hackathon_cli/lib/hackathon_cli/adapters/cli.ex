defmodule HackathonCli.Adapters.CLI do
  alias HackathonCli.Services.GestionEquipos
  alias HackathonCli.Domain.Usuario
  alias HackathonCli.Adapters.ChatServer

  def run(["/help"]), do: imprimir_help()
  def run(["/teams"]) do
    equipos = GestionEquipos.listar_equipos()
    Enum.each(equipos, fn row -> IO.puts(Enum.join(row, " | ")) end)
  end

  def run(["/join", equipo, nombre, correo]) do
    id = :crypto.strong_rand_bytes(8) |> Base.url_encode64(padding: false)
    usuario = Usuario.nuevo(id, nombre, correo)
    {:ok, _} = GestionEquipos.unir_usuario_a_equipo(equipo, usuario)
    IO.puts("#{nombre} se unió al equipo #{equipo}")
  end

  def run(["/chat", equipo, nombre | mensaje_parts]) do
    mensaje = Enum.join(mensaje_parts, " ")
    :ok = ChatServer.enviar_msg(equipo, nombre, mensaje)
    IO.puts("Mensaje enviado al equipo #{equipo}")
  end

  def run(_), do: imprimir_help()

  defp imprimir_help do
    IO.puts("/teams → Listar equipos registrados.")
    IO.puts("/project <equipo> → Mostrar información del proyecto de un equipo.")
    IO.puts("/join <equipo> <nombre> <correo> → Unirse a un equipo.")
    IO.puts("/chat <equipo> <nombre> <mensaje> → Enviar mensaje al chat del equipo.")
    IO.puts("/help → Mostrar comandos disponibles.")
  end
end
