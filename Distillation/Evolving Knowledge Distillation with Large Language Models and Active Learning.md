L'article intitulé [**Evolving Knowledge Distillation with Large Language Models and Active Learning**](https://aclanthology.org/2024.lrec-main.593.pdf) présente une méthode pour améliorer la distillation de LLM dans des petits modèles.
## Objectif
L'objectif est d'améliorer la distillation en améliorant la génération d'exemples. Pour ne générer que des exemples *utiles* pour l'apprentissage du petit modèle.

Les auteurs font une distinction entre 
- White-box distillation : Accès au poids et sortie du modèle pour distiller. 
- Black-Box distillation: Seul les données de sortie sont disponibles mais souvent des modèles plus performant. (Zero-Gen, AugGPT)
Ici les auteurs utilisent un LLM comme generateur de données synthétique mais aussi comme labelisateur et evaluateur du modèle student.
## Méthode

![[Schema.png]]
Pour ce faire les auteurs incorpore de ***"Apprentissage Actif"***  durant la génération des exemples.
La méthode comporte 2 étapes:
1. **Apprentissage du modèle Student**: Le modèle student est initialisé avec des données de fewshots.
2. Le LLM est prompté pour en plusieurs étapes: 
	1. ***Analyse des faiblesses*** : Le but est identifié les exemples sur lesquels le modèle a échoué et synthétiser cette information pour guider le LLM dans la génération de nouveaux exemples. (Comme un Chain-Of-Thought de)
	2. Génération d'exemples : Le but est de générer un lot de nouveaux exemple d'entraînement.
	   Il y a 2 catégories : les exemples **faciles** et **difficiles**. Ceci permet au modèle de ne pas perdre en performance sur les exemples déjà bien classifiés (les auteurs parle de catastrophe forgetting)
	3. **Évaluation**: Le modèle est testé sur les nouvelles données générées. Les prédictions seront utilisé à la prochaine itération pour générer les nouvelles données.
	   
3. Enfin le modèle est fine-tuné sur les nouvelles données. Et on revient à l'étape 1. 

![[ExamplePromptdistillation.pdf]]
## Expériences :


Le document **"Evolving Knowledge Distillation with Large Language Models and Active Learning"** présente le cadre EvoKD et valide son efficacité à travers une série d'**expériences** centrées sur des tâches de **classification de texte** et de **reconnaissance d'entités nommées (NER)** dans des contextes d'apprentissage avec peu d'exemples (few-shot). Voici une analyse détaillée des expériences réalisées et des méthodes de mesure des résultats.

### 1. **Expériences de classification de texte avec peu d'exemples**
Ces expériences visent à évaluer les performances d'EvoKD dans des configurations **few-shot** pour la classification de texte, où seul un nombre limité d'exemples étiquetés (par ex., 1-shot, 3-shot, ou 5-shot) est disponible pour entraîner le modèle étudiant.

#### **Jeux de données** :
Cinq jeux de données de classification de texte sont utilisés :
- **Amazon Reviews** (classification binaire des sentiments)
- **IMDB** (classification binaire des sentiments)
- **Inshorts News** (classification des nouvelles en cinq catégories)
- **TouTiao News** (classification des nouvelles en 14 catégories)
- **CAIL2019** (classification de textes juridiques chinois en trois catégories)

#### **Configuration de l'entraînement** :
- Dans chaque expérience, le modèle étudiant est entraîné avec des données **1-shot**, **3-shot**, et **5-shot**.
- EvoKD est comparé à plusieurs modèles de référence, tels que **No Augmentation**, **EDA (Easy Data Augmentation)**, **ZeroGen**, **SunGen**, **AugGPT**, et une méthode de distillation statique.

#### **Principales variantes d'EvoKD** :
- **EvoKD** : Le cadre itératif proposé, qui génère dynamiquement des échantillons faciles et difficiles en fonction des performances et des faiblesses du modèle étudiant.
- **EvoKD + Init** : EvoKD avec une phase d'initialisation où le modèle étudiant est d'abord entraîné avec des données générées par **AugGPT** pendant les premières époques, avant de passer à EvoKD.

