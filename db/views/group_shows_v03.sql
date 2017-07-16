SELECT groups.*, 
  universities.name as university_name, 
  (select count(group_enrollments.group_id) = groups.seats as full), 
  array(select group_enrollments.user_id from group_enrollments where group_enrollments.group_id = groups.id) as attendees,
  user_with_scores.score as user_score,
  user_with_scores.username as username
FROM "groups" 
LEFT OUTER JOIN "universities" ON "universities"."domain" = "groups"."university_domain" 
LEFT OUTER JOIN "group_enrollments" ON "group_enrollments"."group_id" = "groups"."id" 
INNER JOIN "user_with_scores" ON "user_with_scores"."id" = "groups"."creator_id"
GROUP BY groups.id, universities.name, user_with_scores.score, user_with_scores.username
ORDER BY "groups"."id" DESC