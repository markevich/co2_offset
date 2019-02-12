defmodule Co2Offset.Repo.Migrations.CreateTriggerForCapitalsDistances do
  use Ecto.Migration

  def up do
    execute("
      CREATE FUNCTION prevent_duplicates_and_itself_reference() RETURNS trigger AS $prevent_duplicates_and_itself_reference$
        BEGIN
          IF
            /* Check for already existed row with cross capitals */
            (
              SELECT TRUE
              FROM capitals_distances AS cd
              WHERE
                (
                  cd.capital_a = NEW.capital_a AND
                  cd.capital_b = NEW.capital_b
                )
                OR
                (
                  cd.capital_b = NEW.capital_a AND
                  cd.capital_a = NEW.capital_b
                )
            )
          THEN
            RAISE EXCEPTION 'Distance for such capitals already exists';
          END IF;

          /* Check for exclude row with the same capitals */
          IF NEW.capital_a = NEW.capital_b
          THEN
            RAISE EXCEPTION 'You cannot add distance for same capitals';
          END IF;

          RETURN NEW;
        END;
      $prevent_duplicates_and_itself_reference$ LANGUAGE plpgsql;
    ")

    execute("
      CREATE TRIGGER prevent_duplicates_and_itself_reference
        BEFORE UPDATE OR INSERT
        ON capitals_distances
        FOR EACH ROW
        EXECUTE PROCEDURE prevent_duplicates_and_itself_reference();
    ")
  end

  def down do
    execute("
      DROP FUNCTION prevent_duplicates_and_itself_reference CASCADE;
    ")
  end
end
