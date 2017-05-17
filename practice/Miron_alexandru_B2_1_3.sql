select q.question,q.answer from questions q
join users u on q.user_id = u.id
where u.USERNAME = '&user' 