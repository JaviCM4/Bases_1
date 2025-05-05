/*
(CREACIÓN DE LA BASE DE DATOS)
    A continuación encontrará el script SQL para la creación de la base de datos, priorizando
    la creación, primero de las tablas independientes y luego de las tablas dependientes.
*/
CREATE TABLE Estado_Civil (
    id NUMBER(2) PRIMARY KEY,
    nombre VARCHAR2(100) NOT NULL
);

CREATE TABLE Region (
    id NUMBER(2) PRIMARY KEY,
    nombre VARCHAR2(100) NOT NULL
);

CREATE TABLE Religion (
    id NUMBER(2) PRIMARY KEY,
    nombre VARCHAR2(100) NOT NULL
);

CREATE TABLE Grupo_Etnico (
    id NUMBER(2) PRIMARY KEY,
    nombre VARCHAR2(100) NOT NULL
);

CREATE TABLE Pais (
    id NUMBER(3) PRIMARY KEY,
    nombre VARCHAR2(100) NOT NULL
);

CREATE TABLE Departamento (
    id NUMBER(2) PRIMARY KEY,
    id_pais NUMBER(3) NOT NULL,
    id_region NUMBER(2) NOT NULL,
    nombre VARCHAR2(100) NOT NULL,
    CONSTRAINT fk_departamento_pais FOREIGN KEY (id_pais) REFERENCES Pais(id),
    CONSTRAINT fk_departamento_region FOREIGN KEY (id_region) REFERENCES Region(id)
);

CREATE TABLE Nivel_Escolaridad (
    id NUMBER(2) PRIMARY KEY,
    nombre VARCHAR2(100) NOT NULL
);

CREATE TABLE Area_Geografica (
    id NUMBER(2) PRIMARY KEY,
    nombre VARCHAR2(100) NOT NULL
);

CREATE TABLE Tipo_Perito (
    id NUMBER(2) PRIMARY KEY,
    nombre VARCHAR2(100) NOT NULL
);

CREATE TABLE Municipio (
    id NUMBER(3) PRIMARY KEY,
    id_departamento NUMBER(2) NOT NULL,
    nombre VARCHAR2(100) NOT NULL,
    CONSTRAINT fk_municipio_departamento FOREIGN KEY (id_departamento) REFERENCES Departamento(id)
);

CREATE TABLE Sexo (
    id NUMBER(2) PRIMARY KEY,
    nombre VARCHAR2(100) NOT NULL
);

CREATE TABLE Condicion_Alfabetismo (
    id NUMBER(1) PRIMARY KEY,
    nombre VARCHAR2(100) NOT NULL
);

CREATE TABLE Tipo_Causa (
    id NUMBER(3) PRIMARY KEY,
    nombre VARCHAR2(100) NOT NULL
);

CREATE TABLE Sector_Economico (
    id NUMBER(2) PRIMARY KEY,
    nombre VARCHAR2(100) NOT NULL
);

CREATE TABLE Tipo_Evaluacion (
    id NUMBER(2) PRIMARY KEY,
    nombre VARCHAR2(100) NOT NULL
);

CREATE TABLE Tipo_Transtorno (
    id NUMBER(3) PRIMARY KEY,
    nombre VARCHAR2(100) NOT NULL
);

CREATE TABLE Tipo_Trabajo (
    id NUMBER(4) PRIMARY KEY,
    nombre VARCHAR2(100) NOT NULL
);

CREATE TABLE Estado_Persona (
    id NUMBER(2) PRIMARY KEY,
    nombre VARCHAR2(100) NOT NULL
);

CREATE TABLE Persona (
    id NUMBER(7) PRIMARY KEY,
    id_estado_persona NUMBER(2) NOT NULL,
    cui VARCHAR2(20),
    primer_nombre VARCHAR2(100) NOT NULL,
    segundo_nombre VARCHAR2(100),
    primer_apellido VARCHAR2(100) NOT NULL,
    segundo_apellido VARCHAR2(100),
    fecha_nacimiento DATE,
    CONSTRAINT fk_persona_estado FOREIGN KEY (id_estado_persona) REFERENCES Estado_Persona(id)
);

