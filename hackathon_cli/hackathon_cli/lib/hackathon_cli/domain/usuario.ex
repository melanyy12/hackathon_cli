defmodule HackathonCli.Domain.Usuario do
  defstruct [:id, :nombre, :correo, :rol]

  def nuevo(id, nombre, correo, rol \\ "participante") do
    %__MODULE__{id: id, nombre: nombre, correo: correo, rol: rol}
  end
end
