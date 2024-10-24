qVoici un CR de notre réunion: 

J'ai commencé par présenté les recherches bibliographiques sur le [Constitutional AI](https://arxiv.org/abs/2212.08073) et [l'allocation/optimisation du Test-Time Compute la puissance de calcul durant l'inférence](https://arxiv.org/pdf/2408.03314).

Le sujet du Constitutional AI m'a donné l'idée de m'interesser à la distillation de connaissance (Génération de données synthétiques par LLM + Entraînement de modèle spécifique).

J'ai présenté un papier de LREC-COLING 2024, [**Evolving Knowledge Distillation with Large Language Models and Active Learning**](https://aclanthology.org/2024.lrec-main.593.pdf) utilisant un LLM (ChatGPT - GPT 3.5) pour produire des données pseudos-annotées dans le but d'entrainer un BERT.

Voici une synthèse :
#### Objectif et Contexte
L'objectif de l'article est d'améliorer la distillation d'un LLM dans des petits modèles spécialisés, via une méthode permettant de générer uniquement des exemples utiles à l'entraînement du modèle étudiant.
Les auteurs utilisent une approche de **boîte noire**, où seul l'accès aux sorties du LLM est disponible pour générer des exemples d'entraînement.

#### Méthode : EvoKD
La méthode EvoKD combine la génération d'exemples et le ***l'apprentissage actif*** en plusieurs étapes:

1. **Initialisation** du modèle étudiant avec des données "few-shot".
2. Active Learning : 
	1. **Analyse des faiblesses** par un LLM pour identifier les exemples mal classifiés.
	2. **Génération d'exemples** par le LLM, classés en exemples **faciles** et **difficiles** pour éviter l'oubli catastrophique et mieux combler les lacunes du modèle.
	3. **Labelisation** automatique des exemples générés. 
3. **Évaluation** du modèle étudiant sur les nouveaux exemples.
4. **Réentraînement** du modèle étudiant sur ces nouveaux exemples.

Ce processus est itéré pour améliorer continuellement la performance du modèle étudiant.

#### Expérimentations et Résultats
Les auteurs ont évalué la méthode EvoKD sur des tâches:

- **Classification de texte** : 
	- Datasets: Amazon Reviews, IMDB, Inshorts, TouTiao News et  CAIL2019. 
	- Resultats: EvoKD atteint jusqu'à 90 % des performances full-shot avec seulement 1-shot + la méthode dépasse les alternatives.
- **Reconnaissance d'entités nommées (NER)**: 
	- Datasets: CoNLL03 et CoNLL04
	- Résultats: EvoKD montre de meilleures performances que les alternatives.
- **Etude d'ablation**: 
	- Montre l'importance des différents composants de la méthode: Génération d'exemples faciles, stratégie de révision, séparation des étapes de génération et d'étiquetage. 

### Questions et Hypothèses :

Ce papier m'a fait soulevé beaucoup questions:

- **Réduction de la dépendance aux LLMs coûteux** : Utilisation de petits modèles optimisés avec des techniques comme le **décodage adaptatif** pour générer des exemples de qualité.
- **Adaptation à d'autres domaines** : Exploration de la méthode dans des secteurs spécifiques comme la finance ou le médical et sur des tâches différentes.
- **Interprétabilité** : Analyse des **chain-of-thought** générés et du rôle des exemples faciles/difficiles dans l'apprentissage.
- **Nouveaux modes de prompting** : Exploration de méthodes comme l'utilisation de plusieurs LLMs (approche multi-agent) et l’apprentissage multitâche.

#### Est-ce que la combinaison de la génération dynamique d'exemples et de la conservation sélective pourrait surpasser l'approche actuelle ?

 **Incorporation de méthodes de Data Valuation** :
 
 -  La selection des exemples permettrait d'être parcimonieux dans la génération des exemples et donc permettrait d'obtenir un apprentissage plus rapide (moins d'étapes d'entrainement et plus économe en mémoire)

#### Est-il possible de produire des exemples d'annotations de bonne qualité tout en réduisant la dépendance aux GROS LLMs ?

**Optimisation des coûts de calcul** : 
   - L'**utilisation d'un décodage adaptatif**, tel que [CoT-decoding](https://arxiv.org/pdf/2402.10200) + Greedy decoding fonctionne-t-elle pour obtenir des bon echantillons avec des petits modèles ?

#### Vaut-il mieux générer avec un (petit) LLM multilingue ou un (gros) LLM monolingue et fine-tuner ?

Comparaison avec plusieurs langues 

- Traduction non bénéfique pour la performance (composition des erreurs (Qualité de Génération + Qualité de trad))
Langue Française.
#### **Adaptation à d'autres domaines et tâches** ? 

Banque/Finance
- NLU 
- QA
- Text Classification : 
	- Topic
	- Sentiment
	- NLI

Medical
- Jargon (FR) : 
	- NLI
	- QA

#### Interprétabilités des résultats
- Les Chain-of-Thoughts produites par le LLM ? 
- Impact de la conservation/pondération des exemples faciles et difficiles
- Facile/Difficiles ? Demander un niveau de difficulté ?
#### Exploration d'autres méthodes de prompting pour la génération

- Prompting de plusieurs LLM avec des directives différentes (Système multi-Agent)
- Apprentissage multi-tâches (plusieurs annotations en même temps)
- Apprentissage continu avec de nouvelles classes en même temps

#### Evolution de la représentation et représentativitée des données

Durant les cycles de génération apprentissage, comment évoluent mes classes ? 
Comment évoluent les représentations de mes exemples ? 

