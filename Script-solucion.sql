CREATE TABLE tbl_reglas (
    id_regla         NUMBER NOT NULL,
    proceso_negocio  VARCHAR2 ,
    nombre_regla     VARCHAR2 ,
    valor_regla      VARCHAR2 
 

);

ALTER TABLE tbl_reglas ADD CONSTRAINT tbl_reglas_pk PRIMARY KEY ( id_regla );


CREATE TABLE tbl_empleados (
    id      NUMBER NOT NULL,
    nombre  VARCHAR2 ,
    cargo   VARCHAR2 
 

);

ALTER TABLE tbl_empleados ADD CONSTRAINT tbl_empleados_pk PRIMARY KEY ( id );

CREATE TABLE tbl_formato (
    id          NUMBER NOT NULL,
    formato     VARCHAR2 ,
    comentario  VARCHAR2 
 

);

ALTER TABLE tbl_formato ADD CONSTRAINT tbl_formato_pk PRIMARY KEY ( id );

CREATE TABLE ciudad (
    id_ciudad      NUMBER NOT NULL,
    nombre_ciudad  VARCHAR2 
 

);

ALTER TABLE ciudad ADD CONSTRAINT ciudad_pk PRIMARY KEY ( id_ciudad );

CREATE TABLE tbl_sucursal (
    id_sucursal  NUMBER NOT NULL,
    nombre       VARCHAR2 ,
    direccion    VARCHAR2 ,
    id_director  NUMBER NOT NULL,
    id_ciudad    NUMBER NOT NULL,
    comentario   VARCHAR2 
 

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
    nombre       VARCHAR2 ,
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
    letra     VARCHAR2 ,
    numero    NUMBER,
    estado    BLOB
);

ALTER TABLE tbl_sillas ADD CONSTRAINT tbl_sillas_pk PRIMARY KEY ( id_silla );

ALTER TABLE tbl_sillas
    ADD CONSTRAINT tbl_sillas_tbl_salas_fk FOREIGN KEY ( id_sala )
        REFERENCES tbl_salas ( id );
		
		
		
CREATE TABLE tbl_pelicula (
    id_pelicula      NUMBER NOT NULL,
    nombre_original  VARCHAR2 ,
    nombre_local     VARCHAR2 ,
    fecha_estreno    DATE,
    id_imagen        NUMBER NOT NULL
);

ALTER TABLE tbl_pelicula ADD CONSTRAINT tbl_pelicula_pk PRIMARY KEY ( id_pelicula );

ALTER TABLE tbl_pelicula
    ADD CONSTRAINT tbl_pelicula_tbl_imagen_fk FOREIGN KEY ( id_imagen )
        REFERENCES tbl_imagen ( id_imagen );

CREATE TABLE tbl_campos_pelicula (
    id            NUMBER NOT NULL,
    id_pelicula   NUMBER NOT NULL,
    nombre_campo  VARCHAR2 ,
    tipo_campo    VARCHAR2 ,
    valor         VARCHAR2 

);

ALTER TABLE tbl_campos_pelicula ADD CONSTRAINT tbl_campos_pelicula_pk PRIMARY KEY ( id );

ALTER TABLE tbl_campos_pelicula
    ADD CONSTRAINT table_9_tbl_pelicula_fk FOREIGN KEY ( id_pelicula )
        REFERENCES tbl_pelicula ( id_pelicula );
		
		
CREATE TABLE tbl_formato_pelicula (
    id           NUMBER NOT NULL,
    id_formato   NUMBER NOT NULL,
    id_pelicula  NUMBER NOT NULL
);

ALTER TABLE tbl_formato_pelicula ADD CONSTRAINT tbl_formato_pelicula_pk PRIMARY KEY ( id );

ALTER TABLE tbl_formato_pelicula
    ADD CONSTRAINT table_11_tbl_formato_fk FOREIGN KEY ( id_formato )
        REFERENCES tbl_formato ( id );

ALTER TABLE tbl_formato_pelicula
    ADD CONSTRAINT table_11_tbl_pelicula_fk FOREIGN KEY ( id_pelicula )
        REFERENCES tbl_pelicula ( id_pelicula );
		

CREATE TABLE tbl_pelicula_sucursal (
    id           NUMBER NOT NULL,
    id_pelicula  NUMBER NOT NULL,
    id_sucursal  NUMBER NOT NULL
);

ALTER TABLE tbl_pelicula_sucursal ADD CONSTRAINT tbl_pelicula_sucursal_pk PRIMARY KEY ( id );

ALTER TABLE tbl_pelicula_sucursal
    ADD CONSTRAINT table_10_tbl_pelicula_fk FOREIGN KEY ( id_pelicula )
        REFERENCES tbl_pelicula ( id_pelicula );

ALTER TABLE tbl_pelicula_sucursal
    ADD CONSTRAINT table_10_tbl_sucursal_fk FOREIGN KEY ( id_sucursal )
        REFERENCES tbl_sucursal ( id_sucursal );
		
CREATE TABLE tbl_genero (
    id           NUMBER NOT NULL,
    genero       VARCHAR2 ,
    descripcion  VARCHAR2 

);

ALTER TABLE tbl_genero ADD CONSTRAINT tbl_genero_pk PRIMARY KEY ( id );


CREATE TABLE tbl_genero_pelicula (
    id           NUMBER NOT NULL,
    id_genero    NUMBER NOT NULL,
    id_pelicula  NUMBER NOT NULL
);

