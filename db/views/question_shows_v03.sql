SELECT questions.*, 
  universities.name as university_name, 
  count(likes.question_id) as num_likes,
  array(select likes.user_id from likes where likes.question_id = questions.id) as likers,
  user_with_scores.score as user_score
FROM "questions" 
LEFT OUTER JOIN "universities" ON "universities"."domain" = "questions"."university_domain"
LEFT OUTER JOIN "likes" ON "likes"."question_id" = "questions"."id" 
INNER JOIN "user_with_scores" ON "user_with_scores"."id" = "questions"."user_id"
GROUP BY questions.id, universities.name, user_with_scores.score
ORDER BY "questions"."id" DESC