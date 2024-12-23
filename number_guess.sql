--
-- PostgreSQL database dump
--

-- Dumped from database version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)
-- Dumped by pg_dump version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE number_guess;
--
-- Name: number_guess; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE number_guess WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE number_guess OWNER TO freecodecamp;

\connect number_guess

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: guess_stats; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.guess_stats (
    username_id integer NOT NULL,
    games_played integer,
    best_game integer
);


ALTER TABLE public.guess_stats OWNER TO freecodecamp;

--
-- Name: userlist; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.userlist (
    username_id integer NOT NULL,
    username character varying(22) NOT NULL
);


ALTER TABLE public.userlist OWNER TO freecodecamp;

--
-- Name: userlist_username_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.userlist_username_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.userlist_username_id_seq OWNER TO freecodecamp;

--
-- Name: userlist_username_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.userlist_username_id_seq OWNED BY public.userlist.username_id;


--
-- Name: userlist username_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.userlist ALTER COLUMN username_id SET DEFAULT nextval('public.userlist_username_id_seq'::regclass);


--
-- Data for Name: guess_stats; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.guess_stats VALUES (7, 2, 605);
INSERT INTO public.guess_stats VALUES (6, 5, 122);
INSERT INTO public.guess_stats VALUES (1, 6, 2);
INSERT INTO public.guess_stats VALUES (3, 1, 567);
INSERT INTO public.guess_stats VALUES (2, 1, 851);
INSERT INTO public.guess_stats VALUES (5, 2, 31);
INSERT INTO public.guess_stats VALUES (4, 5, 344);


--
-- Data for Name: userlist; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.userlist VALUES (1, 'tmatal');
INSERT INTO public.userlist VALUES (2, 'user_1734983321173');
INSERT INTO public.userlist VALUES (3, 'user_1734983321172');
INSERT INTO public.userlist VALUES (4, 'user_1734984923380');
INSERT INTO public.userlist VALUES (5, 'user_1734984923379');
INSERT INTO public.userlist VALUES (6, 'user_1734985165088');
INSERT INTO public.userlist VALUES (7, 'user_1734985165087');


--
-- Name: userlist_username_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.userlist_username_id_seq', 7, true);


--
-- Name: guess_stats guess_stats_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.guess_stats
    ADD CONSTRAINT guess_stats_pkey PRIMARY KEY (username_id);


--
-- Name: userlist userlist_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.userlist
    ADD CONSTRAINT userlist_pkey PRIMARY KEY (username_id);


--
-- Name: guess_stats guess_stats_username_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.guess_stats
    ADD CONSTRAINT guess_stats_username_id_fkey FOREIGN KEY (username_id) REFERENCES public.userlist(username_id);


--
-- PostgreSQL database dump complete
--

