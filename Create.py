# importacion del modulo
import psycopg2

#conexion a base de datos
conexion=psycopg2.connect(user='postgres',
                          password='samira',
                          host='localhost',
                          port='5432',
                          database='postgres')

#utilizar cursor
cursor=conexion.cursor()

#crear sentencia sql
sql='INSERT INTO funcionario (cpf,nome,sexo,idade,especialidade,telefone,codigo_setor,departamento) VALUES(%s, %s, %s, %s, %s, %s, %s, %s, %s)'

# solicitud de datos al usuario
cpf=input('CPF: ')
nome=input('Nome: ')
sexo=input('Sexo: ')
idade=input('Idade: ')
especialidade=input('Especialidade: ')
telefone=input('Telefone: ')
codigo_setor=input('Codigo do setor: ')
codigo_servico=input('Codigo do serviço: ')
departamento=input('Departamento: ')

#recolection de datos
datos=(cpf,nome,sexo,idade,especialidade,telefone,codigo_setor,departamento)


#utilizar metodo execute
cursor.execute(sql,datos)

#guardar registro
conexion.commit()

# registro insertados

#mostrar resultado
registro=cursor.rowcount


print(f'Registro inserido: {registro}')

# cerrar conexion
cursor.close()
conexion.close()