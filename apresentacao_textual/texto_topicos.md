# Descrição e Características do paradigma de armazenamento e Principais tipos de aplicações em que usam o paradigma (redes sociais, etc)
Este paradigma faz uso da teoria de grafos. Utilizando nós para representar entidades e arestas para representar quaisquer formas de conexões entre elas. Por isso, a ideia é que ele seja utilizado em casos aonde os relacionamentos são o que realmente importa, o que mais tem valor em termos de analise. Isso inclui casos como redes sociais, motores de recomendação, detecção de fraudes, etc.

# Visão Geral do SGBD Neo4j
Neo4j é o SGBD pioneiro e um dos principais no mercado para o uso do paradigma Graph Store. Implementa o modelo *property-graph*, e suas consultas são realizadas a partir de sua própria linguagem declarativa, Cypher. Cypher é capaz de realizar consultas envolvendo busca e padrões de relacionamento nos grafos de forma simples e legivel, precisando de apenas uma linha para realizar o que o banco de dados relacional faria com JOINs e recursões.


# Arquitetura do SGBD Neo4j
O núcleo é ACID e persiste dados em um formato de armazenamento próprio para grafos. Um planejador Cypher otimiza consultas que o *kernel* executa apoiado em múltiplos níveis de cache. Na Enterprise, instâncias formam *Causal Clusters*: nós Core (consenso Raft) e *Read Replicas* que recebem *streaming* assíncrono, oferecendo leitura massivamente paralela. A versão 2025 passou a exigir Java 21 e traz melhorias no tempo de plano paralelo.


# Escalabilidade do banco e suas características
Neo4j escala verticalmente com muita RAM (grau alto de *in-memory* caching) e, desde a versão 5, horizontalmente via Causal Clustering. A Enterprise 2025 acrescentou *sharding* automático (“Fabric 2.0”), permitindo distribuir partes do grafo por nós diferentes e prometendo “escalabilidade ilimitada” de leitura e escrita, além de replicação contínua para alta disponibilidade.&#x20;


# Aplicações reais que usam o SGBD no mercado
Organizações como NASA, eBay, UBS, Cisco, Airbus e Walmart usam Neo4j para recomendação em tempo real, detecção de anéis de fraude, mapeamento de redes de telecom, análise de impacto em cadeias de suprimento e descoberta de medicamentos, comprovando robustez em cenários produtivos de grande escala.&#x20;


# Endereço do Provedor (se on-line) / Local para download, Forma de licenciamento (Licença pessoal, livre, etc)
O provedor é a Neo4j Inc. (neo4j.com). Downloads para Windows, macOS, Linux e Docker ficam em *neo4j.com/download*; imagens cloud estão em Marketplaces AWS/Azure e o SaaS fica em AuraDB. Community Edition é GPL v3 e gratuita; Enterprise requer assinatura ou *pay-as-you-go* na nuvem; o código-fonte central continua aberto.



# Principais vantagens (pontos fortes - motivo para usar)
*Travessias profundas* em tempo quase constante, modelo de dados intuitivo, Cypher expressivo, transações ACID, ecossistema maduro (Browser, Desktop, Bloom, GDS), integração fácil via drivers oficiais e extensões (APOC) fazem do Neo4j a escolha de fato quando as perguntas dependem de relacionamentos ricos e mutáveis.&#x20;


# Principais desvantagens (pontos fracos - motivo para evitar)
A curva de aprendizado para quem vem apenas de SQL, custo da licença Enterprise em produção crítica, consultas de varredura global menos eficientes que em colunar/relacional e a operação de clusters (monitoramento, *tuning*, upgrades de Java 21) exigem equipe especializada; além disso, apesar do novo sharding, grafos ultra-massivos ainda podem demandar particionamento lógico cuidadoso.


# Apresentar a implementação de um CRUD em um banco relacional e no paradigma NoSQL escolhido