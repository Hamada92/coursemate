SELECT answers.*, 
  count(likes.answer_id) as num_likes, 
  array(select likes.user_id from likes where likes.answer_id = answers.id) as likers 
FROM "answers" 
LEFT OUTER JOIN "likes" ON "likes"."answer_id" = "answers"."id" 
GROUP BY answers.id