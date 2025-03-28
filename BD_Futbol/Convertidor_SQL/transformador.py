import csv
import sys

# Este codigo se utilizo para convertir los archivos CSV a insercciones SQL

def convertir_texto_en_sql(ruta_archivo_csv, nombre_tabla='Sustitucion'):
    inserts_sql = []
    
    try:
        with open(ruta_archivo_csv, 'r', encoding='utf-8') as archivo_csv:
            muestra = archivo_csv.read(1024)
            archivo_csv.seek(0)
            
            delimitador = ';' if ';' in muestra else ','
            
            lector_csv = csv.reader(archivo_csv, delimiter=delimitador)
            
            next(lector_csv, None)
            
            for num_fila, fila in enumerate(lector_csv, 1):
                if len(fila) >= 2:
                    sentencia_insert = (f"INSERT INTO {nombre_tabla} "
                                   f"(id, id_accion, id_tipo_sustitucion) "
                                   f"VALUES ({fila[0]}, {fila[1]}, {fila[2]});"
                                   f" --Fila {num_fila}")
                    inserts_sql.append(sentencia_insert)
        
        return inserts_sql
    
    except FileNotFoundError:
        print(f"Error: Archivo {ruta_archivo_csv} no encontrado.")
        return []
    except Exception as e:
        print(f"Ocurrió un error: {e}")
        return []

def main():
    ruta_archivo_csv = r'C:\Users\DELL\Escritorio\BD_Futbol\Data\Sustitucion.csv'
  
    sentencias_sql = convertir_texto_en_sql(ruta_archivo_csv)
    
    with open('inserts_sql.txt', 'w', encoding='utf-8') as archivo_salida:
        for sentencia in sentencias_sql:
            archivo_salida.write(sentencia + '\n')

if __name__ == '__main__':
    main()