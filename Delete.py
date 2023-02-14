# importacion del modulo
import psycopg2

#conexion a base de datos
conexion=psycopg2.connect(user='postgres',
                          password='samira',
                          host='localhost',
                          port='5432',
                          database='postgres')

# utilizar cursor
cursor=conexion.cursor()

# sentencia sql
sql='DELETE FROM funcionario WHERE cpf=%s'

# solicitar dato al usuraio
cpf=input('Excluir CPF: ')

# metodo execute
cursor.execute(sql,(cpf,))

# guardar cambios
conexion.commit()

# conteo de registro eliminado
registro_eliminado=cursor.rowcount

# mensaje al usuario
print(f'Registro eliminado: {registro_eliminado}')

# cerrar conexiones
cursor.close()
conexion.close()