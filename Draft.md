
Le papier [*Constitutional AI: Harmlessness from AI Feedback*](https://arxiv.org/pdf/2212.08073) presente une méthode pour entainer un système d'IA (chatbot) pour être à la fois **Aidant (helpful)**  et Inofenssif (harmless), primarily using AI-generated feedback rather than human labels for harmful behavior. Here's a structured breakdown of its main concepts:

[@nayak2024learning]

### Contributions :
1. **Distillation dynamique des connaissances** : EvoKD introduit une stratégie d'enseignement dynamique qui s'adapte en fonction des performances du modèle étudiant, contrastant avec la nature statique des méthodes de KD traditionnelles.
   
2. **Apprentissage actif avec les LLMs** : EvoKD exploite les LLMs non seulement pour générer des données annotées, mais aussi pour comprendre les tâches et traiter les faiblesses spécifiques du modèle étudiant.

3. **Performance en mode Few-Shot** : La méthode démontre des performances solides en mode few-shot, atteignant **90 % des performances en mode full-shot avec 1-shot** sur plusieurs tâches de classification de texte.

### Conclusion :
EvoKD présente une approche innovante de la distillation de connaissances en combinant l'apprentissage actif avec les grands modèles de langage pour générer dynamiquement des données informatives et spécifiques aux tâches pour le modèle étudiant. Cette approche conduit à des améliorations significatives, en particulier dans les scénarios d'apprentissage avec peu d'exemples.

Si vous avez besoin de clarifications supplémentaires ou de détails sur une partie spécifique de l'article, n'hésitez pas à demander !