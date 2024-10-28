<!-- # Constrained Generation & AR Structured Predictions for NLU Tasks -->

**Date**: October 23, 2024

## Question principale de recherche
> Comment apprendre un bon modèle avec des jeux de données de mauvaise qualité ?

## Question de recherche reformulée
> Dans quelle mesure peut-on apprendre un bon modèle statistique pour traiter un problème de NLP avec des jeux de données non étiquetés ?

### Introduction

Durant l'année 1, je me suis concentré sur le prompting zero-shot et few-shots dans le contexte, puis dans le prompting few-shots avec des exemples séléctionnés par recherche d'information.

Mais l'approche par prompting à des limites, pour obtenir de bonne performance il faut

- Modèles très gros nécessitant beaucoup de mémoire GPU et lent à l'inférence.

Si on souhaite un modèle plus petit (résoudre les problèmes de latence, de coût, de consommation énergétique), les problèmes sont les suivants:

- Performances variables et peu robustes: grand écart d'Accuracy suivant le prompt de classification choisi : 
  - Nécéssitée d'optimiser le prompt ou d'employer différentes stratégies de prompting ou decoding
- Peu d'interprétabilité dans les résultats.
- Mauvaise performances pour des tâches de prédictions structurées (cf: )

Pour résoudre ces problèmes on peut contraindre/guider la génération pour obtenir de meilleur résultats.
On peut contraindre un modèle à différentes phases d’entraînement ou d’utilisation.

- Contraintes durant l’entraînement/l’apprentissage
- Contraintes durant l’inférence

- Chercher un meilleur prompt/Optimiser le prompt.
  - Utiliser des types de prompt différents : X of Thoughts Prompting - (X: Chain, Tree, Graph, etc)
- Contraindre le support de décodage durant l'inférence
- Pondéré les sorties avec un système annexe (Proxy-Tunning) 
- Fine-tuner un modèle pour incorporer la contrainte durant l'apprentissage.
  - Nécéssite un outil pour produire des pseudo-labels pour le fine-tuning + Un template pour le fine-tuning.
  - pour être généré Distillation/Labelisation 


### Phases d’application des contraintes

On peut contraindre un modèle statistique à différentes phases d’entraînement ou d’utilisation.

- Contraintes durant l’entraînement/l’apprentissage
- Contraintes durant l’inférence

#### 3.1 Contraintes durant l’entraînement

1. Apprentissage général pour suivre des contraintes (Instruction-tuning, RLHF/AI).
2. Apprentissage multi-tâches avec des tokens/classes pour chaque tâche (apprendre au modèle à résoudre plusieurs tâches).
3. Apprentissage sur la tâche directement (Cas particulier de 2. - apprendre au modèle à résoudre la tâche).

#### 3.2 Contraintes durant l’inférence

Durant l’inférence on cherche à ce que le modèle prédise des séquences qui respectent des contraintes, on va donc modifier le support de décodage pour que le modèle produise des séquences qui respectent les contraintes. Modifier le support de décodage, c’est-à-dire re-pondérer les scores (logits, probabilités) des tokens en fonction des contraintes. On dit aussi que l’on biaise les prédictions du modèle.

On peut le faire de manière brutale (en forçant les scores de certains tokens à 0) ou de manière plus douce (en réduisant les scores de ces tokens).

- Utiliser/modifier les paramètres de décodage: Top-K, Top-p, greedy search, beam-search, sampling, etc.
- Cooperative decoding: on pondère les scores de chacun des tokens en fonction d’un système externe (discriminateur Krause et al. [2020], Dathathri et al. [2020], modèle de langue Liu et al. [2024], Shi et al. [2024], Fan et al. [2024], Automates).
- Stratégies de Prompting: Direct Answer, Chain of Thoughts (CoT), self-consistency/verification, etc.

On peut aussi combiner les différentes méthodes pour obtenir des résultats plus performants. Par exemple, utiliser un prompt particulier + utiliser un discriminateur externe pour ranker les tokens.

#### 3.2.1 Decoding Parameters

**Cooperative decoding**

