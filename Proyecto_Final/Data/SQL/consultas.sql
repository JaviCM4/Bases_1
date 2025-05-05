-- (1) Cantidad de homicidios registrados por año y departamento.
SELECT 
    dpto.nombre AS departamento,
    ef.anio AS AÑO,
    COUNT(*) AS cantidad_homicidios
FROM 
    Denuncia d
JOIN
    Implicado i ON i.id_denuncia = d.id
JOIN
    Evento_Fecha ef ON ef.id_denuncia = d.id
JOIN
    Institucion inst ON inst.id = d.id_institucion
JOIN
    Direccion drc ON drc.id_entidad = inst.id
JOIN
    Municipio m ON m.id = drc.id_municipio
JOIN
    Departamento dpto ON dpto.id = m.id_departamento
WHERE 
    i.id_tipo_denuncia = 164 AND i.id_tipo_implicado = 2 AND ef.id_tipo_evento = 2 AND drc.id_tipo_entidad = 2
GROUP BY 
    dpto.nombre, ef.anio
ORDER BY
    ef.anio


-- (2) Número de denuncias por violencia contra la mujer por municipio.
SELECT 
    m.nombre AS Municipio,
    dpto.nombre AS Departamento,
    COUNT(*) AS cantidad_violencia_mujer
FROM 
    Denuncia d
JOIN
    Implicado i ON i.id_denuncia = d.id
JOIN
    Persona p ON p.id = i.id_persona
JOIN
    Perfil_Sociodemografico ps ON ps.id_persona = p.id
JOIN
    Evento_Fecha ef ON ef.id_denuncia = d.id
JOIN
    Institucion inst ON inst.id = d.id_institucion
JOIN
    Direccion drc ON drc.id_entidad = inst.id
JOIN
    Municipio m ON m.id = drc.id_municipio
JOIN
    Departamento dpto ON dpto.id = m.id_departamento
WHERE 
    i.id_tipo_denuncia IN(15,25,109,164,293,318,439) AND ps.id_sexo = 2 AND i.id_tipo_implicado = 2 AND ef.id_tipo_evento = 1 AND drc.id_tipo_entidad = 2
GROUP BY 
    m.nombre, dpto.nombre
ORDER BY
    dpto.nombre


-- (3) Top 5 tipos de hechos delictivos más frecuentes en los últimos 5 años.
SELECT *
FROM (
    SELECT 
        td.nombre AS Nombre,
        ef.anio AS Año,
        COUNT(*) AS Cantidad,
        (ROW_NUMBER() OVER (PARTITION BY ef.anio ORDER BY COUNT(*) DESC)) AS rn
    FROM
        Denuncia d
    JOIN
        Implicado i ON d.id = i.id_denuncia
    JOIN
        Evento_Fecha ef ON d.id = ef.id_denuncia
    JOIN
        Tipo_Denuncia td ON td.id = i.id_tipo_denuncia
    WHERE
        i.id_tipo_implicado = 1
    GROUP BY
        td.nombre,
        ef.anio
)
WHERE rn <= 5
ORDER BY Año DESC, Cantidad DESC;



-- (4) Sentencias dictadas por tipo de delito y año.
SELECT
    td.nombre AS Delito, 
    EXTRACT(YEAR FROM s.fecha) AS AÑO,
    COUNT(*) AS Cantidad_Sentencias
FROM
    Proceso_Judicial pj
JOIN
    Denuncia d ON d.id = pj.id_denuncia
JOIN
    Implicado i ON d.id = i.id_denuncia
JOIN
    Tipo_Denuncia td ON td.id = i.id_tipo_denuncia
JOIN
    Sentencia s ON pj.id = s.id_proceso_judicial
WHERE
    s.id_tipo_sentencia IN (1,2,3)
GROUP BY
    td.nombre, EXTRACT(YEAR FROM s.fecha)
ORDER BY
    EXTRACT(YEAR FROM s.fecha);


-- (5) Promedio de edad de las víctimas de violencia intrafamiliar.
SELECT
    'Promedio de Edades de Violencia Intrafamiliar' AS Violencia,
    (TRUNC(AVG(TRUNC(MONTHS_BETWEEN(SYSDATE, p.fecha_nacimiento) / 12)))) AS Edad_Promedio
FROM
    Denuncia d
JOIN
    Implicado i ON d.id = i.id_denuncia
JOIN
    Persona p ON p.id = i.id_persona
WHERE 
    i.id_tipo_denuncia = 450  AND i.id_tipo_implicado = 2;


