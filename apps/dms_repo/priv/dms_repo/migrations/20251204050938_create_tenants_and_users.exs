defmodule DmsRepo.Migrations.CreateTenantsAndUsers do
  use Ecto.Migration

  def change do
    # Tabela 1: tenants (Multi-Tenant, Faturamento e Documentação)
    create table(:tenants, primary_key: false) do
      # 1. Identificação
      add :id, :uuid, primary_key: true
      add :name, :string, null: false # Nome de exibição
      add :status, :string, default: "trial" # trial, active, suspended

      # 2. Documentação e Legalidade
      add :company_name, :string, null: false # Razão Social
      add :document_type, :string, null: false # CNPJ, CPF
      add :document_number, :string, null: false

      # 3. Contato e Endereço
      add :contact_email, :string, null: false # Email principal de contato
      add :phone, :string
      add :zip_code, :string
      add :address_line_1, :string
      add :city, :string
      add :state, :string
      add :country, :string, default: "BR"

      # 4. Assinatura
      add :plan_id, :uuid # Chave para planos futuros
      add :max_users, :integer, default: 5 # Limite de usuários permitidos

      timestamps()
    end

    # Índices de unicidade
    create unique_index(:tenants, [:name])
    create unique_index(:tenants, [:document_number])


    # Tabela 2: users (Autenticação de Admin/Operador)
    create table(:users, primary_key: false) do
      # 1. Identificação e Autenticação
      add :id, :uuid, primary_key: true
      add :email, :string, null: false
      add :hashed_password, :string, null: false
      add :first_name, :string
      add :last_name, :string
      add :phone, :string
      add :status, :string, default: "active"

      # 2. Autorização e Tenant
      add :role, :string, default: "operator" # admin, operator

      # 3. Recuperação de Senha (Token)
      add :reset_password_token, :string
      add :token_sent_at, :naive_datetime

      # Chave estrangeira para tenants
      add :tenant_id, references(:tenants, type: :uuid, on_delete: :delete_all), null: false

      timestamps()
    end



    # Índices para busca
    create unique_index(:users, [:email])
    create index(:users, [:tenant_id])
  end
end