#### **Mesures** :
- **F1 Score** : L'indicateur principal est le **score F1**, qui équilibre la précision et le rappel. Le document rapporte le **score F1 moyen** et l'**écart-type** à travers plusieurs essais (semences aléatoires de 1 à 5).
- **Écart-type du F1** : Cela mesure la variabilité des performances du modèle à travers différents essais, indiquant sa stabilité.
- **Comparaison avec full-shot** : Les performances d'EvoKD en mode few-shot (1, 3 ou 5 shots) sont comparées aux résultats en **full-shot**, où le modèle est entraîné sur l'ensemble du jeu de données. L'objectif est de voir à quel point les résultats few-shot se rapprochent des performances full-shot.

#### **Résultats expérimentaux** :
- EvoKD a atteint jusqu'à **90 % des performances full-shot** en utilisant seulement des échantillons **1-shot** sur plusieurs jeux de données. Par exemple :
  - Sur **Amazon Reviews**, EvoKD atteint un score F1 de **84,25 %** avec des données 1-shot.
  - Sur **Inshorts News**, EvoKD atteint **85,16 %** avec 1-shot.
- **EvoKD + Init** améliore encore les performances sur certains jeux de données, en particulier pour des classifications complexes à plusieurs classes comme **TouTiao News**.
- EvoKD surpasse systématiquement **AugGPT** et les autres références en termes de précision (score F1) et de stabilité (écart-type plus faible).

#### **Analyse de l'efficacité des tokens** :
Pour mesurer l'**efficacité computationnelle** d'EvoKD, les auteurs suivent le nombre de **tokens** utilisés lors des interactions entre le LLM et le modèle étudiant (via l'API OpenAI). EvoKD utilise plus de tokens au départ (en raison de l'analyse supplémentaire des faiblesses du modèle étudiant), mais il obtient de meilleures améliorations à long terme du score F1 comparé à **AugGPT**. Après **8000 tokens** d'interaction, EvoKD dépasse significativement AugGPT, montrant une meilleure efficacité à long terme.

### 2. **Expériences de reconnaissance d'entités nommées (NER) avec peu d'exemples**
Les expériences NER évaluent comment EvoKD peut gérer des tâches de reconnaissance d'entités avec très peu d'exemples étiquetés.