CREATE TABLE Tipo_Familia (
    id NUMBER(2) PRIMARY KEY,
    nombre VARCHAR2(100) NOT NULL
);

CREATE TABLE Estado_Registro (
    id NUMBER(2) PRIMARY KEY,
    nombre VARCHAR2(100) NOT NULL
);

CREATE TABLE Tipo_Cuadro (
    id NUMBER(3) PRIMARY KEY,
    nombre VARCHAR2(100) NOT NULL
);

CREATE TABLE Moneda (
    id NUMBER(3) PRIMARY KEY,
    id_pais NUMBER(3) NOT NULL,
    codigo VARCHAR2(3) NOT NULL,
    nombre VARCHAR2(100) NOT NULL,
    CONSTRAINT fk_pais_moneda FOREIGN KEY (id_pais) REFERENCES Pais(id)
);

CREATE TABLE Tipo_Ingreso (
    id NUMBER(1) PRIMARY KEY,
    nombre VARCHAR2(100) NOT NULL
);

CREATE TABLE Tipo_Implicado (
    id NUMBER(2) PRIMARY KEY,
    nombre VARCHAR2(100) NOT NULL
);

CREATE TABLE Idioma (
    id NUMBER(3) PRIMARY KEY,
    id_pais NUMBER(3) NOT NULL,
    nombre VARCHAR2(100) NOT NULL,
    CONSTRAINT fk_pais_idioma FOREIGN KEY (id_pais) REFERENCES Pais(id)
);

CREATE TABLE Tipo_Evento (
    id NUMBER(2) PRIMARY KEY,
    nombre VARCHAR2(100) NOT NULL
);

CREATE TABLE Tipo_Institucion (
    id NUMBER(2) PRIMARY KEY,
    nombre VARCHAR2(100) NOT NULL
);

CREATE TABLE Tipo_Agente (
    id NUMBER(2) PRIMARY KEY,
    nombre VARCHAR2(100) NOT NULL
);

CREATE TABLE Tipo_Prueba (
    id NUMBER(2) PRIMARY KEY,
    nombre VARCHAR2(100) NOT NULL
);

CREATE TABLE Dia_Semana (
    id NUMBER(1) PRIMARY KEY,
    nombre VARCHAR2(20) NOT NULL
);

CREATE TABLE Tipo_Contacto (
    id NUMBER(2) PRIMARY KEY,
    nombre VARCHAR2(100) NOT NULL
);

CREATE TABLE Tipo_Entidad (
    id NUMBER(2) PRIMARY KEY,
    nombre VARCHAR2(100) NOT NULL
);

CREATE TABLE Estado_Agente (
    id NUMBER(2) PRIMARY KEY,
    nombre VARCHAR2(100) NOT NULL
);

CREATE TABLE Agente (
    id NUMBER(7) PRIMARY KEY,
    cui VARCHAR2(20),
    primer_nombre VARCHAR2(100) NOT NULL,
    segundo_nombre VARCHAR2(100),
    primer_apellido VARCHAR2(100) NOT NULL,
    segundo_apellido VARCHAR2(100),
    fecha_nacimiento DATE
);

CREATE TABLE Tipo_Designacion (
    id NUMBER(2) PRIMARY KEY,
    nombre VARCHAR2(100) NOT NULL
);

CREATE TABLE Estado_Denuncia (
    id NUMBER(2) PRIMARY KEY,
    nombre VARCHAR2(100) NOT NULL
);

CREATE TABLE Tipo_Denuncia (
    id NUMBER(3) PRIMARY KEY,
    nombre VARCHAR2(150) NOT NULL
);

