- objetivo desse guia:  visão geral teórica sobre: 
	- Graph Store
		- *(Paradigma de bancos de dados em grafo)*
	- Neo4j
		- *(Um SGBD para esse paradigma)*

## 1. Descrição e Características do Paradigma Graph Store

### 1.1 O que é um Banco de Dados em Grafo?
- é um tipo de banco de dados NoSQL (Not Only SQL) 
	- ***NÃO*** organiza dados em tabelas com linhas e colunas e 
	- pra conetar informações, ***NÃO*** depende de chaves estrangeiras e operações de JOIN
- para dados cujas conexões/relacionamentos ***são tão importantes quanto os próprios dados!!!***
- estrutura mais intuitiva e flexível 
	- teoria dos grafos.

A estrutura fundamental de um banco de dados em grafo consiste em:

*   **Nós (Nodes):** 
	* Entidades/objetos do domínio 
	* ex: 
		* Pessoas
		* Empresas
		* Produtos
		* Contas
*  **Relacionamentos:** 
	* Conexões/Associações entre os nós
	* (Arestas)
	* ex: 
		* AMIGO_DE
		* TRABALHA_EM
		* COMPROU
		* TRANSFERIU_PARA
	* têm sempre:
		* uma direção
			* Nó de origem -> Nó de destino
		* um tipo
			* descreve a natureza da conexão



### 1.2 Principais Tipos de Aplicações desse paradigma
- São especialmente adequados em casos onde os relacionamentos/conexões são **cruciais** para análise e tomada de decisão.

Exemplos:
*   **Redes Sociais:** 
	* Mapear conexões entre usuários (amizades, seguidores, grupos), 
	* analisar influência, 
	* sugerir conexões.
*   **Sistemas de Recomendação:** 
	* Recomendar produtos/conteúdos/serviços 
	* com base nas 
		* conexões entre usuários, 
		* itens e 
		* preferências 
	* ex:
		* "clientes que compraram X também compraram Y"
		* "amigos que gostaram de Z"
* **Detecção de Fraudes:** 
	* Identificar padrões suspeitos em 
		* transações financeiras, 
		* seguros ou 
		* telecomunicações, 
	* analisando conexões entre:
		* contas, dispositivos e atividades.
*   **Gerenciamento de Redes e Infraestrutura:** 
	* Modelar redes de 
		* computadores, 
		* telecomunicações 
		* ou logística, 
	* analisar dependências, 
	* identificar pontos de falha
	* otimizar rotas.
*   **Análise de Impacto e Dependências:**
	* Em uma cadeia de suprimentos, entender como estão conectados: componentes de software, processos de negócios ou elementos de uma cadeia de suprimentos estão interconectados
	* e qual o impacto de mudanças.
* **Gerenciamento de Conhecimento:**
	* Organizar e conectar informações complexas, como em bases de conhecimento, catálogos de metadados ou pesquisas científicas.

## 2. Visão Geral do Neo4j

### 2.1 História e Evolução

Neo4j é um dos SGBDs em grafo mais populares e maduros do mercado. Desenvolvido pela Neo4j, Inc. (originalmente Neo Technology), teve seu início em 2000 e a primeira versão pública foi lançada em 2007. Foi pioneiro na implementação do modelo de grafo de propriedades e na criação da linguagem de consulta Cypher. Ao longo dos anos, evoluiu significativamente, incorporando recursos de escalabilidade, alta disponibilidade e ferramentas de desenvolvimento e visualização, consolidando-se como líder no quadrante mágico do Gartner para bancos de dados em grafo.

### 2.2 Conceitos Fundamentais

O Neo4j implementa o **Property Graph Model**, que inclui os seguintes elementos:

