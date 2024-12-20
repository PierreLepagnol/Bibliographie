## Génération/Augmentation de données
### Sans LLM

Objectif : Améliorer la diversité des jeux de données sans s'appuyer sur les LLMs.

Ces méthodes vont des approches heuristiques simples aux méthodes basées sur des modèles génératifs.
#### Approches heuristiques:

- Remplacement de synonymes (Zhang et al., 2016) et le mélange de mots :
    - Avantages : efficacité computationnelle et simplicité
- Technique d'Easy Data Augmentation (EDA) introduite par Wei et Zou (2019), qui utilise des perturbations au niveau des tokens – insertion, suppression et échange aléatoires – pour améliorer les performances dans une gamme de tâches de classification de texte.

#### Approches basées sur des modèles:

- Utilisation des modèles seq2seq:
    - Paraphrase par traduction inverse (Fadaee et al., 2017) : Conservation du sens et diversité linguistique
    -
-  Utilisation des modèles BERT (Devlin et al., 2018) et RoBERTa (Liu et al., 2019):
    - Masquage des mots dans des phrases et en générant ensuite des remplacements, ces modèles introduisent des variations linguistiques (Cheng et al., 2022 ; Wu et al., 2018)

- Utilisation de modèles auto-regressifs:
    - Génération conditionnelle basée sur des étiquettes des classe avec GPT2 (Edwards et al., 2023) ou T5/BART (Kumar et al., 2021)
    - Génération de paraphrase avec GPT2 (Boulanger et al 2022)

#### Approches basé sur les embeddings:

- Génération de vecteurs d'embedding synthétiques:
    - Techniques de mixup interpolent au sein des embeddings de mots ou de phrases (Guo et al., 2019)
    - Avec bruit multiplicatif et additif aléatoire dans les vecteurs de caractéristiques (Kurata et al., 2016).

Méthodes utiles, efficaces computationellement mais limité par leur readability et la cohérence contextuelle des prhases produites.

### Avec LLM

Les LLMs sont de plus en plus utilisés comme des fonctions de transformation de texte qui conservent les labels.

Les instructions de génération sont :
Pour que les exemples générés soient conceptuellement similaires mais sémantiquement distincts. (Même label, sens différents)
- Conçues manuellement:
    - Dai et al 2023:
    - Yoo et al 2021 : GPT3Mix: Leveraging Large-scale Language Models for Text Augmentation
    - Piedboeuf et Langlais, 2023 : Is ChatGPT the ultimate Data Augmentation Algorithm?
    - (Chung et al., 2023 ; Yu et al., 2023 ; Li et al., 2023 ; Ubani et al., 2023 ; Meng et al., 2022)

- Conçues Automatiquement (Yichuan Li) : [[Empowering Large Language Models for Textual Data Augmentation]]
![[Self-LLMDA.png]]

En revanche, notre travail génère automatiquement des instructions d'augmentation conservant les étiquettes en sollicitant les LLMs, réduisant ainsi la dépendance aux instructions conçues manuellement.
De plus, nous introduisons un modèle de sélection d'instructions qui choisit les instructions appropriées pour des tâches en aval arbitraires.