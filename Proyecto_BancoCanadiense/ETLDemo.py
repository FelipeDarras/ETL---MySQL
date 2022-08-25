import os
import sys
import petl
import pymssql
import configparser
import requests
import datetime
import json
import decimal



# obtener datos
config = configparser.ConfigParser()
try:
    config.read('ETLDemo.ini')
except Exception as e:
    print('could not read configuration file:' + str(e))
    sys.exit()


# leer y obtener las variables del .ini
startDate = config['CONFIG']['startDate']
url = config['CONFIG']['url']
destServer = config['CONFIG']['server']
destDatabase = config['CONFIG']['database']

# hacer la request
try:
    BOCResponse = requests.get(url+startDate)
except Exception as e:
    print('could not make request:' + str(e))
    sys.exit()
# print (BOCResponse.text)

# creo las listas donde appendear los datos
BOCDates = []
BOCRates = []

# chequeo la response y convierto a objeto de python (dict)
if (BOCResponse.status_code == 200):
    BOCRaw = json.loads(BOCResponse.text)

    # extraer la data en las listas para formar las columnas
    for row in BOCRaw['observations']:
        BOCDates.append(datetime.datetime.strptime(row['d'],'%Y-%m-%d'))
        BOCRates.append(decimal.Decimal(row['FXUSDCAD']['v']))

    # crear tabla desde las listas appendeadas y renombrarlas
    exchangeRates = petl.fromcolumns([BOCDates,BOCRates],header=['date','rate'])

    # print (exchangeRates)

    # crear archivo excel para guardarlo
    try:
        expenses = petl.io.xlsx.fromxlsx('Expenses.xlsx',sheet='Github')
    except Exception as e:
        print('could not open expenses.xlsx:' + str(e))
        sys.exit()

    # join a las tablas
    expenses = petl.outerjoin(exchangeRates,expenses,key='date')

    # rellenar valores faltantes (fines de semana y feriados) con el ultimo dato obtenido (casi siempre viernes)
    expenses = petl.filldown(expenses,'rate')

    # borrar fechas sin gastos
    expenses = petl.select(expenses,lambda rec: rec.USD != None)

    # agregar la columna de Canadá
    expenses = petl.addfield(expenses,'CAD', lambda rec: decimal.Decimal(rec.USD) * rec.rate)
    
    # conexion a bd de SQL Server
    try:
        dbConnection = pymssql.connect(server=destServer,database=destDatabase)
    except Exception as e:
        print('could not connect to database:' + str(e))
        sys.exit()

    # Ingestar en tabla
    try:
        petl.io.todb (expenses,dbConnection,'Expenses')
    except Exception as e:
        print('could not write to database:' + str(e))
    print (expenses)