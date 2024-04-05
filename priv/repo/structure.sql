--
-- PostgreSQL database dump
--

-- Dumped from database version 16.2 (Debian 16.2-1.pgdg120+2)
-- Dumped by pg_dump version 16.2

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
-- Name: auth_assignment; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.auth_assignment (
    item_name character varying(64) NOT NULL,
    user_id character varying(64) NOT NULL,
    created_at bigint
);


--
-- Name: auth_item; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.auth_item (
    name character varying(64) NOT NULL,
    type smallint NOT NULL,
    description text,
    rule_name character varying(64),
    data bytea,
    created_at bigint,
    updated_at bigint
);


--
-- Name: auth_item_child; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.auth_item_child (
    parent character varying(64) NOT NULL,
    child character varying(64) NOT NULL
);


--
-- Name: auth_rule; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.auth_rule (
    name character varying(64) NOT NULL,
    data bytea,
    created_at bigint,
    updated_at bigint
);


--
-- Name: automobile_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.automobile_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: automobile; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.automobile (
    id bigint DEFAULT nextval('public.automobile_id_seq'::regclass) NOT NULL,
    vin character varying(17) NOT NULL,
    make character varying(128) NOT NULL,
    model character varying(128) NOT NULL,
    year character varying(20) NOT NULL,
    motor_number numeric(10,2) NOT NULL
);


--
-- Name: customer_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.customer_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: customer; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.customer (
    id bigint DEFAULT nextval('public.customer_id_seq'::regclass) NOT NULL,
    first_name character varying(50),
    last_name character varying(50),
    street_address character varying(256),
    city character varying(128),
    zip character varying(5),
    state character varying(2),
    phone_number_1 character varying(15),
    phone_number_2 character varying(15)
);


--
-- Name: labor_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.labor_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: labor; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.labor (
    id bigint DEFAULT nextval('public.labor_id_seq'::regclass) NOT NULL,
    order_id bigint,
    description text NOT NULL,
    notes text,
    price numeric(10,2) NOT NULL
);


--
-- Name: migration; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.migration (
    version character varying(180) NOT NULL,
    apply_time bigint
);


--
-- Name: note_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.note_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: note; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.note (
    id bigint DEFAULT nextval('public.note_id_seq'::regclass) NOT NULL,
    order_id bigint NOT NULL,
    created_by bigint NOT NULL,
    text text
);


--
-- Name: order_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.order_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: order; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."order" (
    id bigint DEFAULT nextval('public.order_id_seq'::regclass) NOT NULL,
    customer_id bigint NOT NULL,
    automobile_id bigint NOT NULL,
    odometer_reading bigint NOT NULL,
    stage bigint NOT NULL,
    date timestamp with time zone,
    tax numeric(10,2),
    amount_paid numeric(10,2),
    paid_in_full boolean
);


--
-- Name: owns; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.owns (
    customer_id bigint NOT NULL,
    automobile_id bigint NOT NULL
);


--
-- Name: part_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.part_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: part; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.part (
    id bigint DEFAULT nextval('public.part_id_seq'::regclass) NOT NULL,
    order_id bigint,
    price numeric(10,2) NOT NULL,
    margin numeric(10,2) NOT NULL,
    quantity numeric(10,2),
    quantity_type_id bigint,
    description text NOT NULL,
    part_number character varying(100) NOT NULL
);


--
-- Name: quantity_type_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.quantity_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: quantity_type; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.quantity_type (
    id bigint DEFAULT nextval('public.quantity_type_id_seq'::regclass) NOT NULL,
    description text NOT NULL
);


--
-- Name: user_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: user; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."user" (
    id bigint DEFAULT nextval('public.user_id_seq'::regclass) NOT NULL,
    username character varying(255) NOT NULL,
    first_name character varying(50) NOT NULL,
    last_name character varying(50) NOT NULL,
    password character varying(255) NOT NULL,
    auth_key character varying(255) NOT NULL,
    status smallint NOT NULL
);


--
-- Name: auth_assignment idx_26105_primary; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_assignment
    ADD CONSTRAINT idx_26105_primary PRIMARY KEY (item_name, user_id);


--
-- Name: auth_item idx_26108_primary; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_item
    ADD CONSTRAINT idx_26108_primary PRIMARY KEY (name);


--
-- Name: auth_item_child idx_26114_primary; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_item_child
    ADD CONSTRAINT idx_26114_primary PRIMARY KEY (parent, child);


--
-- Name: auth_rule idx_26117_primary; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_rule
    ADD CONSTRAINT idx_26117_primary PRIMARY KEY (name);


--
-- Name: automobile idx_26123_primary; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.automobile
    ADD CONSTRAINT idx_26123_primary PRIMARY KEY (id);


--
-- Name: customer idx_26128_primary; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.customer
    ADD CONSTRAINT idx_26128_primary PRIMARY KEY (id);


