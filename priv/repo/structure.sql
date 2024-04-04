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

--
-- Name: order; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA "order";


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: auth_assignment; Type: TABLE; Schema: order; Owner: -
--

CREATE TABLE "order".auth_assignment (
    item_name character varying(64) NOT NULL,
    user_id character varying(64) NOT NULL,
    created_at bigint
);


--
-- Name: auth_item; Type: TABLE; Schema: order; Owner: -
--

CREATE TABLE "order".auth_item (
    name character varying(64) NOT NULL,
    type smallint NOT NULL,
    description text,
    rule_name character varying(64) DEFAULT NULL::character varying,
    data bytea,
    created_at bigint,
    updated_at bigint
);


--
-- Name: auth_item_child; Type: TABLE; Schema: order; Owner: -
--

CREATE TABLE "order".auth_item_child (
    parent character varying(64) NOT NULL,
    child character varying(64) NOT NULL
);


--
-- Name: auth_rule; Type: TABLE; Schema: order; Owner: -
--

CREATE TABLE "order".auth_rule (
    name character varying(64) NOT NULL,
    data bytea,
    created_at bigint,
    updated_at bigint
);


--
-- Name: automobile; Type: TABLE; Schema: order; Owner: -
--

CREATE TABLE "order".automobile (
    id bigint NOT NULL,
    vin character varying(17) NOT NULL,
    make character varying(128) NOT NULL,
    model character varying(128) NOT NULL,
    year character varying(20) NOT NULL,
    motor_number numeric(10,2) NOT NULL
);


--
-- Name: automobile_id_seq; Type: SEQUENCE; Schema: order; Owner: -
--

CREATE SEQUENCE "order".automobile_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: automobile_id_seq; Type: SEQUENCE OWNED BY; Schema: order; Owner: -
--

ALTER SEQUENCE "order".automobile_id_seq OWNED BY "order".automobile.id;


--
-- Name: customer; Type: TABLE; Schema: order; Owner: -
--

CREATE TABLE "order".customer (
    id bigint NOT NULL,
    first_name character varying(50) DEFAULT NULL::character varying,
    last_name character varying(50) DEFAULT NULL::character varying,
    street_address character varying(256) DEFAULT NULL::character varying,
    city character varying(128) DEFAULT NULL::character varying,
    zip character varying(5) DEFAULT NULL::character varying,
    state character varying(2) DEFAULT NULL::character varying,
    phone_number_1 character varying(15) DEFAULT NULL::character varying,
    phone_number_2 character varying(15) DEFAULT NULL::character varying
);


--
-- Name: customer_id_seq; Type: SEQUENCE; Schema: order; Owner: -
--

CREATE SEQUENCE "order".customer_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: customer_id_seq; Type: SEQUENCE OWNED BY; Schema: order; Owner: -
--

ALTER SEQUENCE "order".customer_id_seq OWNED BY "order".customer.id;


--
-- Name: labor; Type: TABLE; Schema: order; Owner: -
--

CREATE TABLE "order".labor (
    id bigint NOT NULL,
    order_id bigint,
    description text NOT NULL,
    notes text,
    price numeric(10,2) NOT NULL
);


--
-- Name: labor_id_seq; Type: SEQUENCE; Schema: order; Owner: -
--

CREATE SEQUENCE "order".labor_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: labor_id_seq; Type: SEQUENCE OWNED BY; Schema: order; Owner: -
--

ALTER SEQUENCE "order".labor_id_seq OWNED BY "order".labor.id;


--
-- Name: migration; Type: TABLE; Schema: order; Owner: -
--

CREATE TABLE "order".migration (
    version character varying(180) NOT NULL,
    apply_time bigint
);


--
-- Name: note; Type: TABLE; Schema: order; Owner: -
--

CREATE TABLE "order".note (
    id bigint NOT NULL,
    order_id bigint NOT NULL,
    created_by bigint NOT NULL,
    text text
);


--
-- Name: note_id_seq; Type: SEQUENCE; Schema: order; Owner: -
--

CREATE SEQUENCE "order".note_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: note_id_seq; Type: SEQUENCE OWNED BY; Schema: order; Owner: -
--

ALTER SEQUENCE "order".note_id_seq OWNED BY "order".note.id;


--
-- Name: order; Type: TABLE; Schema: order; Owner: -
--

CREATE TABLE "order"."order" (
    id bigint NOT NULL,
    customer_id bigint NOT NULL,
    automobile_id bigint NOT NULL,
    odometer_reading bigint NOT NULL,
    stage bigint NOT NULL,
    date timestamp with time zone,
    tax numeric(10,2) DEFAULT NULL::numeric,
    amount_paid numeric(10,2) DEFAULT NULL::numeric,
    paid_in_full boolean
);


