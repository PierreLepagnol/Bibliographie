Le papier [*Constitutional AI: Harmlessness from AI Feedback*](https://arxiv.org/pdf/2212.08073) présente une méthode pour entraîner des systèmes d'IA(ChatBots) à être à la fois **utiles (helpful)** et **inoffensifs (harmless)**, en utilisant les retours (critiques et revisions) générés par l'IA plutôt que des annotations humaines.

Voici une explication structurée de ses concepts principaux :

### Objectif  
L'objectif principal est de développer un assistant IA (ChatBot) capable de produire des réponses 
- Inoffensives : L'assistant ne doit pas tenir des propos injurieux, toxiques, illégaux, ***etc***. 
- Utiles/aidantes: éviter les réponses évasives, répondre le plus souvent, ***etc***.

De plus, les définitions de utiles et inoffensives sont définies un texte en language naturel, une *charte* donnée à l'assistant IA, sans benchmark explicite.

<!--//les auteurs cherchent à s'assurer que l'IA explique pourquoi certains comportements nuisibles sont rejetés.-->

Ici on emploiera: modèle pour assitant IA.
### Processus Constitutional IA
L'approche se compose de deux étapes principales :
- **Étape d'apprentissage supervisé** :
	1. Le modèle génère des réponses à des requêtes potentiellement nuisibles,
	2. Critique ces réponses en fonction d'un ensemble de principes (appelés la "constitution")
	3. Révise les réponses avec les critiques pour éliminer tout contenu nuisible.
	4. Le modèle est ensuite ajusté (descente de gradient) avec les réponses révisées.
- **Étape d'apprentissage par renforcement (RLAIF)** : 
		1. Le modèle ajusté génère plusieurs réponses à une requête nuisible ("Red Teaming prompts") + On donne un questionnaire à choix multiple au modèle pour déterminer quelle réponse est la plus nuisible. On crée donc un dataset synthétique de préférence.
	1. Un modèle de préférence est entraîné à partir de retours générés par l'IA (Pour le coté Inoffensif) et Humain (côté utile). On peut donner un score à chaque réponse.
	3. Finalement, on utilise le modèle de préférence comme fonction de récompense dans l'apprentissage par renforcement pour optimiser davantage le modèle de l'étape précédente.


### **Résultats** 
Le modèle entraîné avec cette méthode a surpassé les modèles entraînés avec des retours humains selon les évaluations humaines, atteignant un équilibre entre utilité et inoffensivité tout en évitant des réponses excessivement évasives.

<!--### 6. **Contributions** :  
- Démonstration de l'efficacité de l'utilisation des retours de l'IA plutôt que des retours humains pour l'entraînement à l'innocuité.
- Introduction d'un processus itératif de critique et révision, qui a significativement amélioré le comportement du modèle.
- Validation que, à mesure que les modèles de langage s'améliorent, leur capacité à se superviser sur les comportements nuisibles s'améliore également.

En somme, l'article propose une méthode évolutive pour entraîner des IA à éviter les comportements nuisibles en utilisant un minimum d'interventions humaines, s'appuyant sur une "constitution" de directives éthiques et des retours générés par l'IA pour l'auto-amélioration.-->

#PreferenceDatasetCreation #RewardModelTraining #RewardModelUsing 