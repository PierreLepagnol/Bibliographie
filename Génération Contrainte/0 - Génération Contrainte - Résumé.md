# Constrained Generation & AR Structured Predictions for NLU Tasks

### Question principale de recherche:

> Comment apprendre un bon modèle avec des jeux de données de mauvaise qualité ?

### Question de recherche reformulée:

> Dans quelle mesure peut-on apprendre un bon modèle statistique pour traiter un problème de NLP avec des jeux de données non étiquetés ?

## Introduction

Dans ce document, nous ferons une revue de littérature sur la [Constrained Generation](#gls:ConstrainedGeneration).

## Différents Types de Contraintes

On distingue des contraintes de différents niveaux :

- **Contrainte de domaine**
- **Contrainte de tâches**
- **Contrainte de vocabulaire**

### Contraintes de domaine

	Les modèles doivent souvent s'adapter à un contexte ou à un domaine particulier, tel que la médecine, la finance ou le droit. Les contraintes de domaine visent à restreindre la génération de séquences à un style spécifique à ce domaine, permettant au modèle de produire des sorties plus adaptées et pertinentes.

*Exemple :* dans la génération de texte dans le domaine bancaire, le modèle doit respecter des formats, termes bancaires et abréviations spécifiques au domaine.

### Contraintes de vocabulaire

Ici, on impose un sous-ensemble du vocabulaire autorisé à un modèle. Cela peut être utile dans des tâches de traduction, d'écriture de code ou d'autres scénarios où certains termes sont invalides ou, au contraire, doivent obligatoirement apparaître dans la sortie.

*Exemple :* dans une tâche de génération de code, le modèle doit limiter ses prédictions aux syntaxes valides pour un langage de programmation spécifique.

### Contraintes de tâche

Une contrainte de tâche se réfère à la génération de texte pour résoudre une tâche donnée/précise. Cela peut inclure des contraintes liées à la syntaxe ou à la structure (exemple : formats JSON, XML, balisage HTML) ou à des sorties spécifiques pour une tâche de classification ou de génération. On peut considérer que c'est une sorte un regroupement des deux types de contraintes précédentes.

*Exemple :* produire un résumé en respectant une longueur maximale (par exemple 200 caractères).

## Phases d'application des contraintes

On peut contraindre un modèle statistique à différentes phases d'entrainement ou d'utilisation.

- **Contraintes durant l'entraînement/l'apprentissage**
- **Contraintes durant l'inférence**
### Contraintes durant l'entraînement

Durant l'apprentissage, on cherche à ce faire apprendre la tâche au modèle. C'est à dire à faire répondre le modèle par les séquences nécéssaire pour résoudre la tâche de classification.

On peut utiliser plusieurs méthodes : 
1. Apprentissage général pour suivre des contraintes (Instruction-tuning, RLHF/AI) : [[0 - Alignement de LLMs]]
2. Apprentissage multi-tâches avec des tokens/classes pour chaque tâches (apprendre au modèle à résoudre plusieurs tâches) [[Apprentissage Multi-Tâches]]
3. Apprentissage sur la tâche directement (cas particulier de 2.) : Appelé Standard Fine-tuning. 

Toutes ces méthodes requièrent des jeux de données labélisés.

Soit:
- On dispose de données non labélisées $\implies$ On labelise les données: [[0-Distillation de connaissance - NLP]]
- On ne dispose pas de données (même non labélisées)$\implies$ On génère des données automatiquement : [[0 - Résumé des méthodes - Data Augmentation]]
### Contraintes durant l'inférence

Durant l'inférence, on cherche à ce que le modèle prédise des séquences qui respectent des contraintes.
Pour ce faire, on peut:
- Utiliser/modifier les **Paramètres de décodage** : [[0-Decoding Methods]]
- **Stratégies de Prompting**: [[0-Prompting Methods]]
- Utiliser du **Cooperative/Colaborative Decoding**: [[0-Coop & Colab Decoding]]

On peut aussi combiner les différentes méthodes pour obtenir des résultats plus performants.
Par exemple, utiliser un prompt particulier + utiliser un discriminateur externe pour ranker les tokens.
