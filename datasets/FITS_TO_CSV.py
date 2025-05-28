from astropy.table import Table

t = Table.read('kepler_dr3_good.fits')
t.write('matches.csv', format='csv')