--
-- Name: labor idx_26143_primary; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.labor
    ADD CONSTRAINT idx_26143_primary PRIMARY KEY (id);


--
-- Name: migration idx_26149_primary; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.migration
    ADD CONSTRAINT idx_26149_primary PRIMARY KEY (version);


--
-- Name: note idx_26153_primary; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.note
    ADD CONSTRAINT idx_26153_primary PRIMARY KEY (id);


--
-- Name: order idx_26160_primary; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."order"
    ADD CONSTRAINT idx_26160_primary PRIMARY KEY (id);


--
-- Name: part idx_26170_primary; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.part
    ADD CONSTRAINT idx_26170_primary PRIMARY KEY (id);


--
-- Name: quantity_type idx_26178_primary; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.quantity_type
    ADD CONSTRAINT idx_26178_primary PRIMARY KEY (id);


--
-- Name: user idx_26185_primary; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT idx_26185_primary PRIMARY KEY (id);


--
-- Name: idx_26105_idx-auth_assignment-user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "idx_26105_idx-auth_assignment-user_id" ON public.auth_assignment USING btree (user_id);


--
-- Name: idx_26108_idx-auth_item-type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "idx_26108_idx-auth_item-type" ON public.auth_item USING btree (type);


--
-- Name: idx_26108_rule_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_26108_rule_name ON public.auth_item USING btree (rule_name);


--
-- Name: idx_26114_child; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_26114_child ON public.auth_item_child USING btree (child);


--
-- Name: idx_26143_fk_labor_order; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_26143_fk_labor_order ON public.labor USING btree (order_id);


--
-- Name: idx_26153_fk_note_order; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_26153_fk_note_order ON public.note USING btree (order_id);


--
-- Name: idx_26153_fk_note_user; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_26153_fk_note_user ON public.note USING btree (created_by);


--
-- Name: idx_26160_fk_order_automobile; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_26160_fk_order_automobile ON public."order" USING btree (automobile_id);


--
-- Name: idx_26160_fk_order_customer; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_26160_fk_order_customer ON public."order" USING btree (customer_id);


--
-- Name: idx_26166_fk_owns_automobile; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_26166_fk_owns_automobile ON public.owns USING btree (automobile_id);


--
-- Name: idx_26166_fk_owns_customer; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_26166_fk_owns_customer ON public.owns USING btree (customer_id);


--
-- Name: idx_26170_fk_part_order; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_26170_fk_part_order ON public.part USING btree (order_id);


--
-- Name: idx_26170_fk_part_quantity_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_26170_fk_part_quantity_type ON public.part USING btree (quantity_type_id);


--
-- Name: auth_assignment auth_assignment_ibfk_1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_assignment
    ADD CONSTRAINT auth_assignment_ibfk_1 FOREIGN KEY (item_name) REFERENCES public.auth_item(name) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: auth_item_child auth_item_child_ibfk_1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_item_child
    ADD CONSTRAINT auth_item_child_ibfk_1 FOREIGN KEY (parent) REFERENCES public.auth_item(name) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: auth_item_child auth_item_child_ibfk_2; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_item_child
    ADD CONSTRAINT auth_item_child_ibfk_2 FOREIGN KEY (child) REFERENCES public.auth_item(name) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: auth_item auth_item_ibfk_1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_item
    ADD CONSTRAINT auth_item_ibfk_1 FOREIGN KEY (rule_name) REFERENCES public.auth_rule(name) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: labor fk_labor_order; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.labor
    ADD CONSTRAINT fk_labor_order FOREIGN KEY (order_id) REFERENCES public."order"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: note fk_note_order; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.note
    ADD CONSTRAINT fk_note_order FOREIGN KEY (order_id) REFERENCES public."order"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: note fk_note_user; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.note
    ADD CONSTRAINT fk_note_user FOREIGN KEY (created_by) REFERENCES public."user"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: order fk_order_automobile; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."order"
    ADD CONSTRAINT fk_order_automobile FOREIGN KEY (automobile_id) REFERENCES public.automobile(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: order fk_order_customer; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."order"
    ADD CONSTRAINT fk_order_customer FOREIGN KEY (customer_id) REFERENCES public.customer(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: owns fk_owns_automobile; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.owns
    ADD CONSTRAINT fk_owns_automobile FOREIGN KEY (automobile_id) REFERENCES public.automobile(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: owns fk_owns_customer; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.owns
    ADD CONSTRAINT fk_owns_customer FOREIGN KEY (customer_id) REFERENCES public.customer(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: part fk_part_order; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.part
    ADD CONSTRAINT fk_part_order FOREIGN KEY (order_id) REFERENCES public."order"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: part fk_part_quantity_type; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.part
    ADD CONSTRAINT fk_part_quantity_type FOREIGN KEY (quantity_type_id) REFERENCES public.quantity_type(id) ON UPDATE CASCADE;


--
-- PostgreSQL database dump complete
--

