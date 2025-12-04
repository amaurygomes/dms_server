defmodule DmsIdentity do

  alias DmsRepo
  alias DmsIdentity.Tenant
  alias DmsIdentity.User
  alias Argon2
  import Ecto.Multi


  def register_tenant_and_user(tenant_attrs, user_attrs) do
    Ecto.Multi.new()
    # 1. Cria o Tenant (usando struct! para forçar a criação da struct)
    |> Ecto.Multi.insert(:tenant, Tenant.changeset(struct!(Tenant), tenant_attrs))

    |> Ecto.Multi.run(:user, fn repo, %{tenant: new_tenant} ->
        # 2. Adiciona o FK e cria o Changeset do User
        user_with_tenant = Map.put(user_attrs, :tenant_id, new_tenant.id)

        # Cria o changeset do admin
        User.registration_changeset(struct!(User, role: "admin"), user_with_tenant)
        |> repo.insert() # 3. Insere o User usando o repo fornecido pelo Multi
    end)

    |> DmsRepo.transaction() # 4. Executa a transação atômica
  end


  def authenticate_user(email, password) do
    case DmsRepo.get_by(User, email: email) do
      nil ->
        {:error, :not_found}
      user ->
        if Argon2.verify_pass(password, user.hashed_password) do
          if user.status == "active" do
            {:ok, user}
          else
            {:error, :inactive}
          end
        else
          {:error, :unauthorized}
        end
    end
  end
end
