L'article **Empowering Large Language Models for Textual Data Augmentation** propose une approche appelée **Self-LLMDA**, pour améliorer les méthodes de d'augmentation de données par les LLM.

### Objectif et hypothèse

L'objectif de ce papier est de résoudre les limitations des méthodes actuelles d'augmentation de données basées sur les LLM:

- Design manuel des instructions d'augmentations de données.
- Les augmentations sont peu spécifiques à la tâche.

L'hypothèse est que **Les LLMs peuvent générer des instructions d'augmentation et l'apprentissage d'un modèle de sélection des instructions d'augmentation** peut conduire à des données augmentées plus pertinentes et spécifiques à la tâche, améliorant ainsi les performances dans diverses tâches de traitement du langage naturel (NLP).

### Approche

Les auteurs présentent **Self-LLMDA** qui comporte deux phases :

1. **Génération d'instructions** : Un LLM est prompté pour créer de nouvelles instructions d'augmentation à partir de quelques instructions de départ (13).
2. **Sélection d'instructions guidé par la tâche** : Un modèle ranking sélectionne les meilleures instructions pour une tâche donnée.

### Principales conclusions

- **Amélioration par rapport aux méthodes de référence** : La méthode Self-LLMDA proposée surpasse systématiquement à la fois les méthodes traditionnelles non basées sur les LLM (par exemple, la rétro-traduction) et les approches manuelles basées sur les LLM dans diverses tâches.
- **Modèle de sélection des instructions** : Le modèle de notation qui sélectionne les instructions spécifiques à la tâche est un composant clé. Il garantit que les instructions utilisées pour l'augmentation des données sont hautement pertinentes pour les tâches ciblées, améliorant ainsi les performances.

### Résultats et contributions

- Le cadre montre des performances supérieures, en particulier dans les contextes d'apprentissage par faible nombre d'exemples.
- La sélection automatique d'instructions spécifiques aux tâches réduit le besoin d'intervention humaine dans la création de stratégies d'augmentation.
- L'étude révèle la capacité de généralisation de l'approche Self-LLMDA à travers différents modèles et tâches non vues, soulignant sa polyvalence.
---


---

<!-- garantissant que les données augmentées correspondent aux exigences de la tâche. -->
<!-- ### Méthodologie

- **Données et expériences** :
Le modèle est testé sur 26 tâches d'apprentissage par faible nombre d'exemples, couvrant des domaines tels que la détection de discours haineux, les questions-réponses et l'inférence de langage naturel. Cette évaluation étendue permet une comparaison plus large par rapport aux techniques d'augmentation précédentes.
- **Évaluation** : Les auteurs utilisent des modèles OPT de différentes tailles (125m, 350m, 1.3b) pour mesurer les performances des différentes méthodes d'augmentation des données. Les résultats sont évalués à l'aide du macro-F1 pour les tâches de classification et de la précision pour les tâches non classificatoires. -->
