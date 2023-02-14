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

# crear sentencia sql
sql='UPDATE funcionario SET nome=%s,sexo=%s,idade=%s,especialidade=%s,telefone=%s,codigo_setor=%s,departamento=%s WHERE cpf=%s'

# consulta de datos a usuario
cpf=input('CPF do funcionario: ')
nome=input('Nome: ')
sexo=input('Sexo: ')
idade=input('Idade: ')
especialidade=input('Especialidade: ')
telefone=input('Telefone: ')
codigo_setor=input('Codigo do setor: ')
departamento=input('Departamento: ')


#recoleccion de datos
datos=(nome,sexo,idade,especialidade,telefone,codigo_setor,departamento,cpf)

# utilizar el metodo execute
cursor.execute(sql,datos)

# guardar modificacion
conexion.commit()

#contar el numero de cambios
actualizacion=cursor.rowcount

# mostrar mensaje al usuraio
print(f'registro attualizado: {actualizacion}')

# cerrar conexiones
cursor.close()
conexion.close()

