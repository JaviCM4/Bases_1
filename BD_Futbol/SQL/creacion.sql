-- Creación de Tablas para Base de Datos de Fútbol

-- (2) Estado_registro
CREATE TABLE Estado_registro (
    id NUMBER(1) PRIMARY KEY,
    nombre VARCHAR2(50)
);

-- (34) Tipo_tarjeta
CREATE TABLE Tipo_tarjeta (
    id NUMBER(1) PRIMARY KEY,
    nombre VARCHAR2(25)
);

-- (9) Pais
CREATE TABLE Pais (
    id NUMBER(3) PRIMARY KEY,
    nombre VARCHAR2(50),
    alpha_dos VARCHAR2(50),
    alpha_tres VARCHAR2(50)
);

-- (10) Pie_dominante
CREATE TABLE Pie_dominante (
    id NUMBER(1) PRIMARY KEY,
    nombre VARCHAR2(25)
);

-- (15) Tipo_cuerpo_tecnico
CREATE TABLE Tipo_cuerpo_tecnico (
    id NUMBER(1) PRIMARY KEY,
    nombre VARCHAR2(50)
);

-- (17) Estado_Temporada
CREATE TABLE Estado_Temporada (
    id NUMBER(1) PRIMARY KEY,
    nombre VARCHAR2(50)
);

-- (22) Resultado
CREATE TABLE Resultado (
    id NUMBER(1) PRIMARY KEY,
    nombre VARCHAR2(25)
);

-- (23) Tactica
CREATE TABLE Tactica (
    id NUMBER(2) PRIMARY KEY,
    nombre VARCHAR2(50)
);

-- (24) Tipo_arbitro
CREATE TABLE Tipo_arbitro (
    id NUMBER(1) PRIMARY KEY,
    nombre VARCHAR2(50)
);

-- (29) Titular
CREATE TABLE Titular (
    id NUMBER(1) PRIMARY KEY,
    nombre VARCHAR2(25)
);

-- (35) Tipo_accion
CREATE TABLE Tipo_accion (
    id NUMBER(2) PRIMARY KEY,
    nombre VARCHAR2(50)
);

-- (37) Tipo_sustitucion
CREATE TABLE Tipo_sustitucion (
    id NUMBER(1) PRIMARY KEY,
    nombre VARCHAR2(25)
);

-- (6) Nivel_falta
CREATE TABLE Nivel_falta (
    id NUMBER(1) PRIMARY KEY,
    nombre VARCHAR2(50)
);

-- (8) Posicion
CREATE TABLE Posicion (
    id NUMBER(2) PRIMARY KEY,
    nombre VARCHAR2(50),
    code_dos VARCHAR2(50),
    code_tres VARCHAR2(50)
);

-- (14) Tipo_equipo
CREATE TABLE Tipo_equipo (
    id NUMBER(1) PRIMARY KEY,
    nombre VARCHAR2(50)
);

-- (20) Profesor
CREATE TABLE Profesor (
    id NUMBER(7) PRIMARY KEY,
    id_pais NUMBER(3),
    primer_nombre VARCHAR2(50),
    segundo_nombre VARCHAR2(50),
    apellido VARCHAR2(75),
    fecha_nacimiento DATE,
    FOREIGN KEY (id_pais) REFERENCES Pais(id)
);

-- (3) Persona
CREATE TABLE Persona (
    id NUMBER(7) PRIMARY KEY,
    id_pais_pasaporte NUMBER(7),
    id_pais NUMBER(3),
    primer_nombre VARCHAR2(50),
    segundo_nombre VARCHAR2(50),
    apellido VARCHAR2(50),
    altura NUMBER(4),
    peso NUMBER(4),
    fecha_nacimiento DATE,
    FOREIGN KEY (id_pais_pasaporte) REFERENCES Pais(id),
    FOREIGN KEY (id_pais) REFERENCES Pais(id)
);

-- (28) Arbitro
CREATE TABLE Arbitro (
    id NUMBER(7) PRIMARY KEY,
    id_pais NUMBER(3),
    primer_nombre VARCHAR2(50),
    segundo_nombre VARCHAR2(50),
    apellido VARCHAR2(75),
    fecha_nacimiento DATE,
    FOREIGN KEY (id_pais) REFERENCES Pais(id)
);

