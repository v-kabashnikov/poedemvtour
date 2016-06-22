--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: sletat_ru_hotels_base_country; Type: TABLE; Schema: public; Owner: unihotel_org; Tablespace: 
--

CREATE TABLE sletat_ru_hotels_base_country (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    alias character varying(255) NOT NULL,
    is_visa boolean NOT NULL,
    rank integer NOT NULL,
    unihotel_conformity_id integer,
    conformity_need_confirm boolean NOT NULL,
    image character varying(100)
);


ALTER TABLE sletat_ru_hotels_base_country OWNER TO unihotel_org;

--
-- Data for Name: sletat_ru_hotels_base_country; Type: TABLE DATA; Schema: public; Owner: unihotel_org
--

COPY sletat_ru_hotels_base_country (id, name, alias, is_visa, rank, unihotel_conformity_id, conformity_need_confirm, image) FROM stdin;
3	Австрия	NIL	t	1	199	f	upload/regions_photos/68031ca4-1aa5-46c0-9d89-62cfeeab57e1.gif
6	Ангилья	NIL	t	2	245	f	upload/regions_photos/09d1e6fc-63e9-4780-9e85-653996f6da7b.png
7	Андорра	NIL	t	2	247	f	upload/regions_photos/8a5ffc0a-21ef-4a99-961d-1d112eaf8bfe.png
8	Антигуа	NIL	f	2	249	t	upload/regions_photos/7988ff8a-35e0-4952-b86f-95d6c3c0b524.png
11	Аруба	NIL	t	2	252	f	upload/regions_photos/43e2cc9c-2a5c-4cdf-a509-a2f2e214e727.jpg
13	Бангладеш	NIL	t	2	255	f	upload/regions_photos/e02890a7-4006-449a-bad5-3f757dff1042.png
15	Бахрейн	NIL	t	2	257	f	upload/regions_photos/fb7fe2a7-a451-4319-8647-b1b691101555.png
17	Белиз	NIL	t	2	259	f	upload/regions_photos/fa5ea1c2-d7c7-465c-a000-321319230242.png
180	Бермудские острова		t	2	\N	f	upload/regions_photos/aad28bf7-c094-41ac-91d6-da9d2bec65c1.jpg
21	Босния и Герцеговина	NIL	f	2	\N	f	upload/regions_photos/19be6cd7-d089-4f90-8e01-8862ae275fe8.gif
23	Бразилия	NIL	f	1	266	f	upload/regions_photos/f325ebfe-52ec-452a-9d9c-25141c7213a8.png
25	Буркина-Фасо	NIL	t	2	269	f	upload/regions_photos/53cc6818-c117-4ee3-aa7e-4a0ad9fe4a9f.png
190	Бутан		f	2	271	f	upload/regions_photos/7000dba7-8259-41ee-a73e-9adeb4b0424d.gif
27	Венгрия	NIL	t	1	273	f	upload/regions_photos/51b0b0f4-1d5f-459e-adea-3c73e18988b9.png
154	Гана	Ghana	t	2	281	f	upload/regions_photos/2f8c5d70-ac15-4949-afbf-12de4d7476a5.png
31	Гватемала	NIL	f	2	283	f	upload/regions_photos/dbbaedb8-5a7d-469d-a74e-617c8b5f79d8.png
33	Гондурас	NIL	f	2	288	f	upload/regions_photos/8d812c00-730a-4dbe-a822-1684ea9ff8b5.png
34	Гренада	NIL	f	2	290	f	upload/regions_photos/468d7dc9-8f23-4d9a-b87d-ceb89d88c9f2.png
196	Гренландия 		f	2	\N	f	upload/regions_photos/a98f682b-543b-4837-9793-790faf903dcb.png
37	Дания	NIL	t	2	295	f	upload/regions_photos/e07093ab-8ab3-427a-9d97-8217a1f08d5d.jpg
170	Доминика	Dominica	f	2	298	f	upload/regions_photos/2d7366fd-8ffd-45e0-8cd3-27cf81794414.png
40	Египет	NIL	f	0	200	f	upload/regions_photos/240f1f99-8ba1-41f7-9c35-353dc1c65ccd.png
43	Израиль	NIL	f	0	303	f	upload/regions_photos/374a4bd2-0a70-417d-9bea-a3449142770e.png
45	Индонезия	IND	t	2	217	f	upload/regions_photos/fe6143e5-6320-4457-b76c-bb72d39a5749.gif
47	Иран	NIL	t	2	306	t	upload/regions_photos/59e0bdca-b746-4920-9f80-de8242ccee26.png
49	Исландия	NIL	t	2	308	f	upload/regions_photos/b905740c-adba-40b3-bc53-3021b7bbc613.png
52	Кабо-Верде	NIL	t	2	310	f	upload/regions_photos/4068fad8-c4f8-4467-9ddc-c028b703ee16.gif
54	Камбоджа	NIL	t	1	312	f	upload/regions_photos/576a30eb-d36c-4b6e-ac24-94b54599758d.png
55	Канада	NIL	t	2	314	f	upload/regions_photos/8e0aaa42-0507-4130-a60f-5397f13ca359.png
57	Кения	NIL	t	2	316	f	upload/regions_photos/b5bc2a61-c3e8-41a6-b9db-a594429fb77b.jpg
59	Китай	NIL	t	2	225	f	upload/regions_photos/73a8eb9e-73df-4616-a7f5-c74aa4a72b4d.png
61	Куба	NIL	f	1	226	f	upload/regions_photos/ee7ef334-6e28-44f7-aab6-719a762ee674.png
63	Лаос	NIL	f	2	328	f	upload/regions_photos/17bf36ef-db88-4ac1-8c55-05dce968584e.jpg?1409119805
65	Ливан	NIL	t	2	331	f	upload/regions_photos/6dec1e05-cad9-46ef-8134-0ab5301c4379.png
176	Лихтенштейн		t	2	334	f	upload/regions_photos/a37bf61e-ed03-468d-873e-90502ffc35e4.gif
69	Мадагаскар	NIL	t	2	338	f	upload/regions_photos/f97cbfff-f096-4571-94e1-c1f67f960ec5.png
71	Малайзия	NIL	f	2	216	f	upload/regions_photos/8caf4a4c-be98-40bd-a8e7-cb6ea3577b3c.png
73	Мальта	NIL	t	0	214	f	upload/regions_photos/da670f28-bbe1-4be2-83f2-410068bf4949.png
75	Марокко	NIL	f	0	229	f	upload/regions_photos/4aba00ee-1b07-4187-8a39-c8908ecd4389.gif
76	Мартиника	NIL	t	2	344	f	upload/regions_photos/dbaec36e-e4fd-4ff4-b929-7179640f3f8f.png
79	Молдавия	NIL	f	2	\N	f	upload/regions_photos/8dad9315-3b07-4091-a3dc-9ec8dd9f9cb6.gif
81	Монголия	NIL	t	2	351	f	upload/regions_photos/dc0c026e-e640-4756-b55c-b484a6e0bb11.png
83	Намибия	NIL	f	2	354	f	upload/regions_photos/f7dcaecf-b32a-48f1-b5f4-966260c88bc4.gif
181	Нигерия	Nigeria	t	2	358	f	upload/regions_photos/af5bd6c4-27e5-42db-8bf2-0af1b6ffc1d3.gif
88	Норвегия	NIL	t	1	365	f	upload/regions_photos/1a0ecbaa-16c2-4b1e-91b6-eb4e9feb7294.gif
90	ОАЭ	UAE	f	0	219	f	upload/regions_photos/952431d9-f11b-4107-a83a-f54f3e7273e7.gif
91	Оман	NIL	t	2	367	f	upload/regions_photos/c23d0738-335c-454d-8dc5-355da42d494c.png
172	Палау	Palau	t	2	379	f	upload/regions_photos/671e26e8-26bf-4c29-a886-d43cb09cabed.png
185	Папуа Новая Гвинея	PG	t	2	\N	f	upload/regions_photos/63e83a38-98c9-4b9d-85a9-a9051dd7efac.gif
96	Перу	NIL	f	2	385	f	upload/regions_photos/76f5ff2b-96dd-4171-b120-9434c020ee15.svg
99	Португалия	NIL	t	0	230	f	upload/regions_photos/5123db4d-0b7b-42cf-af72-03e49b49f5ec.png
100	Реюньон	NIL	t	2	390	f	upload/regions_photos/01924840-a175-4bd6-90e6-a7b0f9f12124.gif
178	Сан-Марино		t	2	395	f	upload/regions_photos/df21d9b7-79c1-436e-adcd-e2fdeb97509b.gif
104	Свазиленд	NIL	f	2	398	f	upload/regions_photos/b223fdf6-3c2b-4b29-8a77-88ce074aaeb3.png
158	Сенегал	Senegal	t	2	404	f	upload/regions_photos/da516d6d-3b2d-45cc-b9fe-8f6b51e9becd.png
195	Сент-Винсент и Гренадины		f	2	\N	f	upload/regions_photos/f4cf039e-331d-4953-af86-c498e40f62fb.png
106	Сент-Люсия	NIL	t	2	406	f	upload/regions_photos/18bde6f6-04d0-4868-9d4e-a56f06039109.jpg
19	Болгария	NIL	t	0	211	f	upload/regions_photos/38be2883-e02d-48c2-a8f9-82a2477e2743.gif
1	Абхазия	NIL	f	2	\N	f	upload/regions_photos/72d4a192-35a1-4afa-936a-0f899a62b74b.jpg
2	Австралия	NIL	t	2	220	f	upload/regions_photos/85b8c065-016a-4c11-9f8d-3061475c735b.png
20	Боливия	NIL	t	2	263	f	upload/regions_photos/b76705e5-30b8-4482-964e-10841ed25ad3.png
4	Азербайджан	NIL	f	2	241	f	upload/regions_photos/07fb943d-27e1-417f-ae9e-42dcbf3a6db1.jpg
30	Гваделупа	NIL	t	2	282	f	upload/regions_photos/365e10db-4c5f-4f1d-ba1c-b150cd61a7d4.jpg
5	Албания	NIL	f	2	242	f	upload/regions_photos/a8369e9d-f3e1-4b10-b682-77b0395906ae.png
22	Ботсвана	NIL	f	2	265	f	upload/regions_photos/82d9dd20-7e8f-41d5-9f4c-86122011a1a8.gif
184	Антарктида	-	f	2	248	f	upload/regions_photos/68dd3f76-5820-4174-92c3-fb62f98bcf79.gif
9	Аргентина	NIL	f	2	250	f	upload/regions_photos/d843c88d-6bfc-4f95-be44-657b37175ea5.jpg
24	Бруней	NIL	t	2	268	t	upload/regions_photos/7633de14-63c6-4e0b-91f0-d368d62cac8f.gif
10	Армения	NIL	f	2	251	f	upload/regions_photos/56c21305-fd25-4291-845e-bcf46a64bc93.png
12	Багамы	NIL	f	1	254	f	upload/regions_photos/38e13844-82f1-41fa-96e7-a83677f63af2.jpg
14	Барбадос	NIL	f	1	256	f	upload/regions_photos/0463fc98-276e-449c-8bf4-c715ba7b8e8d.png
173	Бурунди	Bur	t	2	270	f	upload/regions_photos/a52af403-ef10-4fa1-bff2-2bd93d760181.png
16	Беларусь	NIL	f	1	258	f	upload/regions_photos/edf561a8-a864-4243-9769-7354ff631982.jpg
18	Бельгия	NIL	t	1	260	f	upload/regions_photos/3eaf0506-c492-49db-a563-92517ce9e6e9.png
149	Германия	Germany	t	1	222	f	upload/regions_photos/d455766d-c573-462b-b0a1-22d498f7aaf7.gif
26	Великобритания	NIL	t	1	\N	f	upload/regions_photos/6f33984c-e4e6-4109-bb60-68ee3b7b7680.jpg
128	Чехия	NIL	t	0	213	f	upload/regions_photos/359c1341-64b6-4a11-b727-14fd5c0ae8df.gif
38	Джибути	NIL	t	2	297	f	upload/regions_photos/c4f7ec5a-84e4-47e2-8464-9d5e0920f1e6.gif
179	Гонконг	Hong Kong	f	2	289	f	upload/regions_photos/91f91429-af46-4f7f-951c-30d398b5ebad.gif
28	Венесуэла	NIL	f	2	274	f	upload/regions_photos/a60e7add-41ca-4e3b-ab20-7f08b3c3c6d2.png
29	Вьетнам	NIL	f	1	221	f	upload/regions_photos/2a0b22d5-8631-48e1-a688-e16682126648.gif
42	Зимбабве	NIL	t	2	302	f	upload/regions_photos/89da0b7e-46d3-4f30-be3a-e0d77fe97c27.jpg?1457702517
35	Греция	NIL	t	0	292	f	upload/regions_photos/3b76f153-2c21-422c-a7f7-1f016fee1163.jpg
39	Доминикана	NIL	f	1	223	f	upload/regions_photos/536e65c8-7fc1-4375-84a1-82989ed5d12c.png
36	Грузия	NIL	f	2	293	f	upload/regions_photos/563136a7-225b-4999-8ae5-ca3c877e7026.latest?cb=20150114132252&path-prefix=ru
41	Замбия	NIL	t	2	300	f	upload/regions_photos/2d949835-d6a5-4e7e-9c37-0312583500eb.png
44	Индия	NIL	t	1	224	f	upload/regions_photos/cd40209c-9117-4d75-b48b-6a9cf54e3eef.png
46	Иордания	NIL	t	2	304	f	upload/regions_photos/304b579b-f043-416b-9ba3-4fddc0a20519.png
48	Ирландия	NIL	t	1	307	f	upload/regions_photos/72968094-cd42-4fcf-b88d-9850ffa4e79b.jpg
51	Италия	NIL	t	0	206	f	upload/regions_photos/49da9923-dfac-4200-a91a-e9f74ed53069.gif
50	Испания	NIL	t	0	202	f	upload/regions_photos/f5cb774f-5684-465b-837f-3770edb53d2f.png
53	Казахстан	NIL	f	2	311	f	upload/regions_photos/4ac1a356-fc02-4724-a8a0-35d8fbe992ac.png
167	Камерун	Кам	t	2	313	f	upload/regions_photos/fa1d7921-27a9-42ab-90f7-52af173f76f3.jpg
56	Катар	NIL	t	2	315	f	upload/regions_photos/04efa974-6f29-466b-9af8-ca4414b079b7.png
171	Колумбия	Colo	f	2	320	f	upload/regions_photos/4599df77-b773-4c3e-a4b2-e2e1391c2c8d.png
58	Кипр	NIL	f	0	208	f	upload/regions_photos/bdc6c5ce-f1fa-46a1-84a9-3448ee05b92f.gif
78	Мозамбик	NIL	t	2	348	f	upload/regions_photos/26c3325e-0407-4121-9534-4c6078e2da68.png
150	Россия	Russia	f	0	391	f	upload/regions_photos/a39a2bf8-6186-4027-9b96-75f5f007430c.png
108	Сингапур	NIL	f	1	215	f	upload/regions_photos/41b566b2-5f6d-48da-94be-a2e59781a139.png
111	Словения	NIL	t	1	411	f	upload/regions_photos/d4c600aa-bec4-41a7-896f-034288936b39.png
112	США	NIL	t	1	276	t	upload/regions_photos/7de94349-eb0c-449c-8435-06da6a1f5da5.jpg
113	Таиланд	Tha	f	0	420	f	upload/regions_photos/b30493ab-4a34-4587-befe-f00cd95faf80.png
116	Теркс и Кайкос	NIL	t	2	\N	f	upload/regions_photos/6e26c662-2aa5-454f-b9cc-dcead97532f1.gif
156	Того	Togo	t	2	424	f	upload/regions_photos/c96cc9b9-2454-499e-bc52-d36f81daf615.jpg
119	Турция	TUR	f	0	201	f	upload/regions_photos/81cb41c2-11d7-4ecc-ac1d-e5aabd480d23.png
161	Уганда	Uganda	t	2	430	f	upload/regions_photos/11c4bd90-0372-40f5-8b2a-6f0fd3849ad4.png
121	Украина	NIL	f	1	432	f	upload/regions_photos/68bf9663-41df-42c3-bac5-50a6023d7161.gif
122	Фиджи	NIL	f	2	235	f	upload/regions_photos/e5f80672-0310-4879-a1f2-9081863e16e9.png
124	Финляндия	NIL	t	0	436	f	upload/regions_photos/6a7abe5d-e7e1-4499-a7ab-0e4f9ac7b19c.gif
126	Хорватия	NIL	t	0	204	f	upload/regions_photos/1acff83d-57ea-4e67-8339-828b6bf9bbb6.gif
168	ЦАР	CAR	t	2	236	t	upload/regions_photos/ebd7fa59-32c2-4e20-8c44-e88cb6ffab64.png
130	Швейцария	NIL	t	1	\N	f	upload/regions_photos/488e6841-3517-458b-a5d0-f21726f695c1.png
132	Шри-Ланка	NIL	t	0	447	f	upload/regions_photos/2b365183-7fb6-46dd-913b-3b68ec843f28.gif
165	Эритрея	Эри	t	2	452	f	upload/regions_photos/d73e621b-4de4-4b15-864d-ef58f611df66.png
135	Эфиопия	NIL	t	2	454	f	upload/regions_photos/a2c6b274-52b1-4ed9-8b07-5be5e90c57bb.jpg
137	Южная Корея	NIL	f	2	457	f	upload/regions_photos/558b56a0-3aa2-45a0-94b8-6b3fa366bffd.gif
139	Япония	NIL	t	2	210	f	upload/regions_photos/cb28d66d-9e50-4a83-a70c-3ef2168443f2.gif
105	Сейшелы	SEY	f	1	231	f	upload/regions_photos/316b4914-22be-4a85-806f-95704c8ec2fd.jpg
60	Коста-Рика	NIL	t	2	325	f	upload/regions_photos/7a416d02-5b9d-497e-b462-541204aa2f12.png
62	Кыргызcтан	NIL	f	2	\N	f	upload/regions_photos/36eb8b4d-a2ed-414a-9ba3-d5f1690d855a.jpg
64	Латвия	NIL	t	1	329	f	upload/regions_photos/d3bd8a84-c065-4d9c-88ea-2ba3f5cebd15.png
189	Сен-Мартен		f	2	\N	f	upload/regions_photos/18528962-c353-4d20-b0da-96fc49b23b30.png
66	Литва	NIL	t	1	335	f	upload/regions_photos/be5be399-10fa-4296-bf9f-6d2c06c87842.gif
67	Люксембург	NIL	t	2	336	f	upload/regions_photos/a3ca0fbe-dbb5-4829-9905-d4c7b3ee1bf7.gif
68	Маврикий	MAU	t	1	227	f	upload/regions_photos/160766cc-bdcf-40f9-902f-67f9bdc9e5bf.png
125	Франция	NIL	t	0	203	f	upload/regions_photos/25c4d132-d680-4f36-8f32-1490157685a5.gif
70	Македония	NIL	f	2	389	t	upload/regions_photos/b4facf63-1333-4a28-82f9-56fb2139f727.gif
194	Сент-Китс и Невис		f	2	\N	f	upload/regions_photos/66d955ad-f572-4604-8452-ffe5bdfe948f.png
72	Мальдивы	NIL	f	0	228	f	upload/regions_photos/c8021203-3db3-498f-b88e-c6dd86213c8a.png
74	Марианские о-ва	NIL	f	2	\N	f	upload/regions_photos/6532e1e4-f0f3-4396-bdd4-49a6d515cd7c.gif
77	Мексика	NIL	t	2	346	f	upload/regions_photos/7307dfbe-2849-451d-92dc-a9a37522c3fc.jpg
107	Сербия	NIL	f	2	408	f	upload/regions_photos/8d330975-9ac3-418c-b8d4-1f4a17ffe839.gif
80	Монако	NIL	f	0	350	f	upload/regions_photos/cd39c55a-f8c2-443b-b0ef-330f839b7ca5.png
82	Мьянма (Бирма)	NIL	t	1	\N	f	upload/regions_photos/428694a7-5246-43b5-9846-5a400129a272.png
136	ЮАР	NIL	t	2	232	f	upload/regions_photos/b6c6faa6-4ad8-4a2e-8b10-e7e0d796cc4a.png
84	Непал	NIL	t	2	356	f	upload/regions_photos/afc82310-abbf-48c2-ad2f-d8d4a72b39e8.jpg
109	Сирия	NIL	t	2	\N	f	upload/regions_photos/28d0365a-e7c1-4248-ad9d-0399c310b39a.png
86	Нидерланды	NIL	t	0	360	f	upload/regions_photos/23adaaad-ecc2-4739-b932-66d5bc9b0d65.gif
177	Никарагуа		f	2	361	f	upload/regions_photos/bd985093-c7b4-452e-8fb5-a5dc446c335c.svg
87	Новая Зеландия	NIL	t	1	363	f	upload/regions_photos/9a0bd684-8126-454d-8932-3a05be7a721f.png
169	Французская Полинезия	Фра	t	2	439	f	upload/regions_photos/2e529edb-6ad9-4d66-bedb-8a6e320453f2.png
89	о. Кука	NIL	f	2	\N	f	upload/regions_photos/ee35ccdf-7312-488c-b032-180a2f917582.gif
110	Словакия	NIL	t	1	410	f	upload/regions_photos/f7fee6d7-16af-4b71-976c-9df93ee430ed.gif
92	Пакистан	NIL	t	2	378	f	upload/regions_photos/935ed26d-b10b-416a-ad19-3b24f28a3cea.jpg
93	Панама	NIL	t	2	381	f	upload/regions_photos/02e0202a-4b86-4c90-b798-cb95cf63c3e1.png
95	Парагвай	NIL	f	2	384	f	upload/regions_photos/6d6858b5-f94e-4f04-aaea-f832b7f50fd6.gif
193	Таджикистан		f	2	419	f	upload/regions_photos/680331d2-23ad-40a9-981a-098d9ec6d8e7.png
98	Польша	NIL	t	1	387	f	upload/regions_photos/7f761cc4-3d5f-4928-b539-86f928e2a536.png
102	Румыния	NIL	t	2	393	f	upload/regions_photos/3b211162-4c95-4397-955d-bb8a1c7ea340.png
103	Саудовская Аравия	NIL	t	2	397	f	upload/regions_photos/fb5b9098-5aaa-455d-a222-9182b2fbc791.png
127	Черногория	NIL	f	0	212	f	upload/regions_photos/914710f4-2c00-417c-9a7e-ccb1b5d1be44.png
114	Тайвань	NIL	t	2	422	t	upload/regions_photos/7921ecf8-7713-4ffa-afc4-7ddb5a0160ee.gif
115	Танзания	NIL	t	2	234	f	upload/regions_photos/faddc015-3637-4127-8d4a-bba4fa8e3af0.gif
117	Тунис	NIL	f	0	209	f	upload/regions_photos/4f77862e-1564-4da1-9ba5-4e23d1cd2c0c.png
118	Туркменистан	NIL	t	2	429	f	upload/regions_photos/23667dad-fdf0-4a43-a4bf-a516c1776a2f.gif
129	Чили	NIL	f	2	444	f	upload/regions_photos/64b0d8e3-4bdc-44e3-a0b5-55c3e15c74ce.png
120	Узбекистан	NIL	f	2	431	f	upload/regions_photos/f96d9700-2848-4560-891c-9f0626499d3b.png
192	Уругвай		f	2	434	f	upload/regions_photos/a41bf5e8-afb7-4d33-8e79-c0fe75d837ef.png
138	Ямайка	NIL	f	1	458	f	upload/regions_photos/df6bb24d-a834-4465-9b96-d1f06738ad8e.png
123	Филиппины	NIL	f	2	233	f	upload/regions_photos/7d120277-dcd0-4ba3-aaa0-7b38ac6c5d91.png
131	Швеция	NIL	t	0	445	f	upload/regions_photos/94d84641-2344-42c1-8bbc-20c3c7ad6091.gif
133	Эквадор	NIL	f	2	448	f	upload/regions_photos/061b9fe9-63e5-40ec-8d8a-725fc6c0e4b0.png
134	Эстония	NIL	t	1	453	f	upload/regions_photos/ea512f4a-27f9-4fb4-b33e-e39037700260.gif
\.


