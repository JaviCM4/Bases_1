import csv
import random
from faker import Faker

fake = Faker('es_MX')
Faker.seed(42)
random.seed(42)

def generar_cui():
    return ''.join([str(random.randint(0, 9)) for _ in range(13)])

def generar_dato(id):
    nombre_completo = fake.name().split()
    primer_nombre = nombre_completo[0]
    segundo_nombre = nombre_completo[1] if len(nombre_completo) > 2 else ''
    primer_apellido = nombre_completo[-2] if len(nombre_completo) > 2 else nombre_completo[1]
    segundo_apellido = nombre_completo[-1]
    
    return [
        id,
        generar_cui(),
        primer_nombre,
        segundo_nombre,
        primer_apellido,
        segundo_apellido,
        fake.date_of_birth(minimum_age=18, maximum_age=80).isoformat()
    ]

archivo_csv = "./PersonaDD.csv"

with open(archivo_csv, mode='w', newline='', encoding='utf-8') as file:
    writer = csv.writer(file)
    writer.writerow([
        "id",
        "cui",
        "primer_nombre",
        "segundo_nombre",
        "primer_apellido",
        "segundo_apellido",
        "fecha_nacimiento"
    ])

    for i in range(1, 2_000_000):
        writer.writerow(generar_dato(i))

print(f"Archivo '{archivo_csv}' creado con 500,000 registros.")
