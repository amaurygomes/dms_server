defmodule DmsIdentity.Tenant do
  use Ecto.Schema
  import Ecto.Changeset

  alias DmsIdentity.User # Necessário para a associação has_many

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "tenants" do
    # Identificação e Gestão
    field :name, :string
    field :status, :string, default: "trial"

    # Documentação e Legalidade
    field :company_name, :string
    field :document_type, :string
    field :document_number, :string

    # Contato e Endereço
    field :contact_email, :string
    field :phone, :string
    field :zip_code, :string
    field :address_line_1, :string
    field :city, :string
    field :state, :string
    field :country, :string, default: "BR"

    # Faturamento e Limites
    field :plan_id, :binary_id
    field :max_users, :integer, default: 5

    # Associação Multi-Tenant
    has_many :users, User # <-- Usa o Alias (Atom)

    timestamps()
  end

  def changeset(tenant, attrs) do
    tenant
    # CAST: Lista todos os campos que virão no mapa 'attrs'
    |> cast(attrs, [
      :name, :status, :company_name, :document_number,
      :document_type, :contact_email, :max_users,
      :phone, :zip_code, :address_line_1, :city, :state, :country,
      :plan_id
    ])
    # validate_required: Lista todos os campos que são NULL:FALSE na migração
    |> validate_required([
      :name, :company_name, :document_number, :document_type, :contact_email,
      :zip_code, :address_line_1, :city, :state, :country
    ])
    |> unique_constraint(:name)
    |> unique_constraint(:document_number)
    |> validate_inclusion(:status, ["trial", "active", "suspended"])
    |> validate_number(:max_users, greater_than: 0)
  end
end