--
-- Name: sletat_ru_hotels_base_country_pkey; Type: CONSTRAINT; Schema: public; Owner: unihotel_org; Tablespace: 
--

ALTER TABLE ONLY sletat_ru_hotels_base_country
    ADD CONSTRAINT sletat_ru_hotels_base_country_pkey PRIMARY KEY (id);


--
-- Name: sletat_ru_hotels_base_country_unihotel_conformity_id_key; Type: CONSTRAINT; Schema: public; Owner: unihotel_org; Tablespace: 
--

ALTER TABLE ONLY sletat_ru_hotels_base_country
    ADD CONSTRAINT sletat_ru_hotels_base_country_unihotel_conformity_id_key UNIQUE (unihotel_conformity_id);


--
-- Name: s_unihotel_conformity_id_39882596b9f9952d_fk_regions_country_id; Type: FK CONSTRAINT; Schema: public; Owner: unihotel_org
--

ALTER TABLE ONLY sletat_ru_hotels_base_country
    ADD CONSTRAINT s_unihotel_conformity_id_39882596b9f9952d_fk_regions_country_id FOREIGN KEY (unihotel_conformity_id) REFERENCES regions_country(id) DEFERRABLE INITIALLY DEFERRED;


--
-- PostgreSQL database dump complete
--