-- (11) Liga
CREATE TABLE Liga (
    id NUMBER(3) PRIMARY KEY,
    id_pais NUMBER(3),
    nombre VARCHAR2(75),
    FOREIGN KEY (id_pais) REFERENCES Pais(id)
);

-- (16) Temporada
CREATE TABLE Temporada (
    id NUMBER(7) PRIMARY KEY,
    id_liga NUMBER(3),
    id_estado_temporada NUMBER(1),
    año NUMBER(4),
    FOREIGN KEY (id_liga) REFERENCES Liga(id),
    FOREIGN KEY (id_estado_temporada) REFERENCES Estado_Temporada(id)
);

-- (13) Equipo
CREATE TABLE Equipo (
    id NUMBER(7) PRIMARY KEY,
    id_tipo_equipo NUMBER(1),
    nombre VARCHAR2(50),
    nombre_oficial VARCHAR2(75),
    ciudad VARCHAR2(75),
    FOREIGN KEY (id_tipo_equipo) REFERENCES Tipo_equipo(id)
);

-- (12) Estadio
CREATE TABLE Estadio (
    id NUMBER(7) PRIMARY KEY,
    id_equipo NUMBER(7),
    nombre VARCHAR2(75),
    capacidad NUMBER(5),
    direccion VARCHAR2(75),
    cuidad VARCHAR2(75),
    FOREIGN KEY (id_equipo) REFERENCES Equipo(id)
);

-- (7) Jugador
CREATE TABLE Jugador (
    id NUMBER(7) PRIMARY KEY,
    id_persona NUMBER(7),
    id_equipo NUMBER(7),
    id_posicion NUMBER(2),
    id_pie_dominante NUMBER(1),
    nombre_camiseta VARCHAR2(50),
    dorsal NUMBER(2),
    FOREIGN KEY (id_persona) REFERENCES Persona(id),
    FOREIGN KEY (id_equipo) REFERENCES Equipo(id),
    FOREIGN KEY (id_posicion) REFERENCES Posicion(id),
    FOREIGN KEY (id_pie_dominante) REFERENCES Pie_dominante(id)
);

-- (19) Cuerpo_tecnico
CREATE TABLE Cuerpo_tecnico (
    id NUMBER(7) PRIMARY KEY,
    id_equipo NUMBER(7),
    id_profesor NUMBER(7),
    id_tipo_cuerpo_tecnico NUMBER(1),
    fecha_inicio DATE,
    fecha_final DATE,
    FOREIGN KEY (id_equipo) REFERENCES Equipo(id),
    FOREIGN KEY (id_profesor) REFERENCES Profesor(id),
    FOREIGN KEY (id_tipo_cuerpo_tecnico) REFERENCES Tipo_cuerpo_tecnico(id)
);

-- (1) Lesion
CREATE TABLE Lesion (
    id NUMBER(7) PRIMARY KEY,
    id_jugador NUMBER(7),
    id_estado_registro NUMBER(1),
    cuadro VARCHAR2(50),
    descripcion VARCHAR2(250),
    tratamiento VARCHAR2(150),
    fecha_lesion DATE,
    fecha_recuperacion DATE,
    FOREIGN KEY (id_jugador) REFERENCES Jugador(id),
    FOREIGN KEY (id_estado_registro) REFERENCES Estado_registro(id)
);

-- (5) Falta
CREATE TABLE Falta (
    id NUMBER(7) PRIMARY KEY,
    id_jugador NUMBER(7),
    id_nivel_falta NUMBER(1),
    motivo VARCHAR2(50),
    descripcion VARCHAR2(250),
    FOREIGN KEY (id_jugador) REFERENCES Jugador(id),
    FOREIGN KEY (id_nivel_falta) REFERENCES Nivel_falta(id)
);

-- (26) Partido
CREATE TABLE Partido (
    id NUMBER(7) PRIMARY KEY,
    id_temporada NUMBER(7),
    id_estadio NUMBER(7),
    fecha DATE,
    hora VARCHAR2(25),
    FOREIGN KEY (id_temporada) REFERENCES Temporada(id),
    FOREIGN KEY (id_estadio) REFERENCES Estadio(id)
);