*   **Nós (Nodes):** As entidades básicas. Podem ter zero ou mais **Labels** (rótulos) que os classificam (ex: `:Person`, `:Movie`, `:Product`). Um nó pode ter múltiplos labels (ex: `:Person:Actor`).
*   **Relacionamentos (Relationships):** Conexões direcionadas entre dois nós (um nó pode ter um relacionamento consigo mesmo). Cada relacionamento tem exatamente um **Tipo** (ex: `:ACTED_IN`, `:DIRECTED`, `:FRIENDS_WITH`).
*   **Propriedades (Properties):** Pares chave-valor armazenados em nós e relacionamentos para guardar dados específicos (ex: `name: "Tom Hanks"`, `born: 1956`, `roles: ["Forrest"]`).
*   **Traversals e Paths:** A navegação através dos relacionamentos para encontrar nós conectados é chamada de traversal. Uma sequência de nós e relacionamentos conectados forma um *path* (caminho).

### 2.3 Linguagem de Consulta Cypher

Cypher é a linguagem de consulta declarativa do Neo4j, projetada para ser intuitiva e expressiva ao trabalhar com grafos. Sua sintaxe utiliza padrões visuais ASCII-art para representar nós `()` e relacionamentos `-->`, `<--`, `--`.

Exemplo básico de consulta Cypher para encontrar um ator e os filmes em que atuou:

```cypher
MATCH (actor:Person {name: "Tom Hanks"})-[:ACTED_IN]->(movie:Movie)
RETURN actor.name, movie.title
```

Esta consulta busca por um nó com o label `Person` e a propriedade `name` igual a "Tom Hanks", que tenha um relacionamento do tipo `ACTED_IN` apontando para nós com o label `Movie`. Ela retorna o nome do ator e o título dos filmes encontrados.

## 3. Arquitetura do Neo4j

### 3.1 Componentes Principais

A arquitetura do Neo4j é otimizada para performance em grafos. Seus componentes chave incluem:

*   **Kernel:** O núcleo do banco de dados, responsável pela gestão das transações ACID e operações de baixo nível.
*   **Gerenciamento de Armazenamento:** Neo4j utiliza um formato de armazenamento nativo otimizado para grafos, onde nós e relacionamentos são armazenados de forma a permitir traversals rápidos. Os dados são persistidos em disco.
*   **Cache:** Múltiplos níveis de cache (cache de nós, relacionamentos, propriedades) são usados para manter dados frequentemente acessados em memória, acelerando as consultas.
*   **Processador de Consultas Cypher:** Responsável por analisar (parse), planejar e executar as consultas Cypher, otimizando o acesso aos dados no grafo.

### 3.2 Edições Disponíveis

Neo4j oferece diferentes edições para atender a diversas necessidades:

* **Community Edition (CE):** Versão gratuita e open-source (GPLv3), totalmente funcional para desenvolvimento e implantações em um único servidor. Ideal para aprendizado e projetos menores.
* **Enterprise Edition (EE):** Versão comercial que adiciona recursos essenciais para produção e larga escala, como clustering (alta disponibilidade e escalabilidade horizontal de leitura), backups online, segurança avançada (controle de acesso baseado em roles, integração LDAP) e suporte técnico.
* **AuraDB:** Serviço de banco de dados em grafo totalmente gerenciado na nuvem (DBaaS - Database as a Service), oferecido pela Neo4j. Simplifica a operação e escalabilidade, com modelo de pagamento baseado no uso.

### 3.3 Arquitetura de Implantação

* **Standalone:** 
	* Implantação em um único servidor, comum para a Community Edition ou para ambientes de desenvolvimento/teste da Enterprise Edition.
* **Causal Clustering (EE):**
	* Arquitetura distribuída para a Enterprise Edition. Consiste em um conjunto de servidores Core (que participam do consenso Raft para garantir a consistência das escritas) e servidores Read Replica (que recebem atualizações dos Cores e servem para escalar as leituras). Garante alta disponibilidade (failover automático) e escalabilidade de leitura.




## 4. Escalabilidade do Neo4j e suas Características

A escalabilidade refere-se à capacidade de um sistema de lidar com um aumento na carga de trabalho (mais dados, mais usuários, mais consultas). Neo4j oferece diferentes abordagens para escalabilidade:

