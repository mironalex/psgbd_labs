select u.name,count(q.id) from questions q
join users u on q.user_id = u.id
group by u.id,u.name
order by count(q.id) desc