--
-- Name: order_id_seq; Type: SEQUENCE; Schema: order; Owner: -
--

CREATE SEQUENCE "order".order_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: order_id_seq; Type: SEQUENCE OWNED BY; Schema: order; Owner: -
--

ALTER SEQUENCE "order".order_id_seq OWNED BY "order"."order".id;


--
-- Name: owns; Type: TABLE; Schema: order; Owner: -
--

CREATE TABLE "order".owns (
    customer_id bigint NOT NULL,
    automobile_id bigint NOT NULL
);


--
-- Name: part; Type: TABLE; Schema: order; Owner: -
--

CREATE TABLE "order".part (
    id bigint NOT NULL,
    order_id bigint,
    price numeric(10,2) NOT NULL,
    margin numeric(10,2) NOT NULL,
    quantity numeric(10,2) DEFAULT NULL::numeric,
    quantity_type_id bigint,
    description text NOT NULL,
    part_number character varying(100) NOT NULL
);


--
-- Name: part_id_seq; Type: SEQUENCE; Schema: order; Owner: -
--

CREATE SEQUENCE "order".part_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: part_id_seq; Type: SEQUENCE OWNED BY; Schema: order; Owner: -
--

ALTER SEQUENCE "order".part_id_seq OWNED BY "order".part.id;


--
-- Name: quantity_type; Type: TABLE; Schema: order; Owner: -
--

CREATE TABLE "order".quantity_type (
    id bigint NOT NULL,
    description text NOT NULL
);


--
-- Name: quantity_type_id_seq; Type: SEQUENCE; Schema: order; Owner: -
--

CREATE SEQUENCE "order".quantity_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: quantity_type_id_seq; Type: SEQUENCE OWNED BY; Schema: order; Owner: -
--

ALTER SEQUENCE "order".quantity_type_id_seq OWNED BY "order".quantity_type.id;


--
-- Name: user; Type: TABLE; Schema: order; Owner: -
--

CREATE TABLE "order"."user" (
    id bigint NOT NULL,
    username character varying(255) NOT NULL,
    first_name character varying(50) NOT NULL,
    last_name character varying(50) NOT NULL,
    password character varying(255) NOT NULL,
    auth_key character varying(255) NOT NULL,
    status smallint NOT NULL
);


--
-- Name: user_id_seq; Type: SEQUENCE; Schema: order; Owner: -
--

CREATE SEQUENCE "order".user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: user_id_seq; Type: SEQUENCE OWNED BY; Schema: order; Owner: -
--

ALTER SEQUENCE "order".user_id_seq OWNED BY "order"."user".id;


--
-- Name: automobile id; Type: DEFAULT; Schema: order; Owner: -
--

ALTER TABLE ONLY "order".automobile ALTER COLUMN id SET DEFAULT nextval('"order".automobile_id_seq'::regclass);


--
-- Name: customer id; Type: DEFAULT; Schema: order; Owner: -
--

ALTER TABLE ONLY "order".customer ALTER COLUMN id SET DEFAULT nextval('"order".customer_id_seq'::regclass);


--
-- Name: labor id; Type: DEFAULT; Schema: order; Owner: -
--

ALTER TABLE ONLY "order".labor ALTER COLUMN id SET DEFAULT nextval('"order".labor_id_seq'::regclass);


--
-- Name: note id; Type: DEFAULT; Schema: order; Owner: -
--

ALTER TABLE ONLY "order".note ALTER COLUMN id SET DEFAULT nextval('"order".note_id_seq'::regclass);


--
-- Name: order id; Type: DEFAULT; Schema: order; Owner: -
--

ALTER TABLE ONLY "order"."order" ALTER COLUMN id SET DEFAULT nextval('"order".order_id_seq'::regclass);


--
-- Name: part id; Type: DEFAULT; Schema: order; Owner: -
--

ALTER TABLE ONLY "order".part ALTER COLUMN id SET DEFAULT nextval('"order".part_id_seq'::regclass);


--
-- Name: quantity_type id; Type: DEFAULT; Schema: order; Owner: -
--

ALTER TABLE ONLY "order".quantity_type ALTER COLUMN id SET DEFAULT nextval('"order".quantity_type_id_seq'::regclass);


--
-- Name: user id; Type: DEFAULT; Schema: order; Owner: -
--

ALTER TABLE ONLY "order"."user" ALTER COLUMN id SET DEFAULT nextval('"order".user_id_seq'::regclass);


--
-- Name: auth_assignment idx_24580_primary; Type: CONSTRAINT; Schema: order; Owner: -
--

ALTER TABLE ONLY "order".auth_assignment
    ADD CONSTRAINT idx_24580_primary PRIMARY KEY (item_name, user_id);


