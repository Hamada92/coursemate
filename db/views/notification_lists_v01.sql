 SELECT notifications.id, 
 comments.id as comment_id,
 comments.body, 
 comment_statuses.seen, 
 comment_statuses.user_id as notified_user, 
 COALESCE(substring(questions.title from 0 for 30), substring(answer_questions.title from 0 for 30)) as question_title, 
 groups.title as group_title, 
 COALESCE(questions.id,  answer_questions.id) as question_id, 
 groups.id as group_id, 
 'comment'::text as notification_type 
 FROM "notifications" 
 inner join comments on comments.id = notifications.comment_id 
 inner join comment_statuses on comment_statuses.comment_id = comments.id 
 left join questions on questions.id = comments.question_id 
 left join groups on groups.id = comments.group_id 
 left join answers on answers.id = comments.answer_id 
 left join questions answer_questions on answer_questions.id = answers.question_id 
 ORDER BY "notifications"."id" DESC