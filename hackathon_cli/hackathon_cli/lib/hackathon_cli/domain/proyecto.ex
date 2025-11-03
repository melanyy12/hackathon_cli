defmodule HackathonCli.Domain.Proyecto do
  defstruct [:id, :equipo_id, :titulo, :descripcion, :categoria, :estado, :avances, :feedback]

  def nuevo(id, equipo_id, titulo, descripcion, categoria) do
    %__MODULE__{
      id: id,
      equipo_id: equipo_id,
      titulo: titulo,
      descripcion: descripcion,
      categoria: categoria,
      estado: "activo",
      avances: [],
      feedback: []
    }
  end
end