Méthodes de Décodage Contraint. La Décodage Contraint est une technique qui permet de guider les modèles de génération de texte dans le respect de contraintes telles que le format, la validité d’une séquence (présence ou non de certains mots), etc. Il faut distinguer plusieurs types de travaux sur la Décodage Contraint: d’une part les travaux sur les méthodes de génération, leurs améliorations et leurs limites, d’autre part les travaux sur l’application de ces méthodes.

Dans un premier temps, nous nous concentrons sur les méthodes pour contraindre la génération puis nous nous intéresserons aux problèmes de Tokenisation et aux performances induites par l’utilisation de grammaires pour contraindre la génération. Enfin, nous décrirons les différentes tâches auxquelles ont été appliquées ces méthodes.

**Contraintes Lexicales**: Scholak et al. [2021]: Utilisation de parseurs pour générer des requêtes SQL valides.

**Contraintes Grammaticales (Automates)**: Le principe est de restreindre le support de mots/tokens/symboles pouvant être générés par le modèle.

Sproat and Jaitly. [2017], Zhang et al. [2019] construisent des FST (Transducteurs à États Finis) qui traduisent les formes écrites en formes verbales possibles, et utilisent ceux-ci pour guider/contraindre le modèle.

Deutsch et al. [2019] utilisent des FSA (Automates à États Finis) et des PDA (Automates à Pile Déterministes) pour contraindre la sortie d’un modèle séquentiel à un certain langage formel.

Ces travaux ne traitent pas des problèmes entre la Tokenisation du modèle de langue et le langage formel ciblé. Problème abordé en section ??.

Les travaux de Koo et al. [2024], Microsoft. [n.d.], Geng et al. [2023] permettent une plus large gamme de contraintes, en prenant en charge n’importe quel langage régulier ou contextuel déterministe, et abordent également les problèmes inhérents aux tokenizers des modèles de langue actuels.

Parallèlement, les travaux de Willard and Louf [2023] traitent du même sujet et abordent les problèmes avec la Tokenisation par des moyens différents.

### Problèmes de la génération contrainte
**Token Misalignment**: La génération contrainte produit des tokens qui ne seraient pas produits "naturellement", ce qui induit des complétions avec une plus grande perplexité (indiquant que le modèle ne les aurait pas choisies sans contrainte).

**Figure 1**: Illustration du problème de désalignement

Pour remédier à ce problème Beurer-Kellner et al. [2024] propose DOMINO (pas encore compris).

**Comptation Overhead et Latence**: La génération contrainte demande des calculs supplémentaires qui ajoutent de la latence dans la génération.

### Cas d’application du Décodage Contraint
Plusieurs travaux ont étudié l’utilisation du Décodage Contraint, avec ou sans LLMs.

- **Extraction d’information - Closed Information Extraction**: La tâche consiste à extraire des triplets factuels à partir du texte.
  
  Josifoski et al. [2022], Geng et al. [2023].

- **Analyse en Constituants (CP)**: Analyse d’une phrase en un arbre syntaxique.

- **Désambiguïsation d’entités - Désambiguïsation d’Entités**: Objectif: À partir d’une mention dans un texte, le modèle doit la désambiguïser en sélectionnant l’entité correcte dans une base de connaissances (par exemple, Wikipedia).

  De Cao et al. [2021], Geng et al. [2023].

- **Liaison d’entités - Liaison d’Entités**: Objectif: Le modèle doit détecter les mentions dans un texte et les lier aux entités correspondantes de la base de connaissances. Cette tâche inclut à la fois la détection des mentions et leur désambiguïsation vers une entité de la base de connaissances.

  De Cao et al. [2021].

- **Recherche de documents au niveau des pages - Page-level Document Retrieval**: Objectif: La tâche ici est de récupérer les pages Wikipedia pertinentes à partir d’une requête, où les titres des pages Wikipedia sont utilisés comme identifiants d’entités.

  De Cao et al. [2021].

- **Génération d’arbre syntaxique - Analyse en Constituants**: Objectif: Générer des arbres d’analyse syntaxique valides à partir de séquences de tokens en utilisant une inférence contrainte. Cette tâche teste la capacité du modèle à produire des arbres syntaxiquement valides en fonction de diverses contraintes telles que des parenthèses équilibrées et des structures préterminales correctes.

  Deutsch et al. [2019].

