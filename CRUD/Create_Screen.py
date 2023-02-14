import io
import os
import PySimpleGUI as sg
from PIL import Image
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
sql='INSERT INTO funcionario (cpf,nome,sexo,idade,especialidade,telefone,codigo_setor,departamento) VALUES(%s, %s, %s, %s, %s, %s, %s, %s)'

file_types = [("JPEG (*.jpg)", "*.jpg"), ("All files (*.*)", "*.*")]
layout = [
    [sg.Image(key="-IMAGE-")],
    [
        sg.Text("Foto: "),
        sg.Input(size=(25, 1), key="-FILE-", disabled=True),
        sg.FileBrowse(file_types=file_types),
        sg.Button("Carregar imagem"),
    ],
    [sg.Text("CPF  "), sg.Input(key="cpf")],
    [sg.Text("Nome"), sg.Input(key="nome")],
    [sg.Text("Sexo")],
    [sg.Radio("Masculino", group_id="sexo", key="M", default=True), sg.Radio("Feminino", group_id="sexo", key="F")],
    [sg.Text("  Idade                "), sg.Input(key="idade")],
    [sg.Text("  Especialidade:   "), sg.Input(key="especialidade")],
    [sg.Text("  Telefone:           "), sg.Input(key="telefone")],
    [sg.Text("  Codigo do setor:"), sg.Input(key="codigo_do_setor")],
    #[sg.Text("Codigo do serviço"), sg.Input(key="codigo_servico")],
    [sg.Text("  Departamento:  "), sg.Input(key="departamento")],
    [sg.Button("Enviar dados")],
    #[sg.Output(size=(50, 30))],
]

window = sg.Window("Funcionário", layout)

while True:
    event, values = window.read()
    if event in (None, "Exit", sg.WIN_CLOSED):
        break
    if event == "Carregar imagem":
        filename = values["-FILE-"]
        if os.path.exists(filename):
            image = Image.open(filename)
            image.thumbnail((400, 400))
            bio = io.BytesIO()
            image.save(bio, format="PNG")
            window["-IMAGE-"].update(data=bio.getvalue())
            window["-FILE-"].update(value=filename)
    if event == "Enviar dados":
        cpf = values["cpf"]
        nome = values["nome"]
        sexo = "Masculino" if values["M"] else "Feminino"
        idade = values["idade"]
        especialidade = values["especialidade"]
        telefone = values["telefone"]
        codigo_setor = values["codigo_do_setor"]
        #codigo_servico = values["codigo_servico"]
        departamento = values["departamento"]
        print(f"Nome: {nome}")
        print(f"Idade: {idade}")
        print(f"Sexo: {sexo}")
        print(f"CPF: {cpf}")
        print(f"Especialidade: {especialidade}")
        print(f"Telefone: {telefone}")
        print(f"Código do setor: {codigo_setor}")
        #print(f"Código do Serviço: {codigo_servico}")
        print(f"Departamento: {departamento}")
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
    
        # Cria a janela de confirmação
        confirm_layout = [
            [sg.Text("Dados enviados com sucesso!")],
            [sg.Button("OK")],
        ]
        confirm_window = sg.Window("Confirmação", confirm_layout)
        
        # Aguarda até que o usuário feche a janela de confirmação
        while True:
            confirm_event, confirm_values = confirm_window.read()
            if confirm_event in (None, "OK"):
                break
        
        # Fecha a janela de confirmação
        confirm_window.close()
        
window.close()