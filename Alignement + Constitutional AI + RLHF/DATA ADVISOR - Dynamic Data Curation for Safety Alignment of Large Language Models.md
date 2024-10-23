
#PreferenceDatasetCreation #SyntheticDataGeneration
#CréationDeDonnées #GénérationDeDonnéesSynthétiques

Le papier [*DATA ADVISOR - Dynamic Data Curation for Safety Alignment of Large Language Models*](https://arxiv.org/pdf/2410.05269v1) présente une méthode améliorée pour améliorer la qualité des données synthétiques produites les LLMs. 
La solution est nommée **DATA ADVISOR**. 

### Objectifs
L'objectif principal est d’améliorer les données synthétiques pour aligner les LLMs (Réponses Inoffensives et Utiles - cf [[Constitutional AI - Anthropic 2022]]).


Les recherches abordent plusieurs insuffisances dans les données générées par les LLM :
- **Amplification des biais** : sans supervision, les LLM peuvent renforcer leurs propres biais.
- **Manque de diversité et de couverture des données** : certains sujets peuvent être sous-représentés dans les jeux de données.
- **Qualité des données faible** : les données générées peuvent inclure des sorties hors sujets ou nuisibles (harmfull).

Les auteurs proposent une approche où le jeu de données généré est évalué, les faiblesses sont identifiées et de nouvelles données sont générées pour améliorer la couverture des problèmes repérés.

### Méthode
**DATA ADVISOR** est constitué de trois étapes clefs:

1. **Résumé des données**: 
   On produit un résumé des propriétés du jeu de données actuel en utilisant un prompt. Le prompt prend les guidelines de résumé (instructions), le précédent résumé ainsi que les exemples nouvellements générés ==> Nouveau Résumé. Le résumé est mis à jour à chaque nouvelles données générées (pool de données ?)
2. **Identification des faiblesses** : 
   On prompt le modèle pour identifier les faiblesses dans les données (à travers le résumé).
   Le prompt prend la liste de principes et le résumé produit à l'étape d'avant.
   Cette étape à pour but de repérer les lacunes, les manques de couvertures des principes dans les données générées.
1. "**Génération de données contrôlée** avec conseils: Sur la base des faiblesses identifiées, de nouvelles données sont générées avec une concentration sur l'amélioration du jeu de données dans les zones où il manque de diversité ou contient des biais.

### Expériences et évaluation
Les auteurs ont testé DATA ADVISOR sur l’alignement de sécurité de trois modèles de langage populaires : **Mistral**, **Llama2** et **Falcon**. Les principaux résultats incluent :
- **Amélioration de la sécurité :** Les modèles entraînés sur les données générées par DATA ADVISOR ont démontré une amélioration de la sécurité à plusieurs égards sans perdre leur utilité.
- **Comparaison au point de repère (Self-Instruct) :** Le papier compare DATA ADVISOR avec la méthode Self-Instruct, qui ne comporte pas de réajustements dynamiques. DATA ADVISOR surpasse Self-Instruct en termes de métriques de sécurité et d’utilité, montrant une couverture plus robuste des catégories nuisibles telles que le préjudice économique, l’abus envers les enfants et le contenu adulte.

### Contributions techniques
1. **Surveillance et guidage dynamiques :** DATA ADVISOR surveille constamment les données générées et conseille sur la prochaine itération, améliorant à la fois la qualité et la diversité.
2. **Amélioration itérative des données :** Il identifie systématiquement les faiblesses dans le jeu de données et les corrige, conduisant à des données de formation plus complètes.
3. **Applicabilité générale :** Même si testé sur l’alignement de sécurité, le méthode peut être adaptée pour d’autres tâches, telles que l’ajustement de l’instruction et l’adaptation de domaine.

### Métriques d’évaluation
Le papier utilise à la fois des **métriques de sécurité** et des **métriques d’utilité** :
- **Score de sécurité :** Mesuré comme la proportion de réponses sûres générées par les LLM après entraînement sur les données.
- **Score d’utilité :** Évalué sur des tâches générales à l’aide d’un benchmark multitâches (MMLU), mesurant comment bien le modèle se comporte sur une gamme de tâches sans rapport avec la sécurité.

### Résultats
- Les modèles entraînés à l'aide de DATA ADVISOR ont montré des améliorations significatives en matière de sécurité, réduisant les réponses nuisibles à travers différentes catégories nuisibles.
- Les modèles ont gardé leur utilité, signifiant qu’ils se sont encore bien comportés sur des tâches générales tout en étant plus sûrs.

### Conclusions et travaux futurs
Le papier conclut que DATA ADVISOR améliore efficacement la sécurité et l'utilité des LLM à travers la curation dynamique des données. Les auteurs suggèrent que le travail futur pourrait explorer l’application de la méthode dans des domaines au-delà de la sécurité, tels que la mitigation des backdoors dans les modèles ou l’adressage du biais dans l’optimisation des préférences.

### Forces
- **Approche dynamique innovante** pour améliorer la génération de données.
- Focus sur l’ **alignement de sécurité** est crucial pour le déploiement responsable des systèmes d’intelligence artificielle.
- La méthode présente des résultats empiriques solides et est généralisable à d’autres applications.

### Limites
- Les expériences étaient limitées aux **modèles à 7 milliards de paramètres** et à une taille de jeu de données de **10 000** échantillons, suggérant la nécessité d’une plus grande test.
- Il peut y avoir d’autres configurations de la méthode DATA ADVISOR qui n’ont pas été pleinement explorées, ce qui pourrait offrir des améliorations de performances.

Ce papier propose un cadre prometteur pour la curation dynamique des données dans les LLM, améliorant à la fois la sécurité et l'utilité. Cela pourrait être particulièrement utile pour les équipes axées sur la construction de systèmes d'IA plus fiables et plus sûrs.






The paper you provided, titled *"DATA ADVISOR: Dynamic Data Curation for Safety Alignment of Large Language Models"* by Fei Wang et al., introduces an enhanced method for improving the safety and utility of data generated by large language models (LLMs). The paper aims to address common issues in LLM-generated data, such as poor quality and bias, and proposes a solution called **DATA ADVISOR**. Below is a breakdown of the paper's key points:

### Main Goals
The paper focuses on improving **data generation** for LLMs, particularly for **safety alignment**—ensuring that LLMs produce content that is safe, diverse, and useful. The research addresses several shortcomings in LLM-generated data:
- **Bias amplification:** Without oversight, LLMs can reinforce their own biases.
- **Lack of data diversity and coverage:** Certain topics may be underrepresented in datasets.
- **Low data quality:** Generated data may include irrelevant or harmful outputs.

The authors propose a dynamic approach, where the generated dataset is continually assessed, weaknesses are identified, and new data is generated to improve coverage of important safety issues.

### Method: **DATA ADVISOR**
DATA ADVISOR is a framework that involves three key processes:
1. **Data Summarization:** The method iteratively summarizes the current dataset’s properties. A guiding principle (e.g., coverage of safety issues like violence or self-harm) is used to identify areas that require more data. The summary is updated with each newly generated data point.
  
2. **Weakness Identification:** The framework identifies weaknesses (e.g., lack of representation of certain safety concerns like cyberbullying) in the dataset, prompting the generation of data that fills these gaps.

3. **Controlled Data Generation:** Based on the identified weaknesses, new data is generated with the focus on improving the dataset in areas where it lacks diversity or contains biases.

### Experiments and Evaluation
The authors tested DATA ADVISOR on the safety alignment of three popular LLMs: **Mistral**, **Llama2**, and **Falcon**. Key findings include:
- **Improved Safety:** Models trained with DATA ADVISOR-generated data demonstrated improved safety across multiple fine-grained issues without losing their utility.
- **Comparison to Baseline (Self-Instruct):** The paper compares DATA ADVISOR with the Self-Instruct method, which does not involve dynamic adjustments. DATA ADVISOR outperforms Self-Instruct in both safety and utility metrics, showing more robust coverage of harmful categories such as economic harm, child abuse, and adult content.

### Technical Contributions
1. **Dynamic Monitoring and Guidance:** DATA ADVISOR continuously monitors the generated data and advises on the next iteration, improving both quality and diversity.
2. **Iterative Data Improvement:** It systematically identifies weaknesses in the dataset and corrects them, leading to more comprehensive training data.
3. **General Applicability:** Though tested on safety alignment, the method can be adapted for other tasks, such as instruction tuning and domain adaptation.

### Evaluation Metrics
The paper uses both **safety** and **utility** metrics:
- **Safety Score:** Measured as the proportion of safe responses generated by the LLMs after training on the data.
- **Utility Score:** Evaluated on general tasks using a multitask benchmark (MMLU), measuring how well the model performs across a range of non-safety-related tasks.

### Results
- The models trained using DATA ADVISOR showed significant improvements in safety, reducing harmful responses across various harmful categories.
- Models retained their utility, meaning they still performed well on general tasks while being safer.

### Conclusion and Future Work
The paper concludes that DATA ADVISOR effectively enhances LLM safety and utility through dynamic data curation. The authors suggest future work could explore the method’s application in areas beyond safety, such as mitigating backdoors in models or addressing bias in preference optimization.

### Strengths
- **Novel dynamic approach** for improving data generation.
- Focus on **safety alignment** is critical for the responsible deployment of AI systems.
- The method shows strong empirical results and is generalizable to other applications.

### Limitations
- Experiments were limited to **7B parameter models** and a dataset size of **10,000** samples, suggesting the need for more extensive testing.
- There may be **other configurations** of the DATA ADVISOR method that were not fully explored, which could offer performance improvements.

This paper proposes a promising framework for the dynamic curation of data in LLMs, which enhances both safety and utility. It could be particularly valuable for teams focused on building more reliable, safer AI systems.

*

*