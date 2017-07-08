SELECT questions.*,
  count(answers.question_id) as num_answers,
  universities.name as university_name
FROM "questions" INNER JOIN "answers"
ON "answers"."question_id" = "questions"."id"
INNER JOIN "courses" ON "courses"."name" = "questions"."course_name" AND "courses"."university_domain" = "questions"."university_domain"
INNER JOIN "universities" ON "universities"."domain" = "questions"."university_domain"
GROUP BY questions.id, universities.name
ORDER BY "questions"."id" DESC;