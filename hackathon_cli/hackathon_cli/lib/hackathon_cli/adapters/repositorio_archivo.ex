defmodule HackathonCli.Adapters.RepositorioArchivo do
  @moduledoc """
  Repositorio simple basado en archivos CSV dentro de /data.
  Funciones mínimas usadas por los servicios: guardar_usuario, guardar_equipo,
  guardar_proyecto, listar_equipos.
  """

  @usuarios "data/usuarios.csv"
  @equipos "data/equipos.csv"
  @proyectos "data/proyectos.csv"

  # Crea la carpeta data si no existe y agrega una línea al final del archivo
  defp guardar_linea(path, linea) do
    File.mkdir_p!("data")
    File.write!(path, linea <> "\n", [:append])
  end

  # Guarda un usuario (map o struct con keys id, nombre, correo, rol)
  def guardar_usuario(%{id: id, nombre: n, correo: c, rol: r}) do
    guardar_linea(@usuarios, Enum.join([id, n, c, r], ","))
  end

  # Guarda un equipo (map con id, nombre, tema)
  def guardar_equipo(%{id: id, nombre: nombre, tema: tema}) do
    guardar_linea(@equipos, Enum.join([id, nombre, tema], ","))
  end

  # Guarda un proyecto (map con id, equipo_id, titulo, descripcion, categoria)
  def guardar_proyecto(%{id: id, equipo_id: equipo_id, titulo: t, descripcion: d, categoria: c}) do
    guardar_linea(@proyectos, Enum.join([id, equipo_id, t, d, c], ","))
  end

  # Lectura simple: devuelve lista de filas (cada fila es lista de campos)
  def listar_equipos do
    case File.read(@equipos) do
      {:ok, cont} ->
        cont
        |> String.split("\n", trim: true)
        |> Enum.map(fn line ->
          # Evita líneas vacías y mantiene coherencia
          case String.trim(line) do
            "" -> nil
            l -> String.split(l, ",")
          end
        end)
        |> Enum.filter(& &1) # elimina nils

      {:error, _} ->
        []
    end
  end
end