ALTER TABLE tbl_genero_pelicula ADD CONSTRAINT tbl_genero_pelicula_pk PRIMARY KEY ( id );


ALTER TABLE tbl_genero_pelicula
    ADD CONSTRAINT tbl_genero_pelicula_tbl_genero_fk FOREIGN KEY ( id_genero )
        REFERENCES tbl_genero ( id );


ALTER TABLE tbl_genero_pelicula
    ADD CONSTRAINT tbl_genero_pelicula_tbl_pelicula_fk FOREIGN KEY ( id_pelicula )
        REFERENCES tbl_pelicula ( id_pelicula );

CREATE TABLE tbl_imagen (
    id_imagen       NUMBER NOT NULL,
    nombre          VARCHAR2 ,
    archivo_imagen  BLOB,
    mime_type       VARCHAR2 

);

ALTER TABLE tbl_imagen ADD CONSTRAINT tbl_imagen_pk PRIMARY KEY ( id_imagen );


CREATE TABLE tbl_reserva (
    id             NUMBER NOT NULL,
    fecha_reserva  TIMESTAMP WITH TIME ZONE,
    estado         VARCHAR2 ,
    id_sala        NUMBER NOT NULL,
    id_cliente     NUMBER NOT NULL
);

COMMENT ON COLUMN tbl_reserva.estado IS
    'RESERVADO, PAGADO, CANCELADO';

ALTER TABLE tbl_reserva ADD CONSTRAINT tbl_reserva_pk PRIMARY KEY ( id );

ALTER TABLE tbl_reserva
    ADD CONSTRAINT tbl_reserva_tbl_clientes_fk FOREIGN KEY ( id_cliente )
        REFERENCES tbl_clientes ( "IDENTIFICACIO " );

ALTER TABLE tbl_reserva
    ADD CONSTRAINT tbl_reserva_tbl_salas_fk FOREIGN KEY ( id_sala )
        REFERENCES tbl_salas ( id );
		

CREATE TABLE tbl_horario_salas (
    id                  NUMBER NOT NULL,
    dia                 VARCHAR2 ,
    hora_inicio         TIMESTAMP,
    hora_fin            TIMESTAMP,
    tiempo_preparacion  NUMBER NOT NULL,
    id_sala             NUMBER NOT NULL
);

ALTER TABLE tbl_horario_salas ADD CONSTRAINT tbl_horario_salas_pk PRIMARY KEY ( id );

ALTER TABLE tbl_horario_salas
    ADD CONSTRAINT tbl_tbl_salas_fk FOREIGN KEY ( id_sala )
        REFERENCES tbl_salas ( id );
		
CREATE TABLE tbl_reserva_silla (
    id          NUMBER NOT NULL,
    id_reserva  NUMBER NOT NULL,
    id_silla    NUMBER NOT NULL
);

ALTER TABLE tbl_reserva_silla ADD CONSTRAINT tbl_reserva_silla_pk PRIMARY KEY ( id );


ALTER TABLE tbl_reserva_silla
    ADD CONSTRAINT tbl_reserva_silla_tbl_reserva_fk FOREIGN KEY ( id_reserva )
        REFERENCES tbl_reserva ( id );


ALTER TABLE tbl_reserva_silla
    ADD CONSTRAINT tbl_reserva_silla_tbl_sillas_fk FOREIGN KEY ( id_silla )
        REFERENCES tbl_sillas ( id_silla );
		
		
CREATE TABLE tbl_agenda_salas (
    id_agenda         NUMBER,
    id_sala           NUMBER NOT NULL,
    id_pelicula       NUMBER NOT NULL,
    fecha_proyeccion  TIMESTAMP WITH TIME ZONE,
    "FECHA_FIN|"      TIMESTAMP WITH TIME ZONE 
--  ERROR: Datatype UNKNOWN is not allowed 

)
    ROW ARCHIVAL;

ALTER TABLE tbl_agenda_salas
    ADD CONSTRAINT tbl_agenda_salas_tbl_pelicula_fk FOREIGN KEY ( id_pelicula )
        REFERENCES tbl_pelicula ( id_pelicula );

ALTER TABLE tbl_agenda_salas
    ADD CONSTRAINT tbl_agenda_salas_tbl_salas_fk FOREIGN KEY ( id_sala )
        REFERENCES tbl_salas ( id );
		
CREATE TABLE tbl_clientes (
    "IDENTIFICACIO "  NUMBER NOT NULL,
    nombre            VARCHAR2 ,
    id_tipocliente    NUMBER NOT NULL
);

ALTER TABLE tbl_clientes ADD CONSTRAINT tbl_clientes_pk PRIMARY KEY ( "IDENTIFICACIO " );


ALTER TABLE tbl_clientes
    ADD CONSTRAINT tbl_clientes_tbl_tipo_cliente_fk FOREIGN KEY ( id_tipocliente )
        REFERENCES tbl_tipo_cliente ( id );
		
CREATE TABLE tbl_tipo_cliente (
    id              NUMBER NOT NULL,
    "TIPO CLIENTE"  VARCHAR2 ,
    descripcion     VARCHAR2 

);

ALTER TABLE tbl_tipo_cliente ADD CONSTRAINT tbl_tipo_cliente_pk PRIMARY KEY ( id );
		