-- (18) Tabla_posicion
CREATE TABLE Tabla_posicion (
    id NUMBER(7) PRIMARY KEY,
    id_temporada NUMBER(7),
    id_equipo NUMBER(7),
    juegos NUMBER(3),
    ganados NUMBER(3),
    empates NUMBER(3),
    derrotas NUMBER(3),
    goles_favor NUMBER(3),
    goles_contra NUMBER(3),
    a_cero NUMBER(3),
    FOREIGN KEY (id_temporada) REFERENCES Temporada(id),
    FOREIGN KEY (id_equipo) REFERENCES Equipo(id)
);

-- (27) Convocado
CREATE TABLE Convocado (
    id NUMBER(7) PRIMARY KEY,
    id_partido NUMBER(7),
    id_jugador NUMBER(7),
    id_titular NUMBER(1),
    minutos NUMBER(3),
    FOREIGN KEY (id_partido) REFERENCES Partido(id),
    FOREIGN KEY (id_jugador) REFERENCES Jugador(id),
    FOREIGN KEY (id_titular) REFERENCES Titular(id)
);

-- (31) Accion
CREATE TABLE Accion (
    id NUMBER(7) PRIMARY KEY,
    id_partido NUMBER(7),
    id_convocado NUMBER(7),
    id_tipo_accion NUMBER(2),
    minuto NUMBER(3),
    FOREIGN KEY (id_partido) REFERENCES Partido(id),
    FOREIGN KEY (id_convocado) REFERENCES Convocado(id),
    FOREIGN KEY (id_tipo_accion) REFERENCES Tipo_accion(id)
);

-- (25) Asignacion_arbitro
CREATE TABLE Asignacion_arbitro (
    id NUMBER(7) PRIMARY KEY,
    id_partido NUMBER(7),
    id_arbitro NUMBER(7),
    id_tipo_arbitro NUMBER(1),
    FOREIGN KEY (id_partido) REFERENCES Partido(id),
    FOREIGN KEY (id_arbitro) REFERENCES Arbitro(id),
    FOREIGN KEY (id_tipo_arbitro) REFERENCES Tipo_arbitro(id)
);

-- (21) Equipo_participante
CREATE TABLE Equipo_participante (
    id NUMBER(7) PRIMARY KEY,
    id_partido NUMBER(7),
    id_equipo NUMBER(7),
    id_tactica NUMBER(2),
    id_resultado NUMBER(1),
    posesion NUMBER(3),
    FOREIGN KEY (id_partido) REFERENCES Partido(id),
    FOREIGN KEY (id_equipo) REFERENCES Equipo(id),
    FOREIGN KEY (id_tactica) REFERENCES Tactica(id),
    FOREIGN KEY (id_resultado) REFERENCES Resultado(id)
);

-- (32) Coordenada_cancha
CREATE TABLE Coordenada_cancha (
    id NUMBER(7) PRIMARY KEY,
    id_accion NUMBER(7),
    eje_x NUMBER(3),
    eje_y NUMBER(3),
    FOREIGN KEY (id_accion) REFERENCES Accion(id)
);

-- (33) Tarjeta
CREATE TABLE Tarjeta (
    id NUMBER(7) PRIMARY KEY,
    id_accion NUMBER(7),
    id_tipo_tarjeta NUMBER(1),
    FOREIGN KEY (id_accion) REFERENCES Accion(id),
    FOREIGN KEY (id_tipo_tarjeta) REFERENCES Tipo_tarjeta(id)
);

-- (36) Sustitucion
CREATE TABLE Sustitucion (
    id NUMBER(7) PRIMARY KEY,
    id_accion NUMBER(7),
    id_tipo_sustitucion NUMBER(1),
    FOREIGN KEY (id_accion) REFERENCES Accion(id),
    FOREIGN KEY (id_tipo_sustitucion) REFERENCES Tipo_sustitucion(id)
);

-- (38) Coordenada_arco
CREATE TABLE Coordenada_arco (
    id NUMBER(7) PRIMARY KEY,
    id_accion NUMBER(7),
    eje_x NUMBER(3),
    eje_y NUMBER(3),
    FOREIGN KEY (id_accion) REFERENCES Accion(id)
);

-- (30) Asistencia
CREATE TABLE Asistencia (
    id NUMBER(7) PRIMARY KEY,
    id_accion NUMBER(7),
    id_accion_anotacion NUMBER(7),
    FOREIGN KEY (id_accion) REFERENCES Accion(id),
    FOREIGN KEY (id_accion_anotacion) REFERENCES Accion(id)
);