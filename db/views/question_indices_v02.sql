SELECT questions.*,
  count(answers.question_id) as num_answers,
  universities.name as university_name
FROM "questions" 
LEFT OUTER JOIN "answers" ON "answers"."question_id" = "questions"."id"
LEFT OUTER JOIN "likes" ON "likes"."question_id" = "questions"."id"
INNER JOIN "universities" ON "universities"."domain" = "questions"."university_domain"
GROUP BY questions.id, universities.name
ORDER BY "questions"."id" DESC;