-- (6) Distribución de embarazos adolescentes (menores de 19 años) por región.
SELECT
    r.nombre AS Region,
    COUNT(*) AS cantidad_embarazos
FROM
    Denuncia d
JOIN
    Implicado i ON d.id = i.id_denuncia
JOIN
    Persona p ON p.id = i.id_persona
JOIN
    Perfil_Sociodemografico ps ON p.id = ps.id_persona
JOIN
    Municipio m ON m.id = ps.id_municipio_nacimiento
JOIN
    Departamento dpto ON dpto.id = m.id_departamento
JOIN
    Region r ON r.id = dpto.id_region
WHERE
    (TRUNC(MONTHS_BETWEEN(SYSDATE, p.fecha_nacimiento) / 12) < 19) AND i.id_tipo_implicado = 2
GROUP BY
    r.nombre;


-- (7) Cantidad de casos de violencia infantil relacionados con trabajo infantil.
SELECT
    COUNT(*) AS Casos_Relacinados
FROM
    Denuncia d
JOIN
    Implicado i ON d.id = i.id_denuncia
JOIN
    Persona p ON p.id = i.id_persona
WHERE
    i.id_tipo_denuncia IN(451,452) AND i.id_tipo_implicado = 1 AND (TRUNC(MONTHS_BETWEEN(SYSDATE, p.fecha_nacimiento) / 12) < 18)


-- (8) Porcentaje de denuncias por discriminación según etnia.
SELECT
    CASE 
        WHEN ps.id_grupo_etnico = 1 THEN 'Maya'
        WHEN ps.id_grupo_etnico = 2 THEN 'Garífuna'
        WHEN ps.id_grupo_etnico = 3 THEN 'Xinca'
        WHEN ps.id_grupo_etnico = 4 THEN 'Ladino'
        ELSE 'Otro'
    END AS Grupo_Etnico,
    COUNT(*) AS Cantidad_Denuncias,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 2) || '%' AS Porcentaje
FROM
    Denuncia d
JOIN
    Implicado i ON d.id = i.id_denuncia
JOIN
    Tipo_Denuncia td ON td.id = i.id_tipo_denuncia
JOIN
    Persona p ON p.id = i.id_persona
JOIN
    Perfil_Sociodemografico ps ON p.id = ps.id_persona
WHERE
    i.id_tipo_denuncia = 109 AND i.id_tipo_implicado = 2
GROUP BY
    CASE 
        WHEN ps.id_grupo_etnico = 1 THEN 'Maya'
        WHEN ps.id_grupo_etnico = 2 THEN 'Garífuna'
        WHEN ps.id_grupo_etnico = 3 THEN 'Xinca'
        WHEN ps.id_grupo_etnico = 4 THEN 'Ladino'
        ELSE 'Otro'
    END
ORDER BY
    Porcentaje DESC


-- (9) Comparativa entre nivel de escolaridad y tipo de falta judicial cometida.
SELECT
    ne.id AS Indice,
    ne.nombre AS Nivel_Escolaridad,
    td.nombre AS Delito,
    COUNT(*) AS Cantidad_Personas
FROM
    Implicado i
JOIN
    Persona p ON p.id = i.id_persona
JOIN
    Tipo_Denuncia td ON td.id = i.id_tipo_denuncia
JOIN
    Perfil_Sociodemografico ps ON p.id = ps.id_persona
JOIN
    Nivel_Escolaridad ne ON ne.id = ps.id_nivel_escolaridad
WHERE
    i.id_tipo_implicado = 1
GROUP BY
    ne.id,
    ne.nombre,
    td.nombre
ORDER BY
    ne.id


-- (10) Número de necropsias realizadas por año.
SELECT
    EXTRACT(YEAR FROM e.fecha) AS Año,
    COUNT(*) AS Cantidad_Necropsias
FROM
    Evaluacion e
WHERE
    e.id_tipo_evaluacion = 1
GROUP BY
    EXTRACT(YEAR FROM e.fecha)
ORDER BY
    EXTRACT(YEAR FROM e.fecha);


-- (11) Tasa de denuncias de violencia estructural procesadas vs. no procesadas.
SELECT
    CASE 
        WHEN d.id_estado_denuncia IN (4,5,6,8,9,10,11,12,14,15,17) THEN 'Procesadas'
        WHEN d.id_estado_denuncia IN (1,2,3,7,13,16) THEN 'No Procesadas'
    END AS Estado_Procesamiento,
    COUNT(*) AS Cantidad
FROM
    Denuncia d
