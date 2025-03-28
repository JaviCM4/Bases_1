-- (1)¿Qué jugador ha anotado más goles en la temporada y cuántos ha marcado?
SELECT
    p.primer_nombre,
    p.apellido,
    COUNT(a.id) AS goles,
    l.nombre,
    t.fecha
FROM 
    Persona p
JOIN 
    Accion a ON p.id = a.id_persona
JOIN
    Partido pd ON a.id_partido = pd.id
JOIN 
    Temporada t ON pd.id_temporada = t.id
JOIN
    Liga l on t.id_liga = l.id
WHERE 
    a.id_tipo_accion = 1 AND a.id_persona = p.id
GROUP BY
    p.primer_nombre,
    p.apellido,
    l.nombre,
    t.fecha
ORDER BY
    goles DESC;





-- (2)¿Cuáles son los 5 equipos con mayor cantidad de puntos obtenidos jugando como visitantes?
SELECT 
    e.nombre AS nombre_equipo,
    SUM(
        CASE 
            WHEN ep.id_resultado = 1 THEN 3  -- Victoria
            WHEN ep.id_resultado = 2 THEN 1  -- Empate
            ELSE 0  -- Derrota
        END
    ) AS puntos_visitante
FROM Equipo_participante ep
JOIN Equipo e ON ep.id_equipo = e.id
JOIN Partido p ON ep.id_partido = p.id
JOIN Condicion c ON ep.id_condicion = c.id
WHERE c.nombre = 'Visitante'
GROUP BY e.nombre
ORDER BY puntos_visitante DESC





-- (3)¿Qué equipo tiene la mayor posesión promedio en sus partidos durante la temporada?
SELECT 
    e.nombre AS nombre_equipo,
    ROUND(AVG(ep.posesion), 2) AS posesion_promedio
FROM Equipo_participante ep
JOIN Equipo e ON ep.id_equipo = e.id
GROUP BY e.nombre
ORDER BY posesion_promedio DESC





-- (4)¿Qué portero tiene más partidos con la portería a cero?
SELECT
    p.primer_nombre,
    p.apellido,
    COUNT(a.id) AS goles_recibidos
FROM 
    Persona p
JOIN
    Jugador j ON j.id_persona = p.id
JOIN
    Accion a ON a.id_persona = p.id
WHERE 
    a.id_tipo_accion = 1 AND  j.id_posicion = 1 
GROUP BY
    p.primer_nombre,
    p.apellido 
ORDER BY
    goles_recibidos DESC;





-- (5)¿Qué jugador tiene el mejor promedio de goles por minuto jugado, mínimo unos 500 minutos?
SELECT
    p.primer_nombre,
    p.apellido,
    COUNT(a.id) AS Goles,
    SUM(c.minutos) AS Minutos_Jugados,
    ( COUNT(a.id) / SUM(c.minutos)) AS goles_promedio
FROM 
    Persona p
JOIN 
    Accion a ON p.id = a.id_persona
JOIN
    Partido pd ON a.id_partido = pd.id
JOIN
    Convocado c on p.id = c.id_persona
WHERE 
    a.id_tipo_accion = 1
GROUP BY
    p.primer_nombre,
    p.apellido
HAVING 
    SUM(c.minutos) > 500
ORDER BY
    goles_promedio ASC;





-- (6)¿Qué partidos tuvieron la mayor cantidad de goles combinados, tanto local como visitante?
SELECT
    p.id,
    e.nombre,
    c.nombre AS condicion,
    COUNT(a.id_tipo_accion) AS goles_ambos
FROM 
    Partido p
JOIN 
    Equipo_participante ep ON p.id = ep.id_partido
JOIN
    Condicion c ON ep.id_condicion = c.id
JOIN
    Equipo e ON ep.id_equipo = e.id
JOIN
    Accion a ON p.id = a.id_partido
WHERE 
    a.id_tipo_accion = 1
GROUP BY
    p.id,
    e.nombre,
    c.nombre
ORDER BY
    goles_ambos DESC,
    p.id ASC;