- **SRL (Annotation de Rôles Sémantiques)**: Objectif: Identifier les rôles des constituants dans une phrase par rapport à un prédicat en utilisant des étiquettes d’arguments valides. Le modèle est contraint pour éviter les erreurs courantes telles que les arguments dupliqués ou les étiquettes d’argument invalides.

  Deutsch et al. [2019].

- **Normalisation de texte**: Sproat and Jaitly. [2017], Zhang et al. [2019] utilisent les contraintes pour les applications de synthèse vocale (TTS).

- **Analyse Sémantique DSL (Langage Spécifique au Domaine)**: pour l’Analyse Sémantique: sur les jeux de données SMCalFlow, Overnight, GeoQuery.

  Wang et al. [2023], Shin et al. [2021].

- **Action DSL (Langage Spécifique au Domaine)**: Wang et al. [2023]: sur le jeu de données PDDL planning.

- **Génération de molécules DSL (Langage Spécifique au Domaine)**: Wang et al. [2023]: sur le jeu de données SMILES (Simplified Molecular Input Line Entry System).

- **Génération de code**: Scholak et al. [2021]: Génération de SQL.

  Fu et al. [2024]: Génération de C/C++/Python.

### Implémentations
Cette partie traite des implémentations de décodage contraint par grammaire/Automates.
- GUIDANCE: Microsoft. [n.d.].
- llama.cpp: Gerganov et al. et al.
- Transformer-CFG: Geng.
- LMQL: Beurer-Kellner et al. [2023].
- OUTLINES: Willard et Louf [2023].

### 3.2.2 Prompting Strategies

## 4 References
1. Luca Beurer-Kellner, Marc Fischer, and Martin Vechev. Prompting is programming: A query language for large language models. Proc. ACM Program. Lang., 7(PLDI), June 2023. doi: 10.1145/3591300. URL https://doi.org/10.1145/3591300.
2. Luca Beurer-Kellner, Marc Fischer, and Martin Vechev. Guiding llms the right way: Fast, non-invasive constrained generation, 2024. URL https://arxiv.org/abs/2403.06988.
3. Sumanth Dathathri et al. Plug and play language models: A simple approach to controlled text generation, 2020. URL https://arxiv.org/abs/1912.02164.
4. Nicola De Cao et al. Autoregressive entity retrieval, 2021.
5. Daniel Deutsch et al. A general-purpose algorithm for constrained sequential inference. In Proceedings of the 23rd Conference on Computational Natural Language Learning (CoNLL), pages 482–492, Hong Kong, China, November 2019. Association for Computational Linguistics. doi: 10.18653/v1/K19-1045. URL https://aclanthology.org/K19-1045.
6. Chenghao Fan et al. On giant’s shoulders: Effortless weak to strong by dynamic logits fusion. ArXiv, abs/2406.15480, 2024. URL https://api.semanticscholar.org/CorpusID:270703337.
7. Yanjun Fu et al. Constrained decoding for secure code generation, 2024. URL https://arxiv.org/abs/2405.00218.
8. Saibo Geng. Transformers cfg. URL https://github.com/epfl-dlab/transformers-CFG.
9. Saibo Geng et al. Grammar-constrained decoding for structured nlp tasks without finetuning. In Conference on Empirical Methods in Natural Language Processing, 2023. URL https://api.semanticscholar.org/CorpusID:258841514.
10. Georgi Gerganov et al. llama.cpp: Port of facebook’s llama model in c/c++. URL https://github.com/guidance-ai/guidance.
11. Martin Josifoski et al. GenIE: Generative information extraction. In Proceedings of the 2022 Conference of the North American Chapter of the Association for Computational Linguistics: Human Language Technologies, pages 4626–4643, Seattle, United States, July 2022. Association for Computational Linguistics. doi: 10.18653/v1/2022.naacl-main.342. URL https://aclanthology.org/2022.naacl-main.342.
12. Terry Koo et al. Automata-based constraints for language model decoding. In First Conference on Language Modeling, 2024. URL https://openreview.net/forum?id=BDBdblmyzY.
13. Ben Krause et al. Gedi: Generative discriminator guided sequence generation, 2020. URL https://arxiv.org/abs/2009.06367.
14. Alisa Liu et al. Tuning language models by proxy, 2024. URL https://arxiv.org/abs/2401.08565.
15. Microsoft. Guidance, 2023., n.d. URL https://github.com/guidance-ai/guidance.
16. Torsten Scholak et al. PICARD: Parsing incrementally for constrained auto-regressive decoding from language models. In Proceedings of the 2021 Conference on Empirical Methods in Natural Language Processing, pages 9895–9901, Online and Punta Cana, Dominican Republic, November 2021. Association for Computational Linguistics. doi: 10.18653/v1/2021.emnlp-main.779. URL https://aclanthology.org/2021.emnlp-main.779.
17. Ruizhe Shi et al. Decoding-time language model alignment with multiple objectives. ArXiv, abs/2406.18853, 2024. URL https://api.semanticscholar.org/CorpusID:270764846.
18. Richard Shin et al. Constrained language models yield few-shot semantic parsers. In Proceedings of the 2021 Conference on Empirical Methods in Natural Language Processing, pages 7699–7715, Online and Punta Cana, Dominican Republic, November 2021. Association for Computational Linguistics. doi: 10.18653/v1/2021.emnlp-main.608. URL https://aclanthology.org/2021.emnlp-main.608.
19. Richard Sproat and Navdeep Jaitly. Rnn approaches to text normalization: A challenge, 2017. URL https://arxiv.org/abs/1611.00068.
20. Bailin Wang et al. Grammar prompting for domain-specific language generation with large language models, 2023.
21. Brandon T. Willard and Rémi Louf. Efficient guided generation for large language models, 2023. URL https://arxiv.org/abs/2307.09702.
22. Hao Zhang et al. URL https://aclanthology.org/J19-2004.