### 4.1 Escalabilidade Vertical (Scale-Up)

Consiste em aumentar os recursos de um único servidor (mais CPU, mais RAM, discos mais rápidos). Neo4j escala bem verticalmente, especialmente para leituras, devido ao seu armazenamento nativo e gerenciamento de cache. No entanto, há limites físicos e de custo para a escalabilidade vertical.

### 4.2 Escalabilidade Horizontal (Scale-Out) - Enterprise Edition

Consiste em distribuir a carga por múltiplos servidores. Para Neo4j, isso é primariamente alcançado através do **Causal Clustering** na Enterprise Edition:

*   **Escalabilidade de Leitura:** Adicionando mais servidores Read Replica, as consultas de leitura podem ser distribuídas, aumentando a capacidade total de leitura do cluster.
*   **Escalabilidade de Escrita:** A escalabilidade de escrita é mais desafiadora. Embora o cluster possa lidar com mais escritas concorrentes do que um servidor único, todas as escritas ainda precisam passar pelos servidores Core e alcançar consenso (via protocolo Raft), o que pode se tornar um gargalo em cenários de altíssima taxa de escrita. Neo4j não suporta *sharding* nativo (particionamento automático do grafo em múltiplos clusters independentes) da mesma forma que alguns outros bancos NoSQL, o que limita a escalabilidade horizontal de escrita para grafos extremamente grandes que não cabem em um único cluster.

### 4.3 Desafios de Escalabilidade

*   **Escrita:** A principal limitação é a escalabilidade horizontal de escrita para grafos massivos.
*   **"Super Nodes":** Nós com um número extremamente alto de relacionamentos podem impactar a performance de certas consultas. Estratégias de modelagem podem mitigar isso.
*   **Complexidade do Cluster:** Gerenciar um cluster Enterprise requer mais conhecimento e esforço operacional do que um servidor standalone.

## 5. Aplicações Reais que Usam Neo4j no Mercado

Neo4j é utilizado por diversas empresas líderes em vários setores para resolver problemas complexos relacionados a dados conectados:

*   **Serviços Financeiros:** Detecção de fraude em tempo real (ex: análise de anéis de fraude), compliance (KYC - Know Your Customer), gerenciamento de risco.
*   **Varejo e E-commerce:** Motores de recomendação personalizados, análise de carrinho de compras, gerenciamento de cadeia de suprimentos, otimização de inventário.
*   **Telecomunicações:** Gerenciamento de redes, análise de dependência de serviços, otimização de infraestrutura.
*   **Governo e Defesa:** Análise de inteligência, segurança cibernética, investigações.
*   **Ciências da Vida e Saúde:** Descoberta de medicamentos, análise de interações proteicas, gerenciamento de dados de pacientes.
*   **Tecnologia:** Gerenciamento de identidade e acesso, análise de dependências em microsserviços, redes sociais.

Empresas como **NASA, eBay, Walmart, UBS, Cisco, Airbus, Volvo, Adobe** e muitas outras utilizam Neo4j em produção.

## 6. Endereço do Provedor e Licenciamento

