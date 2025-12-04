defmodule DmsIdentity.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias Argon2
  alias DmsIdentity.Tenant

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "users" do
    # 1. Identificação e Autenticação (Campos corrigidos)
    field :email, :string
    field :hashed_password, :string
    field :first_name, :string
    field :last_name, :string # <-- CAMPO ADICIONADO
    field :phone, :string    # <-- CAMPO ADICIONADO
    field :status, :string, default: "active"

    # Campo virtual para senha de entrada
    field :password, :string, virtual: true, redact: true

    # 2. Autorização e Tenant
    field :role, :string, default: "operator"
    belongs_to :tenant, Tenant # Relação corrigida (Atom)

    # 3. Recuperação de Senha
    field :reset_password_token, :string
    field :token_sent_at, :naive_datetime

    timestamps()
  end

  # Changeset de Registro/Criação
  def registration_changeset(user, attrs) do
    user
    |> cast(attrs, [
        :email, :role, :tenant_id, :first_name, :last_name, :phone, :password
      ])
    |> validate_required([:email, :tenant_id, :first_name, :password])
    |> validate_length(:password, min: 8)
    |> put_password_hash()
    |> unique_constraint(:email)
  end

  # Helper para Hashing
  defp put_password_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: password}} ->
        changeset
        |> put_change(:hashed_password, Argon2.hash_pwd_salt(password))
        |> delete_change(:password)
      _ ->
        changeset
    end
  end
end
