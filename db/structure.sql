--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.1
-- Dumped by pg_dump version 9.6.1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: answer_shows; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE answer_shows (
    id integer,
    body text,
    question_id integer,
    user_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    num_likes bigint,
    likers integer[],
    user_score bigint
);

ALTER TABLE ONLY answer_shows REPLICA IDENTITY NOTHING;


--
-- Name: answers; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE answers (
    id integer NOT NULL,
    body text,
    question_id integer,
    user_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: answers_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE answers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: answers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE answers_id_seq OWNED BY answers.id;


--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: comments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE comments (
    id integer NOT NULL,
    body text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    user_id integer NOT NULL,
    question_id integer,
    group_id integer,
    answer_id integer,
    CONSTRAINT body_check CHECK ((length(body) > 0)),
    CONSTRAINT type_xor CHECK ((((((question_id IS NOT NULL))::integer + ((answer_id IS NOT NULL))::integer) + ((group_id IS NOT NULL))::integer) = 1))
);


--
-- Name: comments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE comments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: comments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE comments_id_seq OWNED BY comments.id;


--
-- Name: courses; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE courses (
    name text NOT NULL,
    university_domain text NOT NULL,
    created_at timestamp without time zone
);


--
-- Name: group_enrollments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE group_enrollments (
    user_id integer NOT NULL,
    group_id integer NOT NULL,
    created_at timestamp without time zone
);


--
-- Name: group_indices; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE group_indices (
    id integer,
    university_domain text,
    course_name text,
    creator_id integer,
    status character varying(20),
    seats integer,
    location text,
    starts_at timestamp without time zone,
    title text,
    description text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    ends_at timestamp without time zone,
    num_attendees bigint,
    available_seats bigint,
    university_name text
);

ALTER TABLE ONLY group_indices REPLICA IDENTITY NOTHING;


--
-- Name: group_shows; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE group_shows (
    id integer,
    university_domain text,
    course_name text,
    creator_id integer,
    status character varying(20),
    seats integer,
    location text,
    starts_at timestamp without time zone,
    title text,
    description text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    ends_at timestamp without time zone,
    university_name text,
    "full" boolean,
    attendees integer[],
    user_score bigint,
    username character varying
);

ALTER TABLE ONLY group_shows REPLICA IDENTITY NOTHING;


--
-- Name: groups; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE groups (
    id integer NOT NULL,
    university_domain text NOT NULL,
    course_name text NOT NULL,
    creator_id integer,
    status character varying(20),
    seats integer,
    location text NOT NULL,
    starts_at timestamp without time zone NOT NULL,
    title text NOT NULL,
    description text NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    ends_at timestamp without time zone NOT NULL,
    CONSTRAINT ends_at_greater_than_starts_at CHECK ((ends_at > starts_at))
);


--
-- Name: groups_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: groups_id_seq1; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE groups_id_seq1
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: groups_id_seq1; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE groups_id_seq1 OWNED BY groups.id;


--
-- Name: likes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE likes (
    id integer NOT NULL,
    user_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    question_id integer,
    answer_id integer,
    CONSTRAINT type_xor CHECK (((((question_id IS NOT NULL))::integer + ((answer_id IS NOT NULL))::integer) = 1))
);


--
-- Name: likes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE likes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: likes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE likes_id_seq OWNED BY likes.id;


--
-- Name: notifications; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE notifications (
    id integer NOT NULL,
    comment_id integer,
    answer_id integer,
    like_id integer,
    user_id integer NOT NULL,
    read boolean DEFAULT false,
    CONSTRAINT type_xor CHECK ((((((comment_id IS NOT NULL))::integer + ((answer_id IS NOT NULL))::integer) + ((like_id IS NOT NULL))::integer) = 1))
);


--
-- Name: notifications_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE notifications_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: notifications_id_seq1; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE notifications_id_seq1
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: notifications_id_seq1; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE notifications_id_seq1 OWNED BY notifications.id;


--
-- Name: question_indices; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE question_indices (
    id integer,
    title character varying,
    body text,
    user_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    university_domain text,
    course_name text,
    num_answers bigint,
    university_name text,
    course_url text
);

ALTER TABLE ONLY question_indices REPLICA IDENTITY NOTHING;


--
-- Name: question_shows; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE question_shows (
    id integer,
    title character varying,
    body text,
    user_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    university_domain text,
    course_name text,
    university_name text,
    num_likes bigint,
    likers integer[],
    user_score bigint,
    course_url text,
    num_answers bigint
);

ALTER TABLE ONLY question_shows REPLICA IDENTITY NOTHING;


--
-- Name: questions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE questions (
    id integer NOT NULL,
    title character varying,
    body text,
    user_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    university_domain text NOT NULL,
    course_name text NOT NULL,
    CONSTRAINT body_check CHECK ((length(body) > 0)),
    CONSTRAINT title_check CHECK ((length((title)::text) > 0))
);


--
-- Name: questions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE questions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: questions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE questions_id_seq OWNED BY questions.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE schema_migrations (
    version character varying NOT NULL
);


--
-- Name: universities; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE universities (
    domain text NOT NULL,
    name text NOT NULL,
    country text NOT NULL
);


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE users (
    id integer NOT NULL,
    email character varying NOT NULL,
    encrypted_password character varying DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying,
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0 NOT NULL,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip inet,
    last_sign_in_ip inet,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    first_name character varying,
    last_name character varying,
    username character varying,
    avatar_file_name character varying,
    avatar_content_type character varying,
    avatar_file_size integer,
    avatar_updated_at timestamp without time zone,
    avatar character varying,
    avatar_temp character varying,
    processing_avatar boolean,
    crop_x double precision,
    crop_y double precision,
    crop_w double precision,
    crop_h double precision,
    privileges integer DEFAULT 0,
    confirmation_token character varying,
    confirmed_at timestamp without time zone,
    confirmation_sent_at timestamp without time zone,
    unconfirmed_email character varying,
    failed_attempts integer DEFAULT 0 NOT NULL,
    unlock_token character varying,
    locked_at timestamp without time zone,
    about_me text,
    university_domain text
);


--
-- Name: user_with_scores; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW user_with_scores AS
 SELECT users.id,
    users.email,
    users.encrypted_password,
    users.reset_password_token,
    users.reset_password_sent_at,
    users.remember_created_at,
    users.sign_in_count,
    users.current_sign_in_at,
    users.last_sign_in_at,
    users.current_sign_in_ip,
    users.last_sign_in_ip,
    users.created_at,
    users.updated_at,
    users.first_name,
    users.last_name,
    users.username,
    users.avatar_file_name,
    users.avatar_content_type,
    users.avatar_file_size,
    users.avatar_updated_at,
    users.avatar,
    users.avatar_temp,
    users.processing_avatar,
    users.crop_x,
    users.crop_y,
    users.crop_w,
    users.crop_h,
    users.privileges,
    users.confirmation_token,
    users.confirmed_at,
    users.confirmation_sent_at,
    users.unconfirmed_email,
    users.failed_attempts,
    users.unlock_token,
    users.locked_at,
    users.about_me,
    users.university_domain,
    COALESCE((COALESCE(t1.question_likes_score, (0)::bigint) + COALESCE(t2.answer_likes_score, (0)::bigint)), (0)::bigint) AS score
   FROM ((users
     LEFT JOIN ( SELECT questions.user_id,
            (count(*) * 5) AS question_likes_score
           FROM (likes
             JOIN questions ON ((likes.question_id = questions.id)))
          GROUP BY questions.user_id) t1 ON ((t1.user_id = users.id)))
     LEFT JOIN ( SELECT answers.user_id,
            (count(*) * 10) AS answer_likes_score
           FROM (likes
             JOIN answers ON ((likes.answer_id = answers.id)))
          GROUP BY answers.user_id) t2 ON ((t2.user_id = users.id)));


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: answers id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY answers ALTER COLUMN id SET DEFAULT nextval('answers_id_seq'::regclass);


--
-- Name: comments id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY comments ALTER COLUMN id SET DEFAULT nextval('comments_id_seq'::regclass);


--
-- Name: groups id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY groups ALTER COLUMN id SET DEFAULT nextval('groups_id_seq1'::regclass);


--
-- Name: likes id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY likes ALTER COLUMN id SET DEFAULT nextval('likes_id_seq'::regclass);


--
-- Name: notifications id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY notifications ALTER COLUMN id SET DEFAULT nextval('notifications_id_seq1'::regclass);


--
-- Name: questions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY questions ALTER COLUMN id SET DEFAULT nextval('questions_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: answers answers_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY answers
    ADD CONSTRAINT answers_pkey PRIMARY KEY (id);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: comments comments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY comments
    ADD CONSTRAINT comments_pkey PRIMARY KEY (id);


--
-- Name: courses courses_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY courses
    ADD CONSTRAINT courses_pkey PRIMARY KEY (name, university_domain);


--
-- Name: group_enrollments group_enrollments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY group_enrollments
    ADD CONSTRAINT group_enrollments_pkey PRIMARY KEY (user_id, group_id);


--
-- Name: groups groups_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY groups
    ADD CONSTRAINT groups_pkey PRIMARY KEY (id);


--
-- Name: groups groups_starts_at_check; Type: CHECK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE groups
    ADD CONSTRAINT groups_starts_at_check CHECK (((starts_at)::date >= (('now'::text)::timestamp without time zone)::date)) NOT VALID;


--
-- Name: likes likes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY likes
    ADD CONSTRAINT likes_pkey PRIMARY KEY (id);


--
-- Name: notifications notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY notifications
    ADD CONSTRAINT notifications_pkey PRIMARY KEY (id);


--
-- Name: questions questions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY questions
    ADD CONSTRAINT questions_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: likes unique_answer_user; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY likes
    ADD CONSTRAINT unique_answer_user UNIQUE (user_id, answer_id);


--
-- Name: likes unique_question_user; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY likes
    ADD CONSTRAINT unique_question_user UNIQUE (user_id, question_id);


--
-- Name: universities universities_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY universities
    ADD CONSTRAINT universities_pkey PRIMARY KEY (domain);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: answer_id_likes; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX answer_id_likes ON likes USING btree (answer_id);


--
-- Name: answer_id_notifications; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX answer_id_notifications ON notifications USING btree (answer_id);


--
-- Name: comment_id_notifications; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX comment_id_notifications ON notifications USING btree (comment_id);


--
-- Name: comments_answer_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX comments_answer_id ON comments USING btree (answer_id);


--
-- Name: group_enrollments_group_id_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX group_enrollments_group_id_user_id ON group_enrollments USING btree (group_id, user_id);


--
-- Name: group_id_comments; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX group_id_comments ON comments USING btree (group_id);


--
-- Name: group_university; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX group_university ON groups USING btree (university_domain);


--
-- Name: group_university_course; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX group_university_course ON groups USING btree (course_name, university_domain);


--
-- Name: groups_creator_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX groups_creator_id ON groups USING btree (creator_id);


--
-- Name: groups_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX groups_status ON groups USING btree (status);


--
-- Name: index_answers_on_question_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_answers_on_question_id ON answers USING btree (question_id);


--
-- Name: index_answers_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_answers_on_user_id ON answers USING btree (user_id);


--
-- Name: index_comments_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_comments_on_user_id ON comments USING btree (user_id);


--
-- Name: index_likes_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_likes_on_user_id ON likes USING btree (user_id);


--
-- Name: index_questions_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_questions_on_user_id ON questions USING btree (user_id);


--
-- Name: index_users_on_confirmation_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_confirmation_token ON users USING btree (confirmation_token);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_email ON users USING btree (email);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON users USING btree (reset_password_token);


--
-- Name: index_users_on_unlock_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_unlock_token ON users USING btree (unlock_token);


--
-- Name: index_users_on_username; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_users_on_username ON users USING btree (username);


--
-- Name: like_id_notifications; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX like_id_notifications ON notifications USING btree (like_id);


--
-- Name: question_id_comments; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX question_id_comments ON comments USING btree (question_id);


--
-- Name: question_id_likes; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX question_id_likes ON likes USING btree (question_id);


--
-- Name: question_university; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX question_university ON questions USING btree (university_domain);


--
-- Name: question_university_course; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX question_university_course ON questions USING btree (course_name, university_domain);


--
-- Name: universities_name_country_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX universities_name_country_key ON universities USING btree (name, country);


--
-- Name: univresities_domain; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX univresities_domain ON courses USING btree (university_domain);


--
-- Name: user_id_notifications; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX user_id_notifications ON notifications USING btree (user_id);


--
-- Name: answer_shows _RETURN; Type: RULE; Schema: public; Owner: -
--

CREATE RULE "_RETURN" AS
    ON SELECT TO answer_shows DO INSTEAD  SELECT answers.id,
    answers.body,
    answers.question_id,
    answers.user_id,
    answers.created_at,
    answers.updated_at,
    count(likes.answer_id) AS num_likes,
    ARRAY( SELECT likes_1.user_id
           FROM likes likes_1
          WHERE (likes_1.answer_id = answers.id)) AS likers,
    user_with_scores.score AS user_score
   FROM ((answers
     LEFT JOIN likes ON ((likes.answer_id = answers.id)))
     JOIN user_with_scores ON ((user_with_scores.id = answers.user_id)))
  GROUP BY answers.id, user_with_scores.score;


--
-- Name: question_indices _RETURN; Type: RULE; Schema: public; Owner: -
--

CREATE RULE "_RETURN" AS
    ON SELECT TO question_indices DO INSTEAD  SELECT questions.id,
    questions.title,
    questions.body,
    questions.user_id,
    questions.created_at,
    questions.updated_at,
    questions.university_domain,
    questions.course_name,
    count(answers.question_id) AS num_answers,
    universities.name AS university_name,
    concat_ws(','::text, questions.course_name, questions.university_domain) AS course_url
   FROM (((questions
     LEFT JOIN answers ON ((answers.question_id = questions.id)))
     LEFT JOIN likes ON ((likes.question_id = questions.id)))
     JOIN universities ON ((universities.domain = questions.university_domain)))
  GROUP BY questions.id, universities.name
  ORDER BY questions.id DESC;


--
-- Name: group_shows _RETURN; Type: RULE; Schema: public; Owner: -
--

CREATE RULE "_RETURN" AS
    ON SELECT TO group_shows DO INSTEAD  SELECT groups.id,
    groups.university_domain,
    groups.course_name,
    groups.creator_id,
    groups.status,
    groups.seats,
    groups.location,
    groups.starts_at,
    groups.title,
    groups.description,
    groups.created_at,
    groups.updated_at,
    groups.ends_at,
    universities.name AS university_name,
    ( SELECT (count(group_enrollments.group_id) = groups.seats) AS "full") AS "full",
    ARRAY( SELECT group_enrollments_1.user_id
           FROM group_enrollments group_enrollments_1
          WHERE (group_enrollments_1.group_id = groups.id)) AS attendees,
    user_with_scores.score AS user_score,
    user_with_scores.username
   FROM (((groups
     LEFT JOIN universities ON ((universities.domain = groups.university_domain)))
     LEFT JOIN group_enrollments ON ((group_enrollments.group_id = groups.id)))
     JOIN user_with_scores ON ((user_with_scores.id = groups.creator_id)))
  GROUP BY groups.id, universities.name, user_with_scores.score, user_with_scores.username
  ORDER BY groups.id DESC;


--
-- Name: group_indices _RETURN; Type: RULE; Schema: public; Owner: -
--

CREATE RULE "_RETURN" AS
    ON SELECT TO group_indices DO INSTEAD  SELECT groups.id,
    groups.university_domain,
    groups.course_name,
    groups.creator_id,
    groups.status,
    groups.seats,
    groups.location,
    groups.starts_at,
    groups.title,
    groups.description,
    groups.created_at,
    groups.updated_at,
    groups.ends_at,
    count(group_enrollments.group_id) AS num_attendees,
    (groups.seats - count(group_enrollments.group_id)) AS available_seats,
    universities.name AS university_name
   FROM (((groups
     LEFT JOIN group_enrollments ON ((group_enrollments.group_id = groups.id)))
     JOIN courses ON (((courses.name = groups.course_name) AND (courses.university_domain = groups.university_domain))))
     JOIN universities ON ((universities.domain = groups.university_domain)))
  GROUP BY groups.id, universities.name
  ORDER BY groups.id DESC;


--
-- Name: question_shows _RETURN; Type: RULE; Schema: public; Owner: -
--

CREATE RULE "_RETURN" AS
    ON SELECT TO question_shows DO INSTEAD  SELECT questions.id,
    questions.title,
    questions.body,
    questions.user_id,
    questions.created_at,
    questions.updated_at,
    questions.university_domain,
    questions.course_name,
    universities.name AS university_name,
    count(likes.question_id) AS num_likes,
    ARRAY( SELECT likes_1.user_id
           FROM likes likes_1
          WHERE (likes_1.question_id = questions.id)) AS likers,
    user_with_scores.score AS user_score,
    concat_ws(','::text, questions.course_name, questions.university_domain) AS course_url,
    count(answers.question_id) AS num_answers
   FROM ((((questions
     LEFT JOIN answers ON ((answers.question_id = questions.id)))
     LEFT JOIN universities ON ((universities.domain = questions.university_domain)))
     LEFT JOIN likes ON ((likes.question_id = questions.id)))
     JOIN user_with_scores ON ((user_with_scores.id = questions.user_id)))
  GROUP BY questions.id, universities.name, user_with_scores.score
  ORDER BY questions.id DESC;


--
-- Name: comments comments_answer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY comments
    ADD CONSTRAINT comments_answer_id_fkey FOREIGN KEY (answer_id) REFERENCES answers(id);


--
-- Name: comments comments_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY comments
    ADD CONSTRAINT comments_group_id_fkey FOREIGN KEY (group_id) REFERENCES groups(id);


--
-- Name: comments comments_question_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY comments
    ADD CONSTRAINT comments_question_id_fkey FOREIGN KEY (question_id) REFERENCES questions(id);


--
-- Name: courses courses_university_domain_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY courses
    ADD CONSTRAINT courses_university_domain_fkey FOREIGN KEY (university_domain) REFERENCES universities(domain);


--
-- Name: answers fk_rails_584be190c2; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY answers
    ADD CONSTRAINT fk_rails_584be190c2 FOREIGN KEY (user_id) REFERENCES users(id);


--
-- Name: group_enrollments group_enrollments_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY group_enrollments
    ADD CONSTRAINT group_enrollments_group_id_fkey FOREIGN KEY (group_id) REFERENCES groups(id);


--
-- Name: group_enrollments group_enrollments_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY group_enrollments
    ADD CONSTRAINT group_enrollments_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(id);


--
-- Name: likes likes_answer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY likes
    ADD CONSTRAINT likes_answer_id_fkey FOREIGN KEY (answer_id) REFERENCES answers(id);


--
-- Name: likes likes_question_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY likes
    ADD CONSTRAINT likes_question_id_fkey FOREIGN KEY (question_id) REFERENCES questions(id);


--
-- Name: answers question_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY answers
    ADD CONSTRAINT question_id_fkey FOREIGN KEY (question_id) REFERENCES questions(id) ON DELETE RESTRICT;


--
-- Name: questions questions_course_name_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY questions
    ADD CONSTRAINT questions_course_name_fkey FOREIGN KEY (course_name, university_domain) REFERENCES courses(name, university_domain) ON DELETE CASCADE;


--
-- Name: questions questions_university_domain_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY questions
    ADD CONSTRAINT questions_university_domain_fkey FOREIGN KEY (university_domain) REFERENCES universities(domain);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO schema_migrations (version) VALUES ('20150505233338'), ('20150506010212'), ('20150507194029'), ('20150509021434'), ('20150509023217'), ('20150512234934'), ('20150513022850'), ('20150513024047'), ('20150521174051'), ('20150522013424'), ('20150522013527'), ('20150522141021'), ('20150524140836'), ('20150524141300'), ('20150524141651'), ('20150524155233'), ('20150524182504'), ('20150527104115'), ('20150527111322'), ('20150527124000'), ('20150527124029'), ('20150527125200'), ('20150528012103'), ('20150611010401'), ('20150611235143'), ('20161126150918'), ('20161126201601'), ('20170121235310'), ('20170128174941'), ('20170513013732'), ('20170513020814'), ('20170602140605'), ('20170602173250'), ('20170603144915'), ('20170603181850'), ('20170608085855'), ('20170610140217'), ('20170618234617'), ('20170625155851'), ('20170701135559'), ('20170701220823'), ('20170703135433'), ('20170703143449'), ('20170703145422'), ('20170703165120'), ('20170704183704'), ('20170704185400'), ('20170707163816'), ('20170708142323'), ('20170708143334'), ('20170708143844'), ('20170708145456'), ('20170708145929'), ('20170708173144'), ('20170708180722'), ('20170708195544'), ('20170708230417'), ('20170709141249'), ('20170709145158'), ('20170709164637'), ('20170710133220'), ('20170712131010'), ('20170712161245'), ('20170712164827'), ('20170712165525'), ('20170714150352'), ('20170714151555'), ('20170714151710'), ('20170714151751'), ('20170716141344'), ('20170716143309'), ('20170716143807'), ('20170716150341'), ('20170716150650'), ('20170716153300'), ('20170722144042'), ('20170722145240'), ('20170723012653'), ('20170723141041'), ('20170723185703'), ('20170723212641'), ('20170724010718'), ('20170724123546'), ('20170724124134'), ('20170724132330'), ('20170724132719'), ('20170724134336'), ('20170724173525'), ('20170724203545'), ('20170724204101'), ('20170725163352'), ('20170729143526'), ('20170729221557'), ('20170729221709');


