defmodule HackathonCli.Domain.Equipo do
  defstruct [:id, :nombre, :tema, :miembros]

  def nuevo(id, nombre, tema) do
    %__MODULE__{id: id, nombre: nombre, tema: tema, miembros: []}
  end

  def agregar_miembro(equipo, usuario) do
    %{equipo | miembros: equipo.miembros ++ [usuario]}
  end
end
