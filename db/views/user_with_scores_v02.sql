SELECT users.*, 
  COALESCE(COALESCE(t1.question_likes_score, 0) + COALESCE(t2.answer_likes_score, 0), 0) as score
from users 
left join 
  (select questions.user_id, count(*) * 5 as question_likes_score from likes 
    join questions on likes.question_id = questions.id 
    group by questions.user_id) t1
  on t1.user_id = users.id 
left join 
  (select answers.user_id, count(*) * 10 as answer_likes_score from likes 
    join answers on likes.answer_id = answers.id 
    group by answers.user_id) t2
  on t2.user_id = users.id;