-- (7)¿Qué jugador ha recibido más tarjetas amarillas y en qué equipo juega?
SELECT
    p.primer_nombre,
    p.apellido,
    j.dorsal,
    e.nombre,
    COUNT(a.id) AS numero_tarjetas
FROM 
    Persona p
JOIN 
    Jugador j ON p.id = j.id_persona
JOIN
    Equipo e ON j.id_equipo = e.id
JOIN
    Accion a ON p.id = a.id_partido
JOIN
    Tarjeta t ON a.id = t.id_accion
WHERE 
    a.id_tipo_accion = 6 AND t.id_tipo_tarjeta = 1
GROUP BY
    p.primer_nombre,
    p.apellido,
    j.dorsal,
    e.nombre
ORDER BY
    numero_tarjetas DESC;





-- (8)¿Cuál es el promedio de goles por partido en la liga y qué equipos están por encima de ese promedio?
WITH EquiposPartido AS (
    SELECT 
        p.id AS partido_id,
        MAX(CASE WHEN ep.id_condicion = 1 THEN e.nombre END) AS Localidad,
        MAX(CASE WHEN ep.id_condicion = 2 THEN e.nombre END) AS Visitante
    FROM 
        Partido p 
    JOIN 
        Equipo_participante ep ON p.id = ep.id_partido
    JOIN 
        Equipo e ON ep.id_equipo = e.id
    GROUP BY 
        p.id
)
SELECT
    p.id,
    ep.Localidad,
    ep.Visitante,
    COUNT(a.id) AS goles_partido
FROM 
    Partido p
JOIN 
    Accion a ON p.id = a.id_partido
JOIN
    EquiposPartido ep ON p.id = ep.partido_id
WHERE 
    a.id_tipo_accion = 1
GROUP BY
    p.id,
    ep.Localidad,
    ep.Visitante
ORDER BY
    goles_partido DESC;





-- (9)¿Qué equipos tienen mejor diferencia de goles en los últimos 10 minutos de cada partido?
SELECT 
    e.nombre,
    COUNT(DISTINCT p.id) AS partidos_jugados,
    COUNT(a.id) AS goles_partido_tarde
FROM 
    Equipo e
JOIN    
    Equipo_participante ep ON e.id = ep.id_equipo
JOIN 
    Partido p ON ep.id_partido = p.id
LEFT JOIN
    Accion a ON (p.id = a.id_partido AND a.id_tipo_accion = 1 AND a.minuto > 80 AND a.id_persona IN (
        SELECT id_persona 
        FROM Jugador 
        WHERE id_equipo = e.id
    ))
GROUP BY
    e.nombre
ORDER BY
    goles_partido_tarde DESC;





