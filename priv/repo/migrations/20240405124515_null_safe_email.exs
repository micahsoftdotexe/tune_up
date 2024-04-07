defmodule TuneUp.Repo.Migrations.NullSafeEmail do
  use Ecto.Migration
  import Ecto.Query

  def change do
    # add emails to users
    query = from u in "users", where: is_nil(u.email), select: {u.id, u.username}
    if Enum.count(TuneUp.Repo.all(query)) > 0 do
      results = TuneUp.Repo.all(query)
      Enum.each(results, fn user -> add_email(user) end)
    end
    # add not null to emails
    execute "ALTER TABLE users ALTER COLUMN email SET NOT NULL"
  end

  def add_email(user) do
    {id, username} = user
    email = IO.gets("Enter email for #{username}: ")
    execute "UPDATE users SET email = '#{String.trim(email)}' WHERE id = #{id}"
  end
end
