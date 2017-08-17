SELECT answers.*, 
  count(likes.answer_id) as num_likes, 
  array(select likes.user_id from likes where likes.answer_id = answers.id) as likers,
  user_with_scores.score as user_score 
FROM "answers" 
LEFT OUTER JOIN "likes" ON "likes"."answer_id" = "answers"."id" 
LEFT OUTER JOIN "user_with_scores" ON "user_with_scores"."id" = "answers"."user_id"
GROUP BY answers.id, user_with_scores.score