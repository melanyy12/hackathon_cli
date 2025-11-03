defmodule HackathonCli.Services.GestionEquipos do
  alias HackathonCli.Domain.{Equipo, Usuario}
  alias HackathonCli.Adapters.RepositorioArchivo

  def crear_equipo(nombre, tema) do
    id = :crypto.strong_rand_bytes(8) |> Base.url_encode64(padding: false)
    equipo = Equipo.nuevo(id, nombre, tema)
    RepositorioArchivo.guardar_equipo(%{id: equipo.id, nombre: equipo.nombre, tema: equipo.tema})
    {:ok, equipo}
  end

  def listar_equipos do
    RepositorioArchivo.listar_equipos()
  end

  def unir_usuario_a_equipo(_equipo_id, %Usuario{} = usuario) do
    RepositorioArchivo.guardar_usuario(%{id: usuario.id, nombre: usuario.nombre, correo: usuario.correo, rol: usuario.rol})
    {:ok, usuario}
  end
end
