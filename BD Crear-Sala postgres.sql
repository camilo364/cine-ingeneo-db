CREATE SCHEMA shingeneo;

CREATE TABLE shingeneo.tbl_reglas (
    id_regla smallserial primary key,
    proceso_negocio text,
    nombre_regla text,
    valor_regla text);
   
CREATE TABLE shingeneo.tbl_empleados (
    id bigserial primary key,
    nombre text,
    cargo text
);

CREATE TABLE shingeneo.tbl_formato (
    id smallserial primary key,
    formato text,
    comentario text
);
    
CREATE table shingeneo.tbl_ciudad (
    id_ciudad smallserial primary key,
    nombre_ciudad  text
);

CREATE TABLE shingeneo.tbl_sucursal (
    id_sucursal  smallserial primary key,
    nombre  text,
    direccion text,
    id_director integer not null,
    id_ciudad integer NOT NULL,
    comentario text,
    CONSTRAINT fk_sucursal_ciudad FOREIGN KEY (id_ciudad) 
		REFERENCES shingeneo.tbl_ciudad (id_ciudad),
	CONSTRAINT fk_sucursal_empleados FOREIGN KEY (id_director) 
		REFERENCES shingeneo.tbl_empleados (id)
);
  
CREATE TABLE shingeneo.tbl_salas (
    id smallserial primary key,
    nombre text,
    filas integer not null,
    id_formato integer NOT NULL,
    id_sucursal integer NOT null,
	CONSTRAINT fk_salas_formato FOREIGN KEY (id_formato) 
		REFERENCES shingeneo.tbl_formato(id),
	CONSTRAINT fk_salas_sucursal FOREIGN KEY (id_sucursal) 
		REFERENCES shingeneo.tbl_sucursal(id_sucursal)
);

CREATE TABLE shingeneo.tbl_sillas (
    id_silla serial primary key,
    id_sala integer NOT NULL,
    letra text,
    numero integer,
    estado text,
    CONSTRAINT fk_sillas_sala FOREIGN KEY (id_sala) 
		REFERENCES shingeneo.tbl_salas(id)
);


INSERT INTO shingeneo.tbl_ciudad
(nombre_ciudad)
VALUES('MEDELLIN'), ('BARRANQUILLA');


INSERT INTO shingeneo.tbl_empleados
(nombre, cargo)
VALUES ('BARBAS', 'DIRECTOR'), ('DIANA VELEZ', 'ADMINISTRADOR');

INSERT INTO shingeneo.tbl_formato
(formato, comentario)
VALUES('2D', ''), ('3D','');

INSERT INTO shingeneo.tbl_reglas
(proceso_negocio, nombre_regla, valor_regla)
VALUES('CREAR SALA', 'MAXIMO DE FILAS', '27'),
('CREAR SALA', 'MINIMO DE FILAS', '3'),
('CREAR SALA', 'MAXIMO DE SILLAS', '10'),
('CREAR SALA', 'MINIMO DE SILLAS', '3');

INSERT INTO shingeneo.tbl_sucursal
(nombre, direccion, id_director, id_ciudad, comentario)
VALUES('MONTERREY', 'ALGUNA', 4, 1, ''), ('SAN JUAN', 'ALGUNA', 4, 2, '');