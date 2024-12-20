
Question principale de recherche:

> Comment apprendre un bon modèle avec des jeux de données de mauvaise qualité ?

Question de recherche reformulée: 

> Dans quelle mesure peut-on apprendre un bon modèle statistique pour traiter un problème de NLP avec des jeux de données non étiquetés ?

--- 

Durant l'année 1 : Je me suis concentré sur le prompting zero-shot et few-shots dans le contexte.
Puis dans le prompting few-shots avec des exemples séléctionnés par recherche d'information.

Mais l'approche par prompting à des limites, pour obtenir de bonne performance il faut

- Modèles très gros nécessitant beaucoup de mémoire GPU et lent à l'inférence.

Si on souhaite un modèle plus petit (résoudre les problèmes de latence, de coût, de consommation énergétique), les problèmes sont les suivants:

- Performances variables et peu robustes: grand écart d'Accuracy suivant le prompt de classification choisi : 
	- Nécéssitée d'optimiser le prompt ou d'employer différentes stratégies de prompting ou decoding
- Peu d'interprétabilité dans les résultats.
- Mauvaise performances pour des tâches de prédictions structurées (cf: )

Pour résoudre ces problèmes on peut contraindre/guider la génération pour obtenir de meilleur résultats: 

- Chercher un meilleur prompt/Optimiser le prompt.
- Utiliser des types de prompt différents : X of Thoughts Prompting - (X: Chain, Tree, Graph, etc)
- Contraindre le support de décodage durant l'inférence
- Pondéré les sorties avec un système annexe (Proxy-Tunning) 
- Fine-tuner un modèle pour incorporer la contrainte durant l'apprentissage.
	- Nécéssite un outil pour produire des pseudo-labels pour le fine-tuning + Un template pour le fine-tuning.
	- pour être généré Distillation/Labelisation 


Synthèse Structurée
1. Introduction et Contexte
Les documents de votre workspace se concentrent principalement sur l'optimisation et l'amélioration des modèles de langage (LLMs) à travers diverses techniques telles que la distillation des connaissances, l'augmentation des données, et l'adaptation à différents domaines et tâches.

1. Distillation des Connaissances
La distillation des connaissances est un thème récurrent dans plusieurs documents. Elle vise à transférer les connaissances d'un grand modèle de langage (LLM) vers un modèle plus petit et plus efficace.

[Distillation/Evolving Knowledge Distillation with Large Language Models and Active Learning.md](Distillation/Evolving Knowledge Distillation with Large Language Models and Active Learning.md) :

Incorporation de méthodes de Data Valuation pour optimiser la sélection des exemples.
Optimisation des coûts de calcul avec des techniques comme le décodage adaptatif.
Comparaison entre LLM multilingue et monolingue pour déterminer la meilleure approche.
Adaptation à d'autres domaines comme la finance et la médecine.
Interprétabilité des résultats et exploration de nouvelles méthodes de prompting.
[Distillation/MiniLLM - Knowledge Distillation of Large Language Models.md](Distillation/MiniLLM - Knowledge Distillation of Large Language Models.md) :

Changement de la fonction à optimiser pour la distillation : KLD[p|q] ==> KLD[q|p].
Draft.md :

Présentation de la méthode EvoKD pour une distillation dynamique des connaissances.
Utilisation de l'apprentissage actif avec les LLMs pour générer des données annotées.
Performance en mode Few-Shot.
3. Augmentation et Synthèse des Données
L'augmentation des données est une autre technique clé pour améliorer les performances des LLMs.

[Data Augmentation/A Survey on Data Synthesis and Augmentation for Large Language Models.md](Data Augmentation/A Survey on Data Synthesis and Augmentation for Large Language Models.md) :

Évaluation des modèles entraînés sur des données synthétiques.
Identification des défis comme les biais et les coûts computationnels.
Propositions de futures directions et contributions.
[Data Augmentation/0 - Résumé des méthodes - Data Augmentation.md](Data Augmentation/0 - Résumé des méthodes - Data Augmentation.md) :

Génération automatique des instructions d'augmentation en sollicitant les LLMs.
Introduction d'un modèle de sélection d'instructions pour des tâches en aval.
4. Adaptation à Divers Domaines et Tâches
L'adaptation des LLMs à différents domaines et tâches est explorée pour maximiser leur utilité.

[0 - Idées Expériences/Adaptation à d'autres domaines et tâches ?.md](0 - Idées Expériences/Adaptation à d'autres domaines et tâches ?.md) :
Adaptation des LLMs à des domaines comme la finance et la médecine.
Exploration de tâches spécifiques comme la classification de texte et le question-réponse.
5. Optimisation des Coûts et Efficacité
L'optimisation des coûts de calcul et l'efficacité des modèles sont des préoccupations majeures.

[0 - Idées Expériences/Est-il possible de produire des exemples d'annotations de bonne qualité tout en réduisant la dépendance aux GROS LLMs ?.md](0 - Idées Expériences/Est-il possible de produire des exemples d'annotations de bonne qualité tout en réduisant la dépendance aux GROS LLMs ?.md) :
Utilisation de techniques comme le décodage adaptatif pour obtenir de bons échantillons avec des petits modèles.
6. Synthèse et Conclusion
Les documents montrent une approche intégrée pour améliorer les LLMs en combinant la distillation des connaissances, l'augmentation des données, et l'adaptation à divers domaines. L'objectif est de créer des modèles plus petits, plus efficaces et capables de générer des données de haute qualité tout en optimisant les coûts de calcul.

Cette synthèse met en lumière les liens entre les différents documents et leur contribution à l'amélioration des modèles de langage.