SELECT questions.*, 
  universities.name as university_name, 
  count(likes.question_id) as num_likes, 
  array(select likes.user_id from likes where likes.question_id = questions.id) as likers,
  users.username, 
  users.score as userscore
FROM "questions" 
LEFT OUTER JOIN "universities" ON "universities"."domain" = "questions"."university_domain"
LEFT OUTER JOIN "likes" ON "likes"."question_id" = "questions"."id" 
LEFT OUTER JOIN "users" ON "users"."id" = "questions"."user_id"
GROUP BY questions.id, universities.name, users.id 
ORDER BY "questions"."id" DESC