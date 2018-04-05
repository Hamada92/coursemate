SELECT questions.*, 
  universities.name as university_name, 
  count(likes.question_id) as num_likes,
  array(select likes.user_id from likes where likes.question_id = questions.id) as likers
FROM "questions" 
LEFT OUTER JOIN "universities" ON "universities"."domain" = "questions"."university_domain"
LEFT OUTER JOIN "likes" ON "likes"."question_id" = "questions"."id" 
GROUP BY questions.id, universities.name
ORDER BY "questions"."id" DESC