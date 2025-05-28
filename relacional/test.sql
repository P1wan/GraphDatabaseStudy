
-- -- EXECUÇÃO:
-- sqlite3 banco.db < test.sql

-- Catalogos
CREATE TABLE gaia( gid TEXT PRIMARY KEY, ra REAL, dec REAL, mag REAL );
CREATE TABLE kepler( kid TEXT PRIMARY KEY, ra REAL, dec REAL, mag REAL );

-- Mesma estrela
CREATE TABLE same_star(
    src_cat TEXT NOT NULL, src_id TEXT NOT NULL,
    dst_cat TEXT NOT NULL, dst_id TEXT NOT NULL,
    PRIMARY KEY (src_cat,src_id,dst_cat,dst_id)
);
CREATE INDEX idx_same_src ON same_star(src_cat,src_id);
CREATE INDEX idx_same_dst ON same_star(dst_cat,dst_id);

-- Importar dados
.mode csv
.import ../datasets/dataGaia.csv gaia
.import ../datasets/kepler_stellar_17.csv kepler
-- .import ../datasets/matches.csv same_star