## 5 Glossaire
### Glossary
- **Analyse en Constituants**: Un type d’analyse syntaxique qui divise une phrase en une structure hiérarchique, souvent visualisée sous forme d’arbre, montrant les constituants grammaticaux.
- **Analyse Sémantique**: Le processus de conversion d’une phrase en langage naturel en une représentation formelle, telle qu’une forme logique ou du code, généralement contrainte par des règles grammaticales.
- **DSL (Langage Spécifique au Domaine)**: Un langage spécialisé utilisé pour exprimer des concepts dans un domaine spécifique, souvent employé dans des tâches comme l’analyse sémantique ou la génération de code.
- **Décodage Contraint**: Une méthode pour guider la génération de texte en appliquant des contraintes sur la sortie, telles que le format, la validité de la séquence de tokens, ou le respect de certaines règles comme la grammaire.
- **Désambiguïsation d’Entités**: Une tâche où un modèle identifie et relie des entités ambiguës (par exemple, des noms) à leur référence correcte dans une base de connaissances.
- **FSA (Automates à États Finis)**: Un modèle mathématique qui décrit un système avec un nombre fini d’états. Il est utilisé pour imposer des contraintes sur les séquences générées, garantissant la validité des séquences de tokens ou de mots.
- **FST (Transducteurs à États Finis)**: Un modèle computationnel utilisé pour représenter les transformations entre deux ensembles de symboles, souvent appliqué à la normalisation de texte ou aux tâches linguistiques.
- **Génération Contrainte**: [Non spécifié dans le texte].
- **Liaison d’Entités**: Une tâche dans le NLP où les mentions d’entités dans un texte sont reliées à leurs entrées correspondantes dans une base de connaissances, telle que Wikipedia.
- **PDA (Automates à Pile Déterministes)**: Un modèle computationnel qui utilise une pile pour stocker des données, utilisé pour appliquer des contraintes complexes comme les grammaires indépendantes du contexte.
- **SMILES (Simplified Molecular Input Line Entry System)**: Une notation qui permet à un utilisateur de représenter une structure chimique d’une manière compréhensible par les ordinateurs, souvent contrainte dans les tâches de génération de molécules.
- **SRL (Annotation de Rôles Sémantiques)**: Le processus d’identification et d’étiquetage des rôles des divers constituants d’une phrase par rapport à un prédicat, tels que le sujet, l’objet ou d’autres rôles grammaticaux.
- **Tokenisation**: Le processus de division d’une chaîne de texte en tokens individuels (mots, sous-mots ou caractères) pour le traitement dans les tâches de NLP.
