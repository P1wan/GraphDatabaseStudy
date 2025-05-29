| **1. Preparar ambiente** | 
*Instale SQLite 3* (pacote `sqlite3` em Linux ou binário oficial para Windows). 
Crie uma pasta de trabalho com os CSVs `gaia.csv`, `kepler.csv` e `matches.csv` (pares `gid,kid`). |



| **2. Abrir shell** | 
```bash
sqlite3 astro.db```. Ative chave estrangeira: `PRAGMA foreign_keys = ON;`. |


| **3. Criar esquema** | ```sql
-- Catálogos individuais
CREATE TABLE gaia( gid TEXT PRIMARY KEY, ra REAL, dec REAL, mag REAL );
CREATE TABLE kepler( kid TEXT PRIMARY KEY, ra REAL, dec REAL, mag REAL );

-- Relações de equivalência N-N
CREATE TABLE same_star(
    src_cat TEXT NOT NULL, src_id TEXT NOT NULL,
    dst_cat TEXT NOT NULL, dst_id TEXT NOT NULL,
    PRIMARY KEY (src_cat,src_id,dst_cat,dst_id)
);
CREATE INDEX idx_same_src ON same_star(src_cat,src_id);
CREATE INDEX idx_same_dst ON same_star(dst_cat,dst_id);``` |


| **4. Importar dados** | ```sql
.mode csv
.import gaia.csv gaia
.import kepler.csv kepler
.import matches.csv same_star``` |


| **5. Inserir correspondência (CRUD - Create)** | ```sql
INSERT INTO same_star VALUES ('Gaia','4379…','Kepler','KIC 11446443');``` |


| **6. Buscar todas as identificações equivalentes a um `gid` (Read)** | ```sql
WITH RECURSIVE closure(cat,id) AS (
  SELECT 'Gaia', '4379…'                -- ponto de partida
UNION
  SELECT dst_cat,dst_id FROM same_star s
    JOIN closure c ON s.src_cat=c.cat AND s.src_id=c.id
UNION
  SELECT src_cat,src_id FROM same_star s
    JOIN closure c ON s.dst_cat=c.cat AND s.dst_id=c.id
)
SELECT * FROM closure;``` |


| **7. Atualizar coordenadas em todas as entradas equivalentes (Update)** | ```sql
WITH RECURSIVE closure(cat,id) AS (… mesma CTE …)
UPDATE gaia SET ra=$ra, dec=$dec WHERE gid IN (SELECT id FROM closure WHERE cat='Gaia');
UPDATE kepler SET ra=$ra, dec=$dec WHERE kid IN (SELECT id FROM closure WHERE cat='Kepler');``` |


| **8. Remover uma estrela e suas arestas (Delete)** | ```sql
DELETE FROM gaia WHERE gid='4379…';
DELETE FROM same_star WHERE src_cat='Gaia' AND src_id='4379…'
                      OR dst_cat='Gaia' AND dst_id='4379…';``` |


| **9. Testar desempenho** | Use `.timer ON` no shell e execute a consulta de passo 6 com 1, 2, 3… milhões de registros para coletar tempo médio e `EXPLAIN QUERY PLAN`. Compare com `PROFILE` do Cypher análogo. |


| **10. Documentar comparação** | Gere tabela com latência média, p95 e contagem de linhas lidas. Inclua na apresentação os gargalos: índice composto + custo de expansão recursiva vs. travessia pointer-to-pointer em Neo4j. |