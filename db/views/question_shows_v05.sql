SELECT questions.*, 
  universities.name as university_name, 
  count(likes.question_id) as num_likes,
  array(select likes.user_id from likes where likes.question_id = questions.id) as likers,
  user_with_scores.score as user_score,
  question_html_bodies.body as html_body,
  concat_ws(',', questions.course_name, questions.university_domain) as course_url
FROM "questions" 
LEFT OUTER JOIN "universities" ON "universities"."domain" = "questions"."university_domain"
LEFT OUTER JOIN "likes" ON "likes"."question_id" = "questions"."id" 
LEFT OUTER JOIN "question_html_bodies" ON "question_html_bodies"."question_id" = "questions"."id"
INNER JOIN "user_with_scores" ON "user_with_scores"."id" = "questions"."user_id"
GROUP BY questions.id, universities.name, user_with_scores.score, question_html_bodies.body
ORDER BY "questions"."id" DESC