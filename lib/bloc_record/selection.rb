require 'sqlite3'

module Selection
  def find(*ids)
    if ids.length == 1
      find_one(ids.first)
    else
      rows = connection.execute <<-SQL
        SELECT #{columns.join ","} FROM #{table}
        WHERE id IN (#{ids.join(",")});
      SQL

      rows_to_array(rows)
    end
  end

  def find_one(id)
    row = connection.get_first_row <<-SQL
      SELECT #{columns.join ","} FROM #{table}
      WHERE id = #{id};
    SQL

    init_object_from_row(row)
  end

  def find_by(attribute, value)
    row = connection.get_first_row <<-SQL
      SELECT #{columns.join ","} FROM #{table}
      -- WHERE attribute = #{attribute} AND value = #{value}
      WHERE #{attributes} = #{BlocRecord::Utility.sql_strings(value)};
    SQL

    rows_to_array(row)
  end

  def find_each(options = {})
    start = options.start || 0
    batch_size = options.batch_size || 0

    row = connection.get_first_row <<-SQL
      SELECT #{columns.join ","} FROM #{table}
      LIMIT #{batch_size} #{start};
    SQL

    row.each do |row|
      yield(rows_to_array(row))
    end
  end


  def find_in_batches(options = {})
    start = options.start || 0
    batch_size = options.batch_size || 0

    rows = connection.execute <<-SQL
      SELECT #{columns.join ","} FROM #{table}
      LIMIT #{batch_size} #{start};
    SQL

    arr = rows_to_array(rows)
    yield(arr)
  end

  def take(num=1)
    if num > 1
      rows = connection.execute <<-SQL
        SELECT #{columns.join ","} FROM #{table}
        ORDER BY random()
        LIMIT #{num};
      SQL

      rows_to_array(rows)
    else
      take_one
    end
  end

  def take_one
    row = connection.get_first_row <<-SQL
      SELECT #{columns.join ","} FROM #{table}
      ORDER BY random()
      LIMIT 1;
    SQL

    init_object_from_row(row)
  end

  def first
    row = connection.get_first_row <<-SQL
      SELECT #{columns.join ","} FROM #{table}
      ORDER BY id ASC LIMIT 1;
    SQL

    init_object_from_row(row)
  end

  def last
    row = connection.get_first_row <<-SQL
      SELECT #{columns.join ","} FROM #{table}
      ORDER BY id DESC LIMIT 1;
    SQL

    init_object_from_row(row)
  end

  def all
    rows = connection.execute <<-SQL
      SELECT #{columns.join ","} FROM #{table};
    SQL

    rows_to_array(rows)
  end

  def method_missing(m, *args, &block)
    # fb = m.slice(0..(m.index(m.split("_")[-1])-2)) # "find_by"
    # arg = m.split('_')[2, a.length - 1].join("_").to_sym # method name
    s = m.split('_')[2, m.length - 1].join("_").to_sym
    find_by(s, args)
  end

  private
  def init_object_from_row(row)
    if row
      data = Hash[columns.zip(row)]
      new(data)
    end
  end

  def rows_to_array(rows)
    rows.map { |row| new(Hash[columns.zip(row)])}
  end
end