#### **Jeux de données** :
Deux jeux de données NER bien connus sont utilisés :
- **CoNLL03** (jeu de données anglais avec trois types d'entités : personne, lieu, organisation)
- **CoNLL04** (similaire à CoNLL03 mais plus petit, avec moins de types d'entités)

#### **Configuration de l'entraînement** :
- Comme pour la classification de texte, le modèle étudiant est entraîné avec des données **1-shot** pour la NER, c'est-à-dire un seul exemple étiqueté par type d'entité.
#### **Mesures** :
- **Score F1** : Pour la NER, le score F1 mesure la capacité du modèle à identifier correctement à la fois le **type d'entité** et le **texte de l'entité** dans la phrase d'entrée.
- **F1 moyen** : Le document rapporte le score F1 moyen sur les deux jeux de données NER.

#### **Résultats expérimentaux** :
- EvoKD obtient les meilleures performances sur les deux jeux de données NER, surpassant des références comme AugGPT et EDA.
  - Sur **CoNLL04**, EvoKD atteint un score F1 de **68,48 %**, légèrement supérieur aux **66,83 %** d'AugGPT.
  - EvoKD avec initialisation obtient des performances similaires, mais dans certains cas, EvoKD sans initialisation fait mieux.

### 3. **Étude d'ablation**
Une **étude d'ablation** est réalisée pour évaluer les contributions de composants spécifiques du cadre EvoKD. Les auteurs testent EvoKD dans différentes configurations, en supprimant certains composants un par un pour voir comment les performances du modèle évoluent.

#### **Variantes d'ablation** :
- **sans Easy** : EvoKD sans génération d'échantillons faciles. Seuls des échantillons difficiles sont utilisés.
- **sans Correct** : EvoKD sans inclure les échantillons correctement classifiés dans l'analyse du LLM.
- **sans Review** : EvoKD sans stratégie d'**historique de révision**, où les échantillons précédemment générés sont réutilisés périodiquement.
- **sans Séparation** : EvoKD sans séparer les étapes de génération et d'étiquetage des textes (le LLM génère le texte et l'étiquette en une seule étape).

#### **Résultats de l'ablation** :
- L'absence d'**échantillons faciles** provoque la plus grande baisse de performance, soulignant leur importance pour prévenir le surapprentissage et l'oubli catastrophique.
- L'absence de la **stratégie de révision** ou de la **séparation des étapes de génération et d'étiquetage** réduit également les performances, diminuant les scores F1.

### 4. **Analyse de l'adaptabilité**
Les auteurs réalisent une **analyse de l'adaptabilité** pour montrer comment EvoKD ajuste sa stratégie de génération d'échantillons en fonction des performances du modèle étudiant pendant l'entraînement. 
Ils suivent comment le nombre d'échantillons générés pour différentes classes évolue dans le jeu de données **TouTiao News**, montrant qu'EvoKD génère plus d'échantillons pour les catégories ayant des scores F1 initiaux plus faibles, améliorant ainsi les performances de ces catégories.

### Résumé des principaux résultats :
- **EvoKD** améliore considérablement les performances des modèles étudiants dans des scénarios d'apprentissage avec peu d'exemples, notamment pour les tâches de **classification de texte** et de **NER**.
- Il surpasse les méthodes statiques de distillation des connaissances et les techniques d'augmentation de données telles qu'**AugGPT**.
- Le **boucle de rétroaction dynamique** (analyse des faiblesses, génération de nouveaux échantillons, réentraînement, répétition) conduit à un entraînement plus stable et plus efficace que les approches statiques.
- EvoKD est hautement **efficace en termes de tokens** à long terme, malgré une consommation initiale plus élevée de tokens lors des interactions avec le LLM.

## Questions de recherche :
Nous sommes dans un cadre de continual learning avec des données synthétiques.
Pourquoi ne pas utiliser des méthodes de continual learning ? **Replay-Based Methods** + Data Valuation Method. 
	
Est-ce que cette performance peut-être réaliser avec moins de puissance de calcul ? 
Utilisation de petit modèle bien entrainé + décodage Adaptatif pour générer la séquence de Chain-of-thoughts d'active learning ?

### Est-ce que la combinaison de la génération dynamique d'exemples et de la conservation sélective pourrait surpasser l'approche actuelle ?

 **Incorporation de méthodes de Data Valuation** :
	-  La selection des exemples permettrait d'être parcimonieux dans la génération des exemples et donc permettrait d'obtenir un apprentissage plus rapide (moins d'étapes d'entrainement et plus économe en mémoire)

### Est-il possible de produire des exemples d'annotations de bonne qualité tout en réduisant la dépendance aux GROS LLMs ?

**Optimisation des coûts de calcul** : 
   - L'**utilisation d'un décodage adaptatif**, tel que [CoT-decoding](https://arxiv.org/pdf/2402.10200) + Greedy decoding fonctionne-t-elle pour obtenir des bon echantillons avec des petits modèles ?

### Vaut-il mieux générer avec un (petit) LLM multilingue ou un (gros) LLM monolingue et fine-tuner ?

Comparaison avec plusieurs langues 

- Traduction non bénéfique pour la performance (composition des erreurs (Qualité de Génération + Qualité de trad))
Langue Française.
### **Adaptation à d'autres domaines et tâches** ? 

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

### Interprétabilités des résultats
- Les Chain-of-Thoughts produites par le LLM ? 
- Impact de la conservation/pondération des exemples faciles et difficiles
- Facile/Difficiles ? Demander un niveau de difficulté ?

### Exploration d'autres méthodes de prompting pour la génération

- Prompting de plusieurs LLM avec des directives différentes (Système multi-Agent)
- Apprentissage multi-tâches (plusieurs annotations en même temps)
- Apprentissage continu avec de nouvelles classes en même temps

### Evolution de la représentation et représentativitée des données

Durant les cycles de génération apprentissage, comment évoluent mes classes ? 
Comment évoluent les représentations de mes exemples ? 