CREATE TABLE Mes (
    id NUMBER(2) PRIMARY KEY,
    nombre VARCHAR2(20) NOT NULL
);

CREATE TABLE Tipo_Lugar (
    id NUMBER(2) PRIMARY KEY,
    nombre VARCHAR2(100) NOT NULL
);

CREATE TABLE Estado_Proceso (
    id NUMBER(2) PRIMARY KEY,
    nombre VARCHAR2(100) NOT NULL
);

CREATE TABLE Tipo_Juez (
    id NUMBER(2) PRIMARY KEY,
    nombre VARCHAR2(100) NOT NULL
);

CREATE TABLE Estado_Sentencia (
    id NUMBER(2) PRIMARY KEY,
    nombre VARCHAR2(100) NOT NULL
);

CREATE TABLE Tipo_Sentencia (
    id NUMBER(3) PRIMARY KEY,
    nombre VARCHAR2(100) NOT NULL
);

CREATE TABLE Estado_Audiencia (
    id NUMBER(2) PRIMARY KEY,
    nombre VARCHAR2(100) NOT NULL
);

CREATE TABLE Tipo_Audiencia (
    id NUMBER(2) PRIMARY KEY,
    nombre VARCHAR2(100) NOT NULL
);

CREATE TABLE Tipo_Abogado (
    id NUMBER(2) PRIMARY KEY,
    nombre VARCHAR2(100) NOT NULL
);

CREATE TABLE Tipo_Documento (
    id NUMBER(3) PRIMARY KEY,
    nombre VARCHAR2(100) NOT NULL
);

CREATE TABLE Emisor (
    id NUMBER(2) PRIMARY KEY,
    nombre VARCHAR2(100) NOT NULL
);

CREATE TABLE Perito (
    id NUMBER(7) PRIMARY KEY,
    id_tipo_perito NUMBER(2) NOT NULL,
    no_colegiado VARCHAR2(20),
    cui VARCHAR2(20),
    primer_nombre VARCHAR2(100) NOT NULL,
    segundo_nombre VARCHAR2(100),
    primer_apellido VARCHAR2(100) NOT NULL,
    segundo_apellido VARCHAR2(100),
    CONSTRAINT fk_perito_tipo_perito FOREIGN KEY (id_tipo_perito) REFERENCES Tipo_Perito(id)
);

CREATE TABLE Institucion (
    id NUMBER(6) PRIMARY KEY,
    id_tipo_institucion NUMBER(2) NOT NULL,
    nombre_oficial VARCHAR2(200) NOT NULL,
    CONSTRAINT fk_institucion_tipo FOREIGN KEY (id_tipo_institucion) REFERENCES Tipo_Institucion(id)
);

CREATE TABLE Horario_Atencion (
    id NUMBER(6) PRIMARY KEY,
    id_institucion NUMBER(6) NOT NULL,
    id_dia_semana NUMBER(1) NOT NULL,
    horario VARCHAR2(100) NOT NULL,
    CONSTRAINT fk_horario_institucion FOREIGN KEY (id_institucion) REFERENCES Institucion(id),
    CONSTRAINT fk_horario_dia_semana FOREIGN KEY (id_dia_semana) REFERENCES Dia_Semana(id)
);

CREATE TABLE Denuncia (
    id NUMBER(7) PRIMARY KEY,
    id_institucion NUMBER(6) NOT NULL,
    id_estado_denuncia NUMBER(2) NOT NULL,
    descripcion VARCHAR2(1000),
    CONSTRAINT fk_denuncia_institucion FOREIGN KEY (id_institucion) REFERENCES Institucion(id),
    CONSTRAINT fk_denuncia_estado FOREIGN KEY (id_estado_denuncia) REFERENCES Estado_Denuncia(id)
);

