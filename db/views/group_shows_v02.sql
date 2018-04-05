SELECT groups.*, 
  universities.name as university_name, 
  (select count(group_enrollments.group_id) = groups.seats as full), 
  array(select group_enrollments.user_id from group_enrollments where group_enrollments.group_id = groups.id) as attendees 
FROM "groups" 
LEFT OUTER JOIN "universities" ON "universities"."domain" = "groups"."university_domain" 
LEFT OUTER JOIN "group_enrollments" ON "group_enrollments"."group_id" = "groups"."id" 
GROUP BY groups.id, universities.name
ORDER BY "groups"."id" DESC