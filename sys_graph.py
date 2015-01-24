#!/usr/bin/env python
#visualiza las estadísticas de la recolección hecha por sar

import numpy as np
import matplotlib.pyplot as plot
import matplotlib.dates as mdates
from datetime import datetime

col_headers = ['fecha', 'user', 'system', 'iowait', 'idle']

convertdate = lambda x: datetime.strptime(x, '%Y-%m-%d %H:%M:%S UTC')

data = np.genfromtxt('output.csv', delimiter=';', usecols=(2,4,6,7,9), skip_header=1, names=col_headers, converters={'fecha': convertdate}, dtype=None)

fechas =data['fecha']
usuario = data['user']
sistema = data['system']
disco = data['iowait']
inactivo = data['idle']

plot.plot_date(fechas, usuario, fmt="-", label="usuario")
plot.plot_date(fechas, sistema, fmt="-", label="sistema")
plot.plot_date(fechas, disco, fmt="-", label="I/O disco")
plot.plot_date(fechas, inactivo, fmt="--", label="inactivo")

plot.legend(loc='best')

formatter = mdates.AutoDateFormatter('fechas')
plot.xticks(rotation=45)

plot.show()