*   **Site Oficial:** [https://neo4j.com/](https://neo4j.com/)
*   **Download:** [https://neo4j.com/download/](https://neo4j.com/download/) (Inclui Neo4j Server, Desktop, etc.)
*   **Ferramentas:**
    *   **Neo4j Desktop:** Ambiente de desenvolvimento local que gerencia bancos de dados e extensões.
    *   **Neo4j Browser:** Interface web para executar consultas Cypher e visualizar resultados.
    *   **Neo4j Bloom:** Ferramenta de visualização e exploração de grafos para usuários de negócios.
*   **Licenciamento:**
    *   **Community Edition:** Licença **GPLv3** (gratuita e open-source).
    *   **Enterprise Edition:** Licença **Comercial** (paga), necessária para recursos como clustering, backup online, segurança avançada.
    *   **AuraDB (Cloud):** Modelo de **pagamento por uso**, baseado nos recursos consumidos.

## 7. Principais Vantagens (Pontos Fortes)

*   **Performance em Consultas de Relacionamentos:** Extremamente rápido para atravessar conexões (traversals), especialmente em consultas com múltiplos níveis de profundidade (ex: "encontre amigos de amigos de amigos"). Elimina a necessidade de JOINs custosos.
*   **Modelagem Intuitiva e Flexível:** O modelo de grafo de propriedades se assemelha a como pensamos sobre dados conectados (como um diagrama em um quadro branco). É fácil adicionar novos tipos de nós, relacionamentos e propriedades sem reestruturar todo o banco (schema flexível).
*   **Linguagem Cypher:** Declarativa, expressiva e relativamente fácil de aprender para consultas em grafo. A sintaxe visual facilita a compreensão dos padrões de consulta.
*   **ACID:** Neo4j oferece transações ACID completas, garantindo a consistência e durabilidade dos dados, o que é um diferencial em relação a muitos outros bancos NoSQL.
*   **Ecossistema Maduro:** Possui uma comunidade ativa, boa documentação, drivers para diversas linguagens de programação e ferramentas como Desktop, Browser e Bloom.

## 8. Principais Desvantagens (Pontos Fracos)

*   **Escalabilidade de Escrita Horizontal:** Como mencionado, o sharding nativo não é suportado, limitando a escalabilidade de escrita para grafos que excedem a capacidade de um único cluster.
*   **Consultas de Agregação Global:** Consultas que precisam analisar *todos* os nós ou relacionamentos (sem iniciar por um ponto específico) podem ser menos eficientes do que em bancos de dados otimizados para análise colunar ou relacional.
*   **Curva de Aprendizado:** Requer uma mudança de mentalidade para equipes acostumadas apenas com o modelo relacional. A modelagem de dados em grafo e a otimização de Cypher exigem aprendizado específico.
*   **Custo da Enterprise Edition:** Os recursos avançados necessários para produção em larga escala (clustering, backup online) estão disponíveis apenas na versão paga.

## 9. Comparação Teórica: Relacional vs. Grafo

| Característica              | Banco Relacional (SQL)                    | Banco de Grafo (Neo4j)                                                          |
| :-------------------------- | :---------------------------------------- | :------------------------------------------------------------------------------ |
| **Modelo de Dados**         | Tabelas (linhas, colunas)                 | Grafos (Nós, Relacionamentos, Propriedades)                                     |
| **Relacionamentos**         | Chaves Estrangeiras, JOINs                | Conexões diretas (armazenadas)                                                  |
| **Consulta**                | SQL                                       | Cypher (ou outras linguagens de grafo)                                          |
| **Performance (Conexões)**  | Lenta com muitos JOINs (profundidade)     | Rápida para traversals (profundidade)                                           |
| **Performance (Agregação)** | Geralmente rápida para agregações globais | Pode ser mais lenta para agregações globais                                     |
| **Schema**                  | Rígido (definido antes da inserção)       | Flexível (opcional ou implícito)                                                |
| **Casos de Uso Fortes**     | Dados tabulares, relatórios, BI           | Dados conectados, redes, recomendações                                          |
| **Escalabilidade**          | Boa escalabilidade horizontal (sharding)  | Boa escalabilidade vertical e de leitura (EE), escrita limitada horizontalmente |

**Em resumo:** Bancos relacionais são ótimos para dados estruturados e tabulares onde as consultas envolvem agregações sobre grandes conjuntos de dados. Bancos de grafo brilham quando os relacionamentos entre os dados são o foco principal e as consultas envolvem navegar por essas conexões.

---

*Este guia foca nos aspectos teóricos. Para detalhes de implementação (instalação, comandos CRUD específicos, configuração avançada), consulte a documentação oficial do Neo4j e os tutoriais práticos.*

