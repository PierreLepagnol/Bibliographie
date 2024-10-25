Le cooperative ou collaborative decoding consiste en l'utilisation d"un système externe durant la génération.

On peut utiliser un system externe à différent moment du décodage: 

1. Calcul des représentations.
2. Calcul du prochain token.
3. Calcul d'une réponse entière pour vérifier la réponse.

## Calul du prochain token

Lors du calcul des logits/scores du prochain token, on utilise un système externe pour pondérer les scores de chacun des tokens. On peut réaliser cette opération avec:

- un Discriminateur \cite{krause2020gedigenerativediscriminatorguided,dathathri2020plugplaylanguagemodels}
- Un Modèle de langue \cite{liu2024tuninglanguagemodelsproxy,Shi2024DecodingTimeLM,Fan2024OnGS},
- Une grammaire, un Automate.

On peut le faire de manière brutale (en forçant les scores de certains tokens à 0) ou de manière plus douce (en réduisant les scores de ces tokens).

<!-- En modifiant le support de décodage pour que le modèle produise des séquences qui respectent les contraintes.
Modifier le support de décodage, c'est-à-dire re-pondérer les scores (logits, probabilités) des tokens en fonction des contraintes. On dit aussi que l'on biaise les prédictions du modèle.
 -->
## Calcul des représentations

Lors du calcul de la représentations finale on peut utiliser la représentation créé par le LLM pour nourrir un plus petit LLM et ainsi  bénéficié des "connaissances" du gros LLM.