JOIN
    Implicado i ON d.id = i.id_denuncia
WHERE
    i.id_tipo_denuncia IN(11,69,105,109,114,122,123,201,233,236,253,255,274,293,312,325,367)
GROUP BY
    CASE 
        WHEN d.id_estado_denuncia IN (4,5,6,8,9,10,11,12,14,15,17) THEN 'Procesadas'
        WHEN d.id_estado_denuncia IN (1,2,3,7,13,16) THEN 'No Procesadas'
    END;


-- (12) Relación entre el tipo de empleo y la ocurrencia de hechos delictivos.
SELECT
    tp.nombre AS Trabajo,
    td.nombre AS Delito,
    COUNT(*) AS Cantidad_Casos
FROM
    Implicado i
JOIN
    Persona p ON p.id = i.id_persona
JOIN
    Tipo_Denuncia td ON td.id = i.id_tipo_denuncia
JOIN
    Perfil_Sociodemografico ps ON p.id = ps.id_persona
JOIN
    Trabajo t ON ps.id = t.id_perfil_sociodemografico
JOIN
    Tipo_Trabajo tp ON tp.id = t.id_tipo_trabajo
GROUP BY
    tp.nombre,
    td.nombre
ORDER BY
    td.nombre


-- (13) Casos de violencia contra la mujer con sentencia firme.
SELECT
    td.nombre AS Delito, 
    COUNT(*) AS Cantidad_Sentencias_Firmes
FROM
    Implicado i
JOIN
    Persona p ON p.id = i.id_persona
JOIN
    Perfil_Sociodemografico ps ON p.id = ps.id_persona
JOIN
    Denuncia d ON d.id = i.id_denuncia
JOIN
    Tipo_Denuncia td ON td.id = i.id_tipo_denuncia
JOIN
    Proceso_Judicial pj ON d.id = pj.id_denuncia
JOIN
    Sentencia s ON pj.id = s.id_proceso_judicial
WHERE
    s.id_tipo_sentencia IN (13,17,18) AND ps.id_sexo = 2 AND i.id_tipo_implicado = 2 AND i.id_tipo_denuncia IN(15,25,109,164,293,318,439)
GROUP BY
    td.nombre


-- (14) Idiomas hablados por víctimas de discriminación.
SELECT
    idm.nombre AS Idioma,
    COUNT(*) AS Cantidad_Hablantes
FROM
    Implicado i
JOIN
    Persona p ON p.id = i.id_persona
JOIN
    Tipo_Denuncia td ON td.id = i.id_tipo_denuncia
JOIN
    Perfil_Sociodemografico ps ON p.id = ps.id_persona
JOIN
    Persona_Idioma pi ON ps.id = pi.id_perfil_sociodemografico
JOIN
    Idioma idm ON idm.id = pi.id_idioma
WHERE
    i.id_tipo_denuncia = 109
GROUP BY
    idm.nombre


-- (15) Número de personas por hogar en casos con denuncias de violencia intrafamiliar.
SELECT
    p.id AS Identificado,
    p.primer_nombre || ' ' || p.segundo_nombre || ' ' || p.primer_apellido || ' ' || p.segundo_apellido AS Nombre,
    COUNT(*) AS Numero_Familiares
FROM
    Implicado i
JOIN
    Persona p ON p.id = i.id_persona
JOIN
    Familia f ON p.id = f.id_persona
WHERE
    i.id_tipo_denuncia = 450
GROUP BY
    p.id,
    p.primer_nombre, p.segundo_nombre, p.primer_apellido, p.segundo_apellido


-- (16) Tasa de denuncias de violencia infantil en población escolarizada vs. no escolarizada.
SELECT
    CASE 
        WHEN ps.id_nivel_escolaridad IN (1,2,3,4,5) THEN 'Escolarizada'
        WHEN ps.id_nivel_escolaridad IN (6) THEN 'No Escolarizada'
    END AS Nivel_Escolaridad,
    COUNT(*) AS Cantidad_Personas
FROM
    Denuncia d
JOIN
    Implicado i ON d.id = i.id_denuncia
JOIN
    Persona p ON p.id = i.id_persona
JOIN
    Perfil_Sociodemografico ps ON p.id = ps.id_persona
WHERE
    i.id_tipo_denuncia = 451 AND i.id_tipo_implicado = 2 AND (TRUNC(MONTHS_BETWEEN(SYSDATE, p.fecha_nacimiento) / 12) < 18)
