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

# crear la sentencia sql
sql='SELECT * FROM funcionario WHERE cpf=%s'


# solicitar datos a usuario
cpf=input('CPF do funcionario: ')

# uso del metodo execute
#cursor.execute(sql,cpf)
cursor.execute(sql, (cpf,))

# mostrar resultado
registro=cursor.fetchone()

# mostrar en consola o el usuario
print(registro)

# cerrar conexiones
cursor.close()
conexion.close()