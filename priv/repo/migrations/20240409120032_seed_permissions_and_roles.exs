defmodule TuneUp.Repo.Migrations.SeedPermissionsAndRoles do
  use Ecto.Migration
  import Ecto.Query
  alias TuneUp.Accounts.Permission
  alias TuneUp.Accounts.Role
  alias Ecto.Multi

  def change do
    TuneUp.Repo.transaction(create_init_permissions())
    TuneUp.Repo.transaction(create_init_roles())
    TuneUp.Repo.transaction(create_init_role_permissions())
    assign_roles_to_user()
    drop table(:auth_item), mode: :cascade
    drop table(:auth_assignment), mode: :cascade
    drop table(:auth_item_child), mode: :cascade
    drop table(:auth_rule), mode: :cascade
  end

  def create_init_permissions do
    Multi.new()
    |> Multi.insert(
      "permission1",
      TuneUp.Accounts.Permission.changeset(%Permission{}, %{
        name: "changeStage",
        description: "Change the stage of an order"
      })
    )
    |> Multi.insert(
      "permission2",
      TuneUp.Accounts.Permission.changeset(%Permission{}, %{
        name: "createAuto",
        description: "Create a new automobile"
      })
    )
    |> Multi.insert(
      "permission3",
      TuneUp.Accounts.Permission.changeset(%Permission{}, %{
        name: "createCustomer",
        description: "Create a new customer"
      })
    )
    |> Multi.insert(
      "permission4",
      TuneUp.Accounts.Permission.changeset(%Permission{}, %{
        name: "createLabor",
        description: "Create a new labor instance"
      })
    )
    |> Multi.insert(
      "permission5",
      TuneUp.Accounts.Permission.changeset(%Permission{}, %{
        name: "createNote",
        description: "Create a new note"
      })
    )
    |> Multi.insert(
      "permission6",
      TuneUp.Accounts.Permission.changeset(%Permission{}, %{
        name: "createOrder",
        description: "Create a new order"
      })
    )
    |> Multi.insert(
      "permission7",
      TuneUp.Accounts.Permission.changeset(%Permission{}, %{
        name: "createPart",
        description: "Create a new part"
      })
    )
    |> Multi.insert(
      "permission8",
      TuneUp.Accounts.Permission.changeset(%Permission{}, %{
        name: "createUser",
        description: "Create a new user"
      })
    )
    |> Multi.insert(
      "permission9",
      TuneUp.Accounts.Permission.changeset(%Permission{}, %{
        name: "deleteAuto",
        description: "Delete an automobile"
      })
    )
    |> Multi.insert(
      "permission10",
      TuneUp.Accounts.Permission.changeset(%Permission{}, %{
        name: "deleteCustomer",
        description: "Delete a customer"
      })
    )
    |> Multi.insert(
      "permission11",
      TuneUp.Accounts.Permission.changeset(%Permission{}, %{
        name: "deleteLabor",
        description: "Delete a labor instance"
      })
    )
    |> Multi.insert(
      "permission12",
      TuneUp.Accounts.Permission.changeset(%Permission{}, %{
        name: "deleteNote",
        description: "Delete a note"
      })
    )
    |> Multi.insert(
      "permission13",
      TuneUp.Accounts.Permission.changeset(%Permission{}, %{
        name: "deleteOrder",
        description: "Delete an order"
      })
    )
    |> Multi.insert(
      "permission14",
      TuneUp.Accounts.Permission.changeset(%Permission{}, %{
        name: "deleteOwnNote",
        description: "Delete a note that belongs to the user"
      })
    )
    |> Multi.insert(
      "permission15",
      TuneUp.Accounts.Permission.changeset(%Permission{}, %{
        name: "deletePart",
        description: "Delete a part"
      })
    )
    |> Multi.insert(
      "permission16",
      TuneUp.Accounts.Permission.changeset(%Permission{}, %{
        name: "editAuto",
        description: "Edit an automobile"
      })
    )
    |> Multi.insert(
      "permission17",
      TuneUp.Accounts.Permission.changeset(%Permission{}, %{
        name: "editCustomer",
        description: "Edit a customer"
      })
    )
    |> Multi.insert(
      "permission18",
      TuneUp.Accounts.Permission.changeset(%Permission{}, %{
        name: "editLabor",
        description: "Edit a labor instance"
      })
    )
    |> Multi.insert(
      "permission19",
      TuneUp.Accounts.Permission.changeset(%Permission{}, %{
        name: "editOrder",
        description: "Edit an order"
      })
    )
    |> Multi.insert(
      "permission20",
      TuneUp.Accounts.Permission.changeset(%Permission{}, %{
        name: "editOwnNote",
        description: "Edit a note that belongs to the user"
      })
    )
    |> Multi.insert(
      "permission21",
      TuneUp.Accounts.Permission.changeset(%Permission{}, %{
        name: "editOwnUser",
        description: "Edit the user's own information"
      })
    )
    |> Multi.insert(
      "permission22",
      TuneUp.Accounts.Permission.changeset(%Permission{}, %{
        name: "editUser",
        description: "Edit any user"
      })
    )
    |> Multi.insert(
      "permission23",
      TuneUp.Accounts.Permission.changeset(%Permission{}, %{
        name: "editPart",
        description: "Edit a part"
      })
    )
    |> Multi.insert(
      "permission24",
      TuneUp.Accounts.Permission.changeset(%Permission{}, %{
        name: "admin",
        description: "Have full access over the system",
        hidden: true
      })
    )
    |> Multi.insert(
      "permission25",
      TuneUp.Accounts.Permission.changeset(%Permission{}, %{
        name: "toggleUserStatus",
        description: "Enable and disable a user in the system"
      })
    )
    |> Multi.insert(
      "permission26",
      TuneUp.Accounts.Permission.changeset(%Permission{}, %{
        name: "editUserRoles",
        description: "Add or remove roles from a user"
      })
    )
    |> Multi.insert(
      "permission27",
      TuneUp.Accounts.Permission.changeset(%Permission{}, %{
        name: "viewOrder",
        description: "Can view orders"
      })
    )
  end

  def create_init_roles do
    Multi.new()
    |> Multi.insert("role1", TuneUp.Accounts.Role.changeset(%Role{}, %{name: "admin"}))
    |> Multi.insert("role2", TuneUp.Accounts.Role.changeset(%Role{}, %{name: "shopManager"}))
    |> Multi.insert("role3", TuneUp.Accounts.Role.changeset(%Role{}, %{name: "employee"}))
  end

  def create_init_role_permissions do
    permissions = TuneUp.Repo.all(TuneUp.Accounts.Permission)
    roles = TuneUp.Repo.all(TuneUp.Accounts.Role)

    Multi.new()
    |> Multi.update(
      "assigment1",
      TuneUp.Accounts.Role.permissions_changeset(find_role_by_name_preload("admin", roles), %{
        permissions: find_permissions_by_name_preload(["admin"], permissions)
      })
    )
    |> Multi.update(
      "assigment2",
      TuneUp.Accounts.Role.permissions_changeset(
        find_role_by_name_preload("shopManager", roles),
        %{
          permissions:
            find_permissions_by_name_preload(
              [
                "changeStage",
                "createAuto",
                "createCustomer",
                "createLabor",
                "createNote",
                "createOrder",
                "createPart",
                "deleteOwnNote",
                "editAuto",
                "editCustomer",
                "editLabor",
                "editOrder",
                "editOwnNote",
                "editOwnUser",
                "editPart",
                "viewOrder"
              ],
              permissions
            )
        }
      )
    )
    |> Multi.update(
      "assigment3",
      TuneUp.Accounts.Role.permissions_changeset(find_role_by_name_preload("employee", roles), %{
        permissions:
          find_permissions_by_name_preload(
            [
              "changeStage",
              "createNote",
              "deleteOwnNote",
              "editOwnNote",
              "editOwnUser",
              "viewOrder"
            ],
            permissions
          )
      })
    )
  end

  defp find_role_by_name_preload(name, list) do
    Enum.find(list, fn item -> item.name == name end) |> TuneUp.Repo.preload(:permissions)
  end

  defp find_permissions_by_name_preload(name_list, list) do
    Enum.filter(list, fn item -> item.name in name_list end) |> TuneUp.Repo.preload(:roles)
  end

  def assign_roles_to_user() do
    query = from(aa in "auth_assignment", select: {aa.item_name, aa.user_id})
    results = TuneUp.Repo.all(query)
    Enum.each(results, fn result -> addRoleToUser(result) end)
  end

  defp addRoleToUser(result) do
    {role_name, user_id} = result
    # IO.puts( "Adding role #{role_name} to user #{Integer.parse(user_id)}")
    role = TuneUp.Repo.get_by(TuneUp.Accounts.Role, name: role_name)
    user = TuneUp.Repo.get(TuneUp.Accounts.User, user_id)

    TuneUp.Accounts.User.roles_changeset(user |> TuneUp.Repo.preload(:roles), %{roles: [role]})
    |> TuneUp.Repo.update()
  end
end