-- (10)¿Qué jugadores han realizado más asistencias y cuáles son sus promedios por partido jugado?
-- Idea conceptual, porque se me olvido agregar las asistencias a la base de datos, hice la tabla pero no la descargue de colab y me quede con la versión anterior donde no tenia los datos :(
SELECT
    p.primer_nombre,
    p.apellido,
    COUNT(DISTINCT pd.id) AS partidos_jugados,
    COUNT(a.id) AS asistencias
FROM 
    Persona p
JOIN 
    Convocado c ON p.id = c.id_persona
JOIN
    Partido pd ON c.id_partido = pd.id
JOIN
    Accion a ON a.id_persona = pd.id
WHERE 
    a.id_tipo_accion = 8
GROUP BY
    p.primer_nombre,
    p.apellido 
ORDER BY
    asistencias DESC;





-- (11)¿Cuántos penales ha anotado cada equipo y cuál es su porcentaje de efectividad desde el punto penal?
SELECT
    e.nombre,
    COUNT(a.id_tipo_accion) AS goles_anotados
FROM 
    Partido p
JOIN 
    Equipo_participante ep ON p.id = ep.id_partido
JOIN
    Condicion c ON ep.id_condicion = c.id
JOIN
    Equipo e ON ep.id_equipo = e.id
JOIN
    Accion a ON p.id = a.id_partido
WHERE 
    a.id_tipo_accion = 1
GROUP BY
    e.nombre
ORDER BY
    goles_anotados DESC;





-- (12)¿Cuántos puntos ha sumado un equipo?
SELECT
    e.nombre,
    (t.ganados * 3) + (t.empates) AS punteo
FROM 
    Tabla_posicion t
JOIN 
    Equipo e ON t.id_equipo = e.id
WHERE 
    t.ganados > 0 OR t.empates > 0
ORDER BY
    punteo DESC;





-- (13)¿Qué jugadores han sido sustituidos más veces durante los partidos y en qué minutos ocurre más frecuentemente?
SELECT 
    p.primer_nombre,
    p.apellido,
    COUNT(a.id_tipo_accion) AS numero_sustituciones,
    SUM(a.minuto) AS total_minutos,
    ROUND((SUM(a.minuto) / COUNT(a.id)), 2) AS minuto_promedio
FROM 
    Accion a
JOIN 
    Persona p ON a.id_persona = p.id
JOIN
    Sustitucion s ON a.id = s.id_accion
WHERE 
    a.id_tipo_accion = 9 AND s.id_tipo_sustitucion = 2
GROUP BY
    p.primer_nombre,
    p.apellido
ORDER BY
    numero_sustituciones DESC;





-- (14)¿Qué equipos han tenido más posesión en partidos que terminaron en derrota?
SELECT
    e.nombre,
    ep.posesion
FROM 
    Equipo_participante ep
JOIN 
    Equipo e ON ep.id_equipo = e.id
WHERE 
    ep.id_resultado = 3
ORDER BY
    punteo DESC;





-- (15)En base a la posesión, puede determinar un mapa de calor de esos equipos en toda la temporada
-- Capturas en el Documento





-- (16)En base a los goles anotados, puede generar un mapa de goles en base a algún jugador.
-- Capturas en el Documento





-- (17)¿Qué equipos han tenido más posesión en partidos que terminaron en victoria?
SELECT
    e.nombre,
    ep.posesion
FROM 
    Equipo_participante ep
JOIN 
    Equipo e ON ep.id_equipo = e.id
WHERE 
    ep.id_resultado = 1
ORDER BY
    punteo DESC;





-- (18)¿Qué equipos han tenido más posesión en partidos que terminaron en empate?
SELECT
    e.nombre,
    ep.posesion
FROM 
    Equipo_participante ep
JOIN 
    Equipo e ON ep.id_equipo = e.id
WHERE 
    ep.id_resultado = 2
ORDER BY
    punteo DESC;





-- (19)¿Qué jugador ha recibido más tarjetas rojas y en qué equipo juega?
SELECT
    p.primer_nombre,
    p.apellido,
    j.dorsal,
    e.nombre,
    COUNT(a.id) AS numero_tarjetas
FROM 
    Persona p
JOIN 
    Jugador j ON p.id = j.id_persona
JOIN
    Equipo e ON j.id_equipo = e.id
JOIN
    Accion a ON p.id = a.id_partido
JOIN
    Tarjeta t ON a.id = t.id_accion
WHERE 
    a.id_tipo_accion = 6 AND t.id_tipo_tarjeta = 2
GROUP BY
    p.primer_nombre,
    p.apellido,
    j.dorsal,
    e.nombre
ORDER BY
    numero_tarjetas DESC;





-- (20)¿Cual es el equipo que utilizo una tactica de juego en especifico?
SELECT
    e.nombre,
    t.nombre,
    COUNT(ep.id) AS veces_usada
FROM 
    Equipo_participante ep
JOIN 
    Equipo e ON ep.id_equipo = e.id
JOIN 
    Tactica t ON ep.id_tactica = t.id
WHERE 
    t.id = 1
GROUP BY
    e.nombre,
    t.nombre
ORDER BY
    veces_usada DESC;





-- (21)¿Cúal es el equipo que más veces ganó de visita?
SELECT
    e.nombre,
    COUNT(ep.id) AS victorias_visita
FROM 
    Equipo_participante ep
JOIN 
    Equipo e ON ep.id_equipo = e.id
WHERE 
    ep.id_condicion = 2 AND ep.id_resultado = 1
GROUP BY
    e.nombre
ORDER BY
    victorias_visita DESC;





-- (22)¿Cúal es el equipo que más veces perdio de visita?
SELECT
    e.nombre,
    COUNT(ep.id) AS victorias_visita
FROM 
    Equipo_participante ep
JOIN 
    Equipo e ON ep.id_equipo = e.id
WHERE 
    ep.id_condicion = 2 AND ep.id_resultado = 3
GROUP BY
    e.nombre
ORDER BY
    victorias_visita DESC;





-- (23)¿Cúal es el equipo que más veces empato de visita?
SELECT
    e.nombre,
    COUNT(ep.id) AS victorias_visita
FROM 
    Equipo_participante ep
JOIN 
    Equipo e ON ep.id_equipo = e.id
WHERE 
    ep.id_condicion = 2 AND ep.id_resultado = 2
GROUP BY
    e.nombre
ORDER BY
    victorias_visita DESC;





-- (24)¿Cúal es el equipo que más veces ganó de local?
SELECT
    e.nombre,
    COUNT(ep.id) AS victorias_visita
FROM 
    Equipo_participante ep
JOIN 
    Equipo e ON ep.id_equipo = e.id
WHERE 
    ep.id_condicion = 1 AND ep.id_resultado = 1
GROUP BY
    e.nombre
ORDER BY
    victorias_visita DESC;





-- (25)¿Cúal es el equipo que más veces perdio de local?
SELECT
    e.nombre,
    COUNT(ep.id) AS victorias_visita
FROM 
    Equipo_participante ep
JOIN 
    Equipo e ON ep.id_equipo = e.id
WHERE 
    ep.id_condicion = 1 AND ep.id_resultado = 3
GROUP BY
    e.nombre
ORDER BY
    victorias_visita DESC;





-- (26)¿Cúal es el equipo que más veces empato de local?
SELECT
    e.nombre,
    COUNT(ep.id) AS victorias_visita
FROM 
    Equipo_participante ep
JOIN 
    Equipo e ON ep.id_equipo = e.id
WHERE 
    ep.id_condicion = 1 AND ep.id_resultado = 2
GROUP BY
    e.nombre
ORDER BY
    victorias_visita DESC;





-- (27)¿Cuales son los jugadores que más veces empezaron de titular?
SELECT
    p.primer_nombre,
    p.apellido,
    COUNT(c.id) AS convocatorias_titular
FROM 
    Convocado c
JOIN 
    Persona p ON c.id_persona = p.id
JOIN 
    Titular t ON c.id_titular = t.id
WHERE 
    c.id_titular = 1
GROUP BY
    p.primer_nombre,
    p.apellido
ORDER BY
    convocatorias_titular DESC;





-- (28)¿Cuales son los jugadores que más veces empezaron de susprente?
SELECT
    p.primer_nombre,
    p.apellido,
    COUNT(c.id) AS convocatorias_titular
FROM 
    Convocado c
JOIN 
    Persona p ON c.id_persona = p.id
JOIN 
    Titular t ON c.id_titular = t.id
WHERE 
    c.id_titular = 2
GROUP BY
    p.primer_nombre,
    p.apellido
ORDER BY
    convocatorias_titular DESC;





-- (29) ¿Cuál es el país de cada jugador?
SELECT
    p.primer_nombre,
    p.apellido,
    ps.nombre,
    ps.alpha_dos,
    ps.alpha_tres
FROM 
    Persona p
JOIN 
    Pais ps ON p.id_pais = ps.id






-- (30) ¿Como se llama es estadio de cada equipo?
SELECT
    e.nombre,
    es.nombre,
    es.capacidad,
    es.direccion,
    es.ciudad
FROM 
    Equipo e
JOIN 
    Estadio es ON e.id = es.id_equipo