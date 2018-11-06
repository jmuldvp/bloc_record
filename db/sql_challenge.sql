/*  Write a SQL query using the professor / department / compensation data that
    outputs the average number of vacation days by department:
*/

With cte as (
  select
    p.department_id
    ,c.vacation_days
  from
    professor p
    join compensation c on p.id = c.professor_id
  )
  select
    d.department_name
    ,avg(cte.vacation_days)
  from
    cte
    join department d ON cte.department_id = d.id
  group by
    cte.department_id
    ,d.department_name
    ,d.id;


-- d.department_name|avg(cte.vacation_days)
-- Transfiguration|2.0
-- Defence Against the Dark Arts|9.0
-- Study of Ancient Runes|8.0
-- Care of Magical Creatures|13.0
