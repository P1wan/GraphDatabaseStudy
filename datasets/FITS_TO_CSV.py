from astropy.table import Table
from astropy import units as u

# Define custom units
u.def_unit('dex', u.dimensionless_unscaled)
u.def_unit('log(cm.s**-2)', u.dimensionless_unscaled)

# SE NÃO ESTIVER EXECUTANDO DA RAIZ DO PROJETO, COMENTE A LINHA ABAIXO E DESCOMENTE A SEGUINTE
path = 'datasets/'
# path = ''

data = Table.read(path + 'kepler_dr3_good.fits', format='fits')
data.write(path + 'matches.csv', format='csv', overwrite=True)
