SELECT groups.*,
  count(group_enrollments.group_id) as num_attendees,
  groups.seats - count(group_enrollments.group_id) as available_seats,
  universities.name as university_name
FROM "groups" 
LEFT OUTER JOIN "group_enrollments" ON "group_enrollments"."group_id" = "groups"."id"
INNER JOIN "courses" ON "courses"."name" = "groups"."course_name" AND "courses"."university_domain" = "groups"."university_domain"
INNER JOIN "universities" ON "universities"."domain" = "groups"."university_domain"
GROUP BY groups.id, universities.name
ORDER BY "groups"."id" DESC;