GROUP BY
    CASE 
        WHEN ps.id_nivel_escolaridad IN (1,2,3,4,5) THEN 'Escolarizada'
        WHEN ps.id_nivel_escolaridad IN (6) THEN 'No Escolarizada'
    END


-- (17) Casos de trabajo infantil por sector económico (agricultura, industria, etc.).
SELECT
    se.nombre AS Sector,
    COUNT(*) AS Cantidad_Personas
FROM
    Denuncia d
JOIN
    Implicado i ON d.id = i.id_denuncia
JOIN
    Persona p ON p.id = i.id_persona
JOIN
    Perfil_Sociodemografico ps ON p.id = ps.id_persona
JOIN
    Trabajo t ON ps.id = t.id_perfil_sociodemografico
JOIN
    Sector_Economico se ON se.id = t.id_sector_economico
WHERE
    i.id_tipo_denuncia = 452 AND i.id_tipo_implicado = 1
GROUP BY
    se.nombre
ORDER BY
    Cantidad_Personas DESC

-- (18) Relación entre edad y tipo de violencia sufrida (infantil, intrafamiliar, estructural, etc.).
SELECT
    CASE
        WHEN EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM p.fecha_nacimiento) BETWEEN 0 AND 12 THEN 'Niñez (0-12)'
        WHEN EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM p.fecha_nacimiento) BETWEEN 13 AND 17 THEN 'Adolescencia (13-17)'
        WHEN EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM p.fecha_nacimiento) BETWEEN 18 AND 29 THEN 'Juventud (18-29)'
        WHEN EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM p.fecha_nacimiento) BETWEEN 30 AND 59 THEN 'Adultez (30-59)'
        ELSE 'Adulto mayor (60+)'
    END AS Edades,
    td.nombre AS Tipo_Violencia,
    COUNT(*) AS Cantidad_Casos
FROM
    Denuncia d
JOIN
    Implicado i ON d.id = i.id_denuncia
JOIN
    Persona p ON p.id = i.id_persona
JOIN
    Tipo_Denuncia td ON td.id = i.id_tipo_denuncia
WHERE
    i.id_tipo_denuncia IN(11,69,105,109,114,122,123,201,233,236,253,255,274,293,312,325,367,450,451,452) AND i.id_tipo_implicado = 2
GROUP BY
    CASE
        WHEN EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM p.fecha_nacimiento) BETWEEN 0 AND 12 THEN 'Niñez (0-12)'
        WHEN EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM p.fecha_nacimiento) BETWEEN 13 AND 17 THEN 'Adolescencia (13-17)'
        WHEN EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM p.fecha_nacimiento) BETWEEN 18 AND 29 THEN 'Juventud (18-29)'
        WHEN EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM p.fecha_nacimiento) BETWEEN 30 AND 59 THEN 'Adultez (30-59)'
        ELSE 'Adulto mayor (60+)'
    END,
    td.nombre
ORDER BY
    Edades,
    Cantidad_Casos DESC


-- (19) Comparativa de violencia estructural entre áreas urbanas y rurales.
SELECT
    CASE 
        WHEN ps.id_area_geografica IN (1) THEN 'Área Urbana'
        WHEN ps.id_area_geografica IN (2) THEN 'Área Rural'
    END AS Area,
    COUNT(*) AS Cantidad_Personas
FROM
    Denuncia d
JOIN
    Implicado i ON d.id = i.id_denuncia
JOIN
    Persona p ON p.id = i.id_persona
JOIN
    Perfil_Sociodemografico ps ON p.id = ps.id_persona
WHERE
    i.id_tipo_denuncia IN(11,69,105,109,114,122,123,201,233,236,253,255,274,293,312,325,367)
GROUP BY
    CASE 
        WHEN ps.id_area_geografica IN (1) THEN 'Área Urbana'
        WHEN ps.id_area_geografica IN (2) THEN 'Área Rural'
    END

-- (20) Frecuencia de Necropsias por tipo de delito relacionado.
SELECT
    td.nombre AS Nombre,
    COUNT(*) AS Cantidad_Exhumaciones
FROM
    Implicado i
JOIN
    Persona p ON p.id = i.id_persona
JOIN
    Evaluacion e ON p.id = e.id_persona
JOIN
    Registro_Necropsia rn ON e.id = rn.id_evaluacion
JOIN
    Tipo_Denuncia td ON td.id = i.id_tipo_denuncia
WHERE
    e.id_tipo_evaluacion = 1 AND i.id_tipo_implicado = 2 AND rn.id_tipo_causa = 12
GROUP BY
    td.nombre
ORDER BY
    Cantidad_Exhumaciones DESC
