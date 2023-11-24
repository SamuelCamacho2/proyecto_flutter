-- create table users(
-- 	id bigserial primary key,
-- 	email varchar(80) not null unique,
-- 	name varchar(50) not null,
-- 	lastname varchar(60) not null,
-- 	phone varchar(10) not null unique,
-- 	image varchar(255) null,
-- 	password varchar(20) not null,
-- 	is_vailabel boolean null,
-- 	session_token varchar(255) null,
-- 	created_at timestamp(0) not null,
-- 	updated_at timestamp(0) not null
-- );

-- CREATE TABLE roles(
-- 	id bigserial primary key,
-- 	name varchar(80) not null unique,
-- 	image varchar(255) null,
-- 	route varchar(255) null,
-- 	created_at timestamp(0) not null,
-- 	updated_at timestamp(0) not null
-- );

-- CREATE TABLE user_has_rol(
-- 	id_user bigserial not null,
-- 	id_rol bigserial not null,
-- 	created_at timestamp(0) not null,
-- 	updated_at timestamp(0) not null,
-- 	foreign key(id_user) references users(id) on update cascade on delete cascade,
-- 	foreign key(id_rol) references roles(id) on update cascade on delete cascade,
-- 	primary key(id_user,id_rol)

-- );

-- insert into users(
-- 	email,
-- 	name,
-- 	lastname,
-- 	phone,
-- 	password,
-- 	created_at,
-- 	updated_at
-- )
-- values(
-- 	'samuel@gmail.com',
-- 	'samuel',
-- 	'camacho',
-- 	'4819907365',
-- 	'samuel123',
-- 	'2023-11-7',
-- 	'2023-11-7'
-- );

-- select * from users;

-- create table categories(
-- 	id bigserial primary key,
-- 	name varchar(180) not null,
-- 	description varchar(255) not null,
-- 	created_at timestamp(0) not null,
-- 	updated_at timestamp(0) not null
-- );

-- create table products(
-- 	id bigserial primary key,
-- 	name varchar(180) not null unique,
-- 	description varchar(255) not null,
-- 	price decimal default 0,
-- 	image1 varchar(255) null,
-- 	image2 varchar(255) null,
-- 	image3 varchar(255) null,
-- 	id_categoria bigint not null,
-- 	created_at timestamp(0) not null,
-- 	updated_at timestamp(0) not null,
-- 	Foreign key(id_categoria) references categories(id) 
-- 	on update cascade on delete cascade 
-- );

-- CREATE TABLE address(
--     id BIGSERIAL PRIMARY KEY,
--     id_user BIGINT NOT NULL,
--     address VARCHAR(255) NOT NULL,
--     neighborhood VARCHAR(255) NOT NULL,
--     lat DECIMAL DEFAULT 0,
--     lng DECIMAL DEFAULT 0,
--     created_at TIMESTAMP(0) NOT NULL,
--     updated_at TIMESTAMP(0) NOT NULL,
--     FOREIGN KEY(id_user) REFERENCES users(id)  
--     ON UPDATE cascade ON DELETE cascade 
-- )

-- CREATE TABLE order_has_product(
--     id_order BIGINT NOT NULL,
-- 	id_product BIGINT NOT NULL,
-- 	quantity BIGINT NOT NULL,
--     created_at TIMESTAMP(0) NOT NULL,
--     updated_at TIMESTAMP(0) NOT NULL,
-- 	PRIMARY key(id_order,id_product),
--     FOREIGN KEY(id_product) REFERENCES products(id) ON UPDATE cascade ON DELETE cascade, 
--     FOREIGN KEY(id_order) REFERENCES orders(id) ON UPDATE cascade ON DELETE cascade 	
	
-- )

-- CREATE TABLE orders(
--     id BIGSERIAL PRIMARY KEY,
--     id_client BIGINT NOT NULL,
-- 	id_delivery BIGINT NOT NULL,
-- 	id_addres BIGINT NOT NULL,
--     lat DECIMAL DEFAULT 0,
--     lng DECIMAL DEFAULT 0,
-- 	status varchar(90) not null,
-- 	timestamp BIGINT NOT NULL,
--     created_at TIMESTAMP(0) NOT NULL,
--     updated_at TIMESTAMP(0) NOT NULL,
--     FOREIGN KEY(id_client) REFERENCES users(id) ON UPDATE cascade ON DELETE cascade ,
--     FOREIGN KEY(id_delivery) REFERENCES users(id) ON UPDATE cascade ON DELETE cascade, 
--     FOREIGN KEY(id_addres) REFERENCES address(id) ON UPDATE cascade ON DELETE cascade 	
	
-- )