CREATE TABLE Perfil_Sociodemografico (
    id NUMBER(7) PRIMARY KEY,
    id_persona NUMBER(7) NOT NULL,
    id_municipio_nacimiento NUMBER(3) NOT NULL,
    id_sexo NUMBER(2) NOT NULL,
    id_estado_civil NUMBER(2) NOT NULL,
    id_nivel_escolaridad NUMBER(2) NOT NULL,
    id_religion NUMBER(2) NOT NULL,
    id_grupo_etnico NUMBER(2) NOT NULL,
    id_area_geografica NUMBER(2) NOT NULL,
    id_condicion_alfabetismo NUMBER(1) NOT NULL,
    CONSTRAINT fk_perfil_persona FOREIGN KEY (id_persona) REFERENCES Persona(id),
    CONSTRAINT fk_perfil_municipio FOREIGN KEY (id_municipio_nacimiento) REFERENCES Municipio(id),
    CONSTRAINT fk_perfil_sexo FOREIGN KEY (id_sexo) REFERENCES Sexo(id),
    CONSTRAINT fk_perfil_estado_civil FOREIGN KEY (id_estado_civil) REFERENCES Estado_Civil(id),
    CONSTRAINT fk_perfil_escolaridad FOREIGN KEY (id_nivel_escolaridad) REFERENCES Nivel_Escolaridad(id),
    CONSTRAINT fk_perfil_religion FOREIGN KEY (id_religion) REFERENCES Religion(id),
    CONSTRAINT fk_perfil_grupo_etnico FOREIGN KEY (id_grupo_etnico) REFERENCES Grupo_Etnico(id),
    CONSTRAINT fk_perfil_area_geografica FOREIGN KEY (id_area_geografica) REFERENCES Area_Geografica(id),
    CONSTRAINT fk_perfil_alfabetismo FOREIGN KEY (id_condicion_alfabetismo) REFERENCES Condicion_Alfabetismo(id)
);

CREATE TABLE Ingreso (
    id NUMBER(7) PRIMARY KEY,
    id_moneda NUMBER(3) NOT NULL,
    id_tipo_ingreso NUMBER(1) NOT NULL,
    salario_mensual NUMBER(10,2),
    CONSTRAINT fk_ingreso_moneda FOREIGN KEY (id_moneda) REFERENCES Moneda(id),
    CONSTRAINT fk_ingreso_tipo FOREIGN KEY (id_tipo_ingreso) REFERENCES Tipo_Ingreso(id)
);

CREATE TABLE Trabajo (
    id NUMBER(7) PRIMARY KEY,
    id_perfil_sociodemografico NUMBER(7) NOT NULL,
    id_tipo_trabajo NUMBER(3) NOT NULL,
    id_ingreso NUMBER(7) NOT NULL,
    id_sector_economico NUMBER(2) NOT NULL,
    nombre_empresa VARCHAR2(200),
    CONSTRAINT fk_trabajo_perfil FOREIGN KEY (id_perfil_sociodemografico) REFERENCES Perfil_Sociodemografico(id),
    CONSTRAINT fk_trabajo_profesion FOREIGN KEY (id_tipo_trabajo) REFERENCES Tipo_Trabajo(id),
    CONSTRAINT fk_trabajo_ingreso FOREIGN KEY (id_ingreso) REFERENCES Ingreso(id),
    CONSTRAINT fk_trabajo_sector FOREIGN KEY (id_sector_economico) REFERENCES Sector_Economico(id)
);

CREATE TABLE Evaluacion (
    id NUMBER(7) PRIMARY KEY,
    id_persona NUMBER(7) NOT NULL,
    id_tipo_evaluacion NUMBER(2) NOT NULL,
    id_perito NUMBER(7) NOT NULL,
    fecha DATE,
    CONSTRAINT fk_evaluacion_persona FOREIGN KEY (id_persona) REFERENCES Persona(id),
    CONSTRAINT fk_evaluacion_tipo FOREIGN KEY (id_tipo_evaluacion) REFERENCES Tipo_Evaluacion(id),
    CONSTRAINT fk_evaluacion_perito FOREIGN KEY (id_perito) REFERENCES Perito(id)
);

CREATE TABLE Registro_Necropsia (
    id NUMBER(7) PRIMARY KEY,
    id_evaluacion NUMBER(7) NOT NULL,
    id_tipo_causa NUMBER(3) NOT NULL,
    descripcion VARCHAR2(1000),
    CONSTRAINT fk_necropsia_evaluacion FOREIGN KEY (id_evaluacion) REFERENCES Evaluacion(id),
    CONSTRAINT fk_necropsia_tipo_causa FOREIGN KEY (id_tipo_causa) REFERENCES Tipo_Causa(id)
);

CREATE TABLE Registro_Psicologico (
    id NUMBER(7) PRIMARY KEY,
    id_evaluacion NUMBER(7) NOT NULL,
    id_tipo_trastorno NUMBER(3) NOT NULL,
    descripcion VARCHAR2(1000),
    tratamiento VARCHAR2(1000),
    CONSTRAINT fk_psicologico_evaluacion FOREIGN KEY (id_evaluacion) REFERENCES Evaluacion(id),
    CONSTRAINT fk_psicologico_trastorno FOREIGN KEY (id_tipo_trastorno) REFERENCES Tipo_Transtorno(id)
);

CREATE TABLE Registro_Medico (
    id NUMBER(7) PRIMARY KEY,
    id_evaluacion NUMBER(7) NOT NULL,
    id_estado_registro NUMBER(2) NOT NULL,
    id_tipo_cuadro NUMBER(3) NOT NULL,
    descripcion VARCHAR2(1000),
    tratamiento VARCHAR2(1000),
    CONSTRAINT fk_medico_evaluacion FOREIGN KEY (id_evaluacion) REFERENCES Evaluacion(id),
    CONSTRAINT fk_medico_estado FOREIGN KEY (id_estado_registro) REFERENCES Estado_Registro(id),
    CONSTRAINT fk_medico_cuadro FOREIGN KEY (id_tipo_cuadro) REFERENCES Tipo_Cuadro(id)
);

CREATE TABLE Implicado (
    id NUMBER(7) PRIMARY KEY,
    id_denuncia NUMBER(7) NOT NULL,
    id_persona NUMBER(7) NOT NULL,
    id_tipo_implicado NUMBER(2) NOT NULL,
    id_tipo_denuncia NUMBER(3) NOT NULL,
    CONSTRAINT fk_implicado_denuncia FOREIGN KEY (id_denuncia) REFERENCES Denuncia(id),
    CONSTRAINT fk_implicado_persona FOREIGN KEY (id_persona) REFERENCES Persona(id),
    CONSTRAINT fk_implicado_tipo_implicado FOREIGN KEY (id_tipo_implicado) REFERENCES Tipo_Implicado(id),
    CONSTRAINT fk_implicado_tipo_denuncia FOREIGN KEY (id_tipo_denuncia) REFERENCES Tipo_Denuncia(id)
);

CREATE TABLE Persona_Idioma (
    id NUMBER(7) PRIMARY KEY,
    id_perfil_sociodemografico NUMBER(7) NOT NULL,
    id_idioma NUMBER(3) NOT NULL,
    CONSTRAINT fk_pers_idioma_perfil FOREIGN KEY (id_perfil_sociodemografico) REFERENCES Perfil_Sociodemografico(id),
    CONSTRAINT fk_pers_idioma_idioma FOREIGN KEY (id_idioma) REFERENCES Idioma(id)
);

CREATE TABLE Familia (
    id NUMBER(7) PRIMARY KEY,
    id_tipo_familia NUMBER(2) NOT NULL,
    id_persona NUMBER(7) NOT NULL,
    id_persona_relacion NUMBER(7) NOT NULL,
    CONSTRAINT fk_familia_tipo FOREIGN KEY (id_tipo_familia) REFERENCES Tipo_Familia(id),
    CONSTRAINT fk_familia_persona FOREIGN KEY (id_persona) REFERENCES Persona(id),
    CONSTRAINT fk_familia_persona_rel FOREIGN KEY (id_persona_relacion) REFERENCES Persona(id)
);

CREATE TABLE Evento_Fecha (
    id NUMBER(7) PRIMARY KEY,
    id_denuncia NUMBER(7) NOT NULL,
    id_tipo_evento NUMBER(2) NOT NULL,
    id_mes NUMBER(2) NOT NULL,
    id_dia_semana NUMBER(1) NOT NULL,
    dia_numero NUMBER(2),
    anio NUMBER(4),
    hora NUMBER(2),
    CONSTRAINT fk_evento_denuncia FOREIGN KEY (id_denuncia) REFERENCES Denuncia(id),
    CONSTRAINT fk_evento_tipo FOREIGN KEY (id_tipo_evento) REFERENCES Tipo_Evento(id),
    CONSTRAINT fk_evento_dia FOREIGN KEY (id_dia_semana) REFERENCES Dia_Semana(id),
    CONSTRAINT fk_evento_mes FOREIGN KEY (id_mes) REFERENCES Mes(id)
);

CREATE TABLE Prueba (
    id NUMBER(7) PRIMARY KEY,
    id_denuncia NUMBER(7) NOT NULL,
    id_tipo_prueba NUMBER(2) NOT NULL,
    descripcion VARCHAR2(1000),
    fecha DATE,
    CONSTRAINT fk_prueba_denuncia FOREIGN KEY (id_denuncia) REFERENCES Denuncia(id),
    CONSTRAINT fk_prueba_tipo FOREIGN KEY (id_tipo_prueba) REFERENCES Tipo_Prueba(id)
);

CREATE TABLE Contacto (
    id NUMBER(7) PRIMARY KEY,
    id_tipo_entidad NUMBER(2) NOT NULL,
    id_tipo_contacto NUMBER(2) NOT NULL,
    id_entidad NUMBER(7) NOT NULL,
    informacion VARCHAR2(200) NOT NULL,
    CONSTRAINT fk_contacto_tipo_entidad FOREIGN KEY (id_tipo_entidad) REFERENCES Tipo_Entidad(id),
    CONSTRAINT fk_contacto_tipo_contacto FOREIGN KEY (id_tipo_contacto) REFERENCES Tipo_Contacto(id)
);

CREATE TABLE Direccion (
    id NUMBER(7) PRIMARY KEY,
    id_tipo_entidad NUMBER(2) NOT NULL,
    id_municipio NUMBER(3) NOT NULL,
    id_tipo_lugar NUMBER(2) NOT NULL,
    id_entidad NUMBER(7) NOT NULL,
    descripcion VARCHAR2(1000),
    ubicacion VARCHAR2(200),
    CONSTRAINT fk_direccion_tipo_entidad FOREIGN KEY (id_tipo_entidad) REFERENCES Tipo_Entidad(id),
    CONSTRAINT fk_direccion_municipio FOREIGN KEY (id_municipio) REFERENCES Municipio(id),
    CONSTRAINT fk_direccion_lugar FOREIGN KEY (id_tipo_lugar) REFERENCES Tipo_Lugar(id)
);

CREATE TABLE Perfil_Agente (
    id NUMBER(7) PRIMARY KEY,
    id_agente NUMBER(7) NOT NULL,
    id_institucion NUMBER(6) NOT NULL,
    id_tipo_agente NUMBER(2) NOT NULL,
    id_estado_agente NUMBER(2) NOT NULL,
    CONSTRAINT fk_perf_agente_agente FOREIGN KEY (id_agente) REFERENCES Agente(id),
    CONSTRAINT fk_perf_agente_institucion FOREIGN KEY (id_institucion) REFERENCES Institucion(id),
    CONSTRAINT fk_perf_agente_cargo FOREIGN KEY (id_tipo_agente) REFERENCES Tipo_Agente(id),
    CONSTRAINT fk_perf_agente_estado FOREIGN KEY (id_estado_agente) REFERENCES Estado_Agente(id)
);

CREATE TABLE Agente_Designado (
    id NUMBER(7) PRIMARY KEY,
    id_tipo_designacion NUMBER(2) NOT NULL,
    id_agente NUMBER(7) NOT NULL,
    id_evento NUMBER(7) NOT NULL,
    CONSTRAINT fk_desig_agente_tipo FOREIGN KEY (id_tipo_designacion) REFERENCES Tipo_Designacion(id),
    CONSTRAINT fk_desig_agente_agente FOREIGN KEY (id_agente) REFERENCES Agente(id)
);

CREATE TABLE Proceso_Judicial (
    id NUMBER(7) PRIMARY KEY,
    id_denuncia NUMBER(7) NOT NULL,
    id_institucion NUMBER(6) NOT NULL,
    id_estado_proceso NUMBER(2) NOT NULL,
    CONSTRAINT fk_proceso_denuncia FOREIGN KEY (id_denuncia) REFERENCES Denuncia(id),
    CONSTRAINT fk_proceso_institucion FOREIGN KEY (id_institucion) REFERENCES Institucion(id),
    CONSTRAINT fk_proceso_estado FOREIGN KEY (id_estado_proceso) REFERENCES Estado_Proceso(id)
);

CREATE TABLE Juez (
    id NUMBER(7) PRIMARY KEY,
    cui VARCHAR2(20),
    no_colegiado VARCHAR2(20),
    primer_nombre VARCHAR2(100) NOT NULL,
    segundo_nombre VARCHAR2(100),
    primer_apellido VARCHAR2(100) NOT NULL,
    segundo_apellido VARCHAR2(100),
    fecha_nacimiento DATE
);

CREATE TABLE Testigo (
    id NUMBER(7) PRIMARY KEY,
    cui VARCHAR2(20),
    primer_nombre VARCHAR2(100) NOT NULL,
    segundo_nombre VARCHAR2(100),
    primer_apellido VARCHAR2(100) NOT NULL,
    segundo_apellido VARCHAR2(100),
    fecha_nacimiento DATE
);

CREATE TABLE Abogado (
    id NUMBER(7) PRIMARY KEY,
    cui VARCHAR2(20),
    no_colegiado VARCHAR2(20),
    primer_nombre VARCHAR2(100) NOT NULL,
    segundo_nombre VARCHAR2(100),
    primer_apellido VARCHAR2(100) NOT NULL,
    segundo_apellido VARCHAR2(100),
    fecha_nacimiento DATE
);

CREATE TABLE Audiencia (
    id NUMBER(7) PRIMARY KEY,
    id_proceso_judicial NUMBER(7) NOT NULL,
    id_tipo_audiencia NUMBER(2) NOT NULL,
    id_estado_audiencia NUMBER(2) NOT NULL,
    fecha DATE,
    hora VARCHAR2(10),
    observaciones VARCHAR2(1000),
    CONSTRAINT fk_audiencia_proceso FOREIGN KEY (id_proceso_judicial) REFERENCES Proceso_Judicial(id),
    CONSTRAINT fk_audiencia_tipo FOREIGN KEY (id_tipo_audiencia) REFERENCES Tipo_Audiencia(id),
    CONSTRAINT fk_audiencia_estado FOREIGN KEY (id_estado_audiencia) REFERENCES Estado_Audiencia(id)
);

CREATE TABLE Sentencia (
    id NUMBER(7) PRIMARY KEY,
    id_proceso_judicial NUMBER(7) NOT NULL,
    id_tipo_sentencia NUMBER(3) NOT NULL,
    id_estado_sentencia NUMBER(2) NOT NULL,
    descripcion VARCHAR2(1000),
    fecha DATE,
    CONSTRAINT fk_sentencia_proceso FOREIGN KEY (id_proceso_judicial) REFERENCES Proceso_Judicial(id),
    CONSTRAINT fk_sentencia_tipo FOREIGN KEY (id_tipo_sentencia) REFERENCES Tipo_Sentencia(id),
    CONSTRAINT fk_sentencia_estado FOREIGN KEY (id_estado_sentencia) REFERENCES Estado_Sentencia(id)
);

CREATE TABLE Querellante (
    id NUMBER(7) PRIMARY KEY,
    id_proceso_judicial NUMBER(7) NOT NULL,
    id_implicado NUMBER(7) NOT NULL,
    CONSTRAINT fk_querellante_proceso FOREIGN KEY (id_proceso_judicial) REFERENCES Proceso_Judicial(id),
    CONSTRAINT fk_querellante_implicado FOREIGN KEY (id_implicado) REFERENCES Implicado(id)
);

CREATE TABLE Abogado_Designado (
    id NUMBER(7) PRIMARY KEY,
    id_proceso_judicial NUMBER(7) NOT NULL,
    id_abogado NUMBER(7) NOT NULL,
    id_tipo_abogado NUMBER(2) NOT NULL,
    CONSTRAINT fk_abog_desig_proceso FOREIGN KEY (id_proceso_judicial) REFERENCES Proceso_Judicial(id),
    CONSTRAINT fk_abog_desig_abogado FOREIGN KEY (id_abogado) REFERENCES Abogado(id),
    CONSTRAINT fk_abog_desig_tipo FOREIGN KEY (id_tipo_abogado) REFERENCES Tipo_Abogado(id)
);

CREATE TABLE Juez_Designado (
    id NUMBER(7) PRIMARY KEY,
    id_proceso_judicial NUMBER(7) NOT NULL,
    id_juez NUMBER(7) NOT NULL,
    id_tipo_juez NUMBER(2) NOT NULL,
    CONSTRAINT fk_juez_desig_proceso FOREIGN KEY (id_proceso_judicial) REFERENCES Proceso_Judicial(id),
    CONSTRAINT fk_juez_desig_juez FOREIGN KEY (id_juez) REFERENCES Juez(id),
    CONSTRAINT fk_juez_desig_tipo FOREIGN KEY (id_tipo_juez) REFERENCES Tipo_Juez(id)
);

CREATE TABLE Testigo_Designado (
    id NUMBER(7) PRIMARY KEY,
    id_proceso_judicial NUMBER(7) NOT NULL,
    id_testigo NUMBER(7) NOT NULL,
    CONSTRAINT fk_testigo_desig_proceso FOREIGN KEY (id_proceso_judicial) REFERENCES Proceso_Judicial(id),
    CONSTRAINT fk_testigo_desig_testigo FOREIGN KEY (id_testigo) REFERENCES Testigo(id)
);

CREATE TABLE Documento (
    id NUMBER(7) PRIMARY KEY,
    id_proceso_judicial NUMBER(7) NOT NULL,
    id_audiencia NUMBER(7) NOT NULL,
    id_emisor NUMBER(2) NOT NULL,
    id_tipo_documento NUMBER(3) NOT NULL,
    descripcion VARCHAR2(1000),
    fecha DATE,
    CONSTRAINT fk_documento_proceso FOREIGN KEY (id_proceso_judicial) REFERENCES Proceso_Judicial(id),
    CONSTRAINT fk_documento_audiencia FOREIGN KEY (id_audiencia) REFERENCES Audiencia(id),
    CONSTRAINT fk_documento_emisor FOREIGN KEY (id_emisor) REFERENCES Emisor(id),
    CONSTRAINT fk_documento_tipo FOREIGN KEY (id_tipo_documento) REFERENCES Tipo_Documento(id)
);
