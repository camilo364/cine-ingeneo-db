CREATE TABLE tbl_reglas (
    id_regla         NUMBER NOT NULL,
    proceso_negocio  VARCHAR2 
--  ERROR: VARCHAR2 size not specified 
    ,
    nombre_regla     VARCHAR2 
--  ERROR: VARCHAR2 size not specified 
    ,
    valor_regla      VARCHAR2 
--  ERROR: VARCHAR2 size not specified 

);

ALTER TABLE tbl_reglas ADD CONSTRAINT tbl_reglas_pk PRIMARY KEY ( id_regla );


CREATE TABLE tbl_empleados (
    id      NUMBER NOT NULL,
    nombre  VARCHAR2 
--  ERROR: VARCHAR2 size not specified 
    ,
    cargo   VARCHAR2 
--  ERROR: VARCHAR2 size not specified 

);

ALTER TABLE tbl_empleados ADD CONSTRAINT tbl_empleados_pk PRIMARY KEY ( id );

CREATE TABLE tbl_formato (
    id          NUMBER NOT NULL,
    formato     VARCHAR2 
--  ERROR: VARCHAR2 size not specified 
    ,
    comentario  VARCHAR2 
--  ERROR: VARCHAR2 size not specified 

);

ALTER TABLE tbl_formato ADD CONSTRAINT tbl_formato_pk PRIMARY KEY ( id );

CREATE TABLE ciudad (
    id_ciudad      NUMBER NOT NULL,
    nombre_ciudad  VARCHAR2 
--  ERROR: VARCHAR2 size not specified 

);

ALTER TABLE ciudad ADD CONSTRAINT ciudad_pk PRIMARY KEY ( id_ciudad );

CREATE TABLE tbl_sucursal (
    id_sucursal  NUMBER NOT NULL,
    nombre       VARCHAR2 
--  ERROR: VARCHAR2 size not specified 
    ,
    direccion    VARCHAR2 
--  ERROR: VARCHAR2 size not specified 
    ,
    id_director  NUMBER NOT NULL,
    id_ciudad    NUMBER NOT NULL,
    comentario   VARCHAR2 
--  ERROR: VARCHAR2 size not specified 

);

ALTER TABLE tbl_sucursal ADD CONSTRAINT tbl_sucursal_pk PRIMARY KEY ( id_sucursal );

ALTER TABLE tbl_sucursal
    ADD CONSTRAINT tbl_sucursal_ciudad_fk FOREIGN KEY ( id_ciudad )
        REFERENCES ciudad ( id_ciudad );

ALTER TABLE tbl_sucursal
    ADD CONSTRAINT tbl_sucursal_tbl_empleados_fk FOREIGN KEY ( id_director )
        REFERENCES tbl_empleados ( id );
		
CREATE TABLE tbl_salas (
    id           NUMBER NOT NULL,
    nombre       VARCHAR2 
--  ERROR: VARCHAR2 size not specified 
    ,
    id_empleado  NUMBER NOT NULL,
    id_formato   NUMBER NOT NULL,
    id_sucursal  NUMBER NOT NULL
);

ALTER TABLE tbl_salas ADD CONSTRAINT tbl_salas_pk PRIMARY KEY ( id );

ALTER TABLE tbl_salas
    ADD CONSTRAINT tbl_salas_tbl_empleados_fk FOREIGN KEY ( id_empleado )
        REFERENCES tbl_empleados ( id );

ALTER TABLE tbl_salas
    ADD CONSTRAINT tbl_salas_tbl_formato_fk FOREIGN KEY ( id_formato )
        REFERENCES tbl_formato ( id );

ALTER TABLE tbl_salas
    ADD CONSTRAINT tbl_salas_tbl_sucursal_fk FOREIGN KEY ( id_sucursal )
        REFERENCES tbl_sucursal ( id_sucursal );


CREATE TABLE tbl_sillas (
    id_silla  NUMBER NOT NULL,
    id_sala   NUMBER NOT NULL,
    letra     VARCHAR2 
--  ERROR: VARCHAR2 size not specified 
    ,
    numero    NUMBER,
    estado    BLOB
);

ALTER TABLE tbl_sillas ADD CONSTRAINT tbl_sillas_pk PRIMARY KEY ( id_silla );

ALTER TABLE tbl_sillas
    ADD CONSTRAINT tbl_sillas_tbl_salas_fk FOREIGN KEY ( id_sala )
        REFERENCES tbl_salas ( id );

CREATE OR REPLACE TRIGGER fkntm_tbl_sillas BEFORE
    UPDATE OF id_sala ON tbl_sillas
BEGIN
    raise_application_error(-20225, 'Non Transferable FK constraint  on table TBL_SILLAS is violated');
END;

