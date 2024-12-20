
#preference-basedRL #ConstitutionalAI

//https://github.com/opendilab/awesome-RLHF

Le sujet du [[Constitutional AI - Anthropic 2022]]est lié au sujet de l'Alignement des LLMs.

Pour Anthropic, l'adhésion aux principes à la "constitution" permet de créer un chatbot qui soit aidant mais inoffensif sans avoir à extensivement décrire, définir ce que **Aidant** et **Inofenssif** veulent dire (donc produire une annotation et quantitative). Mais la définition est très adhoc (les auteurs le dise eux même.)

Dans leur papier Anthropic créer un modèle de préférence sans supervision humaine.
Mais plusieurs approches de création de modèle de préférence ont été étudiées et un benchmark académique [[RewardBench - Evaluating Reward Models for Language Modeling|RewardBench]] à été proposé par AllenAI.

Le sujet se distingue en plusieurs parties : 

1. Création de dataset de préférence (Prompt; Réponse 1; Réponse 2) #PreferenceDatasetCreation
2. Entrainement de Reward Model ==> Calcul de Score=P(Réponse 1 > Réponse 2) #RewardModelTraining
3. Algorithme d'optimisation du LLM avec le Reward Model #RewardModelUsing


Plusieurs travaux ont étés réalisés :

- Alignement durant l'inférence directement: [[Inference-Time Language Model Alignment via Integrated Value Guidance]]
- Alignement sans supervision humaine (génération synthétique de préférence/score de reward) approches LLM-as-Judges:
	- [[Constitutional AI - Anthropic 2022|Constitutional AI]]
	-  [[RLHF vs RLAI]]
	- [[DATA ADVISOR - Dynamic Data Curation for Safety Alignment of Large Language Models|DATA ADVISOR]]
	- 
- 