--
-- Name: auth_item idx_24583_primary; Type: CONSTRAINT; Schema: order; Owner: -
--

ALTER TABLE ONLY "order".auth_item
    ADD CONSTRAINT idx_24583_primary PRIMARY KEY (name);


--
-- Name: auth_item_child idx_24589_primary; Type: CONSTRAINT; Schema: order; Owner: -
--

ALTER TABLE ONLY "order".auth_item_child
    ADD CONSTRAINT idx_24589_primary PRIMARY KEY (parent, child);


--
-- Name: auth_rule idx_24592_primary; Type: CONSTRAINT; Schema: order; Owner: -
--

ALTER TABLE ONLY "order".auth_rule
    ADD CONSTRAINT idx_24592_primary PRIMARY KEY (name);


--
-- Name: automobile idx_24598_primary; Type: CONSTRAINT; Schema: order; Owner: -
--

ALTER TABLE ONLY "order".automobile
    ADD CONSTRAINT idx_24598_primary PRIMARY KEY (id);


--
-- Name: customer idx_24603_primary; Type: CONSTRAINT; Schema: order; Owner: -
--

ALTER TABLE ONLY "order".customer
    ADD CONSTRAINT idx_24603_primary PRIMARY KEY (id);


--
-- Name: labor idx_24618_primary; Type: CONSTRAINT; Schema: order; Owner: -
--

ALTER TABLE ONLY "order".labor
    ADD CONSTRAINT idx_24618_primary PRIMARY KEY (id);


--
-- Name: migration idx_24624_primary; Type: CONSTRAINT; Schema: order; Owner: -
--

ALTER TABLE ONLY "order".migration
    ADD CONSTRAINT idx_24624_primary PRIMARY KEY (version);


--
-- Name: note idx_24628_primary; Type: CONSTRAINT; Schema: order; Owner: -
--

ALTER TABLE ONLY "order".note
    ADD CONSTRAINT idx_24628_primary PRIMARY KEY (id);


--
-- Name: order idx_24635_primary; Type: CONSTRAINT; Schema: order; Owner: -
--

ALTER TABLE ONLY "order"."order"
    ADD CONSTRAINT idx_24635_primary PRIMARY KEY (id);


--
-- Name: part idx_24645_primary; Type: CONSTRAINT; Schema: order; Owner: -
--

ALTER TABLE ONLY "order".part
    ADD CONSTRAINT idx_24645_primary PRIMARY KEY (id);


--
-- Name: quantity_type idx_24653_primary; Type: CONSTRAINT; Schema: order; Owner: -
--

ALTER TABLE ONLY "order".quantity_type
    ADD CONSTRAINT idx_24653_primary PRIMARY KEY (id);


--
-- Name: user idx_24660_primary; Type: CONSTRAINT; Schema: order; Owner: -
--

ALTER TABLE ONLY "order"."user"
    ADD CONSTRAINT idx_24660_primary PRIMARY KEY (id);


--
-- Name: idx_24580_idx-auth_assignment-user_id; Type: INDEX; Schema: order; Owner: -
--

CREATE INDEX "idx_24580_idx-auth_assignment-user_id" ON "order".auth_assignment USING btree (user_id);


--
-- Name: idx_24583_idx-auth_item-type; Type: INDEX; Schema: order; Owner: -
--

CREATE INDEX "idx_24583_idx-auth_item-type" ON "order".auth_item USING btree (type);


--
-- Name: idx_24583_rule_name; Type: INDEX; Schema: order; Owner: -
--

CREATE INDEX idx_24583_rule_name ON "order".auth_item USING btree (rule_name);


--
-- Name: idx_24589_child; Type: INDEX; Schema: order; Owner: -
--

CREATE INDEX idx_24589_child ON "order".auth_item_child USING btree (child);


--
-- Name: idx_24618_fk_labor_order; Type: INDEX; Schema: order; Owner: -
--

CREATE INDEX idx_24618_fk_labor_order ON "order".labor USING btree (order_id);


--
-- Name: idx_24628_fk_note_order; Type: INDEX; Schema: order; Owner: -
--

CREATE INDEX idx_24628_fk_note_order ON "order".note USING btree (order_id);


--
-- Name: idx_24628_fk_note_user; Type: INDEX; Schema: order; Owner: -
--

CREATE INDEX idx_24628_fk_note_user ON "order".note USING btree (created_by);


--
-- Name: idx_24635_fk_order_automobile; Type: INDEX; Schema: order; Owner: -
--

CREATE INDEX idx_24635_fk_order_automobile ON "order"."order" USING btree (automobile_id);


--
-- Name: idx_24635_fk_order_customer; Type: INDEX; Schema: order; Owner: -
--

CREATE INDEX idx_24635_fk_order_customer ON "order"."order" USING btree (customer_id);


--
-- Name: idx_24641_fk_owns_automobile; Type: INDEX; Schema: order; Owner: -
--

CREATE INDEX idx_24641_fk_owns_automobile ON "order".owns USING btree (automobile_id);


--
-- Name: idx_24641_fk_owns_customer; Type: INDEX; Schema: order; Owner: -
--

CREATE INDEX idx_24641_fk_owns_customer ON "order".owns USING btree (customer_id);


--
-- Name: idx_24645_fk_part_order; Type: INDEX; Schema: order; Owner: -
--

CREATE INDEX idx_24645_fk_part_order ON "order".part USING btree (order_id);


--
-- Name: idx_24645_fk_part_quantity_type; Type: INDEX; Schema: order; Owner: -
--

CREATE INDEX idx_24645_fk_part_quantity_type ON "order".part USING btree (quantity_type_id);


--
-- Name: auth_assignment auth_assignment_ibfk_1; Type: FK CONSTRAINT; Schema: order; Owner: -
--

ALTER TABLE ONLY "order".auth_assignment
    ADD CONSTRAINT auth_assignment_ibfk_1 FOREIGN KEY (item_name) REFERENCES "order".auth_item(name) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: auth_item_child auth_item_child_ibfk_1; Type: FK CONSTRAINT; Schema: order; Owner: -
--

ALTER TABLE ONLY "order".auth_item_child
    ADD CONSTRAINT auth_item_child_ibfk_1 FOREIGN KEY (parent) REFERENCES "order".auth_item(name) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: auth_item_child auth_item_child_ibfk_2; Type: FK CONSTRAINT; Schema: order; Owner: -
--

ALTER TABLE ONLY "order".auth_item_child
    ADD CONSTRAINT auth_item_child_ibfk_2 FOREIGN KEY (child) REFERENCES "order".auth_item(name) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: auth_item auth_item_ibfk_1; Type: FK CONSTRAINT; Schema: order; Owner: -
--

ALTER TABLE ONLY "order".auth_item
    ADD CONSTRAINT auth_item_ibfk_1 FOREIGN KEY (rule_name) REFERENCES "order".auth_rule(name) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: labor fk_labor_order; Type: FK CONSTRAINT; Schema: order; Owner: -
--

ALTER TABLE ONLY "order".labor
    ADD CONSTRAINT fk_labor_order FOREIGN KEY (order_id) REFERENCES "order"."order"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: note fk_note_order; Type: FK CONSTRAINT; Schema: order; Owner: -
--

ALTER TABLE ONLY "order".note
    ADD CONSTRAINT fk_note_order FOREIGN KEY (order_id) REFERENCES "order"."order"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: note fk_note_user; Type: FK CONSTRAINT; Schema: order; Owner: -
--

ALTER TABLE ONLY "order".note
    ADD CONSTRAINT fk_note_user FOREIGN KEY (created_by) REFERENCES "order"."user"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: order fk_order_automobile; Type: FK CONSTRAINT; Schema: order; Owner: -
--

ALTER TABLE ONLY "order"."order"
    ADD CONSTRAINT fk_order_automobile FOREIGN KEY (automobile_id) REFERENCES "order".automobile(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: order fk_order_customer; Type: FK CONSTRAINT; Schema: order; Owner: -
--

ALTER TABLE ONLY "order"."order"
    ADD CONSTRAINT fk_order_customer FOREIGN KEY (customer_id) REFERENCES "order".customer(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: owns fk_owns_automobile; Type: FK CONSTRAINT; Schema: order; Owner: -
--

ALTER TABLE ONLY "order".owns
    ADD CONSTRAINT fk_owns_automobile FOREIGN KEY (automobile_id) REFERENCES "order".automobile(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: owns fk_owns_customer; Type: FK CONSTRAINT; Schema: order; Owner: -
--

ALTER TABLE ONLY "order".owns
    ADD CONSTRAINT fk_owns_customer FOREIGN KEY (customer_id) REFERENCES "order".customer(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: part fk_part_order; Type: FK CONSTRAINT; Schema: order; Owner: -
--

ALTER TABLE ONLY "order".part
    ADD CONSTRAINT fk_part_order FOREIGN KEY (order_id) REFERENCES "order"."order"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: part fk_part_quantity_type; Type: FK CONSTRAINT; Schema: order; Owner: -
--

ALTER TABLE ONLY "order".part
    ADD CONSTRAINT fk_part_quantity_type FOREIGN KEY (quantity_type_id) REFERENCES "order".quantity_type(id) ON UPDATE CASCADE;


--
-- PostgreSQL database dump complete
--

