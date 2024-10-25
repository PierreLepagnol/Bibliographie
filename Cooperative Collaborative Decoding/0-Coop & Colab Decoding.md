- on pondère les scores de chacun des tokens en fonction d'un système externe (discriminateur \cite{krause2020gedigenerativediscriminatorguided,dathathri2020plugplaylanguagemodels}, modèle de langue \cite{liu2024tuninglanguagemodelsproxy,Shi2024DecodingTimeLM,Fan2024OnGS}, Automates).

En modifiant le support de décodage pour que le modèle produise des séquences qui respectent les contraintes.
Modifier le support de décodage, c'est-à-dire re-pondérer les scores (logits, probabilités) des tokens en fonction des contraintes. On dit aussi que l'on biaise les prédictions du modèle.


On peut le faire de manière brutale (en forçant les scores de certains tokens à 0) ou de manière plus douce (en réduisant les scores de ces tokens).