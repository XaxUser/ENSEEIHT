# 1 - Chargement des donnees

data=read.table(file="DataTP4.txt",header=TRUE)
data$CouvTot=as.factor(data$CouvTot)

names(data)
summary(data)
dim(data)


# Modèle de base

lm.out=lm(P60~FFSOL+PMER+T2M+VV850+HautSoleil+HOUR+rayth+FLSOLAIRE_D+PRECIP+CAPE_INS+HU950+CouvTot,data=data)
summary(lm.out)

# -> on remarque que la contrainte d'identification imposée par R sur le facteur CouvTot est alpha(A) = 0, et que p_value associée au test de student< 0.05 pour CouvTotB et CouvTotC, cad que les modalités A et B ont des comportement différents et de même pour les modalités A et C.




plot(data$CouvTot, data$P60, main = "lien entre P60 et CouvTot", xlab = "CouvTot", ylab = "P60")
anova(lm(P60 ~ CouvTot, data = data))





# -> il parait judicieux d'éliminer les variables T2M, VV850, rayth et PRECIP car leur p_value associée au test de student >> 0.05 et donc il sont jugés non significatif sur notre modèle, ainsi garder les autres prédicteurs car ils ont un impact significatif sur l'augmentation de la performance de notre modèle


#Les hypotheses du modèle lineaire gaussion 
# 1- heteroscedasticite :
plot(fitted(lm.out),residuals(lm.out),main="Hypothèse d'homoscédasticité",xlab="Valeurs ajustées (Y*)",ylab="Résidus")
# -> heteroscedasticite observee : la variabilite de l'erreur n'est pas stable, une structure en cone apparait, hypothese d'homoscedasticite non verifiee


# 2 - normalité
qqnorm(residuals(lm.out))
hist(residuals(lm.out))
# residus centres par construction sur apprentissage,
# les queues de distribution s'eloignent de la normalite, mais globalement l'hypoth�se de normalite ne pose pas de probleme sur la plage classique des valeurs prises par P60


#3- Indépendance:
acf(residuals(lm.out))
# -> Les barres ne sont situées en dehors des intervalles de confiance que pendant le premier et dernier lag, ainsi elles sont considérées comme statistiquement non significatives. Cela indique une absence de corrélation significative entre les résidus.
#ainsi pendant le 1er lag on remarque une corrélation positive : La barre au-dessus de zéro indique une corrélation positive, ce qui signifie que les résidus à ce retard ont tendance à être similaires.
# -> pas d'autocorrélation et donc l'hypothèse d'independance est bien respectée

# 4-Linéarité :

plot(fitted(lm.out),data$P60,xlab="[P60] ",ylab="[P60] ",pch="+",main="Hypothèse de linéarité")
# -> d'après le tracé l'hypothèse de linéarité n'est pas vérifiéé rigoureusement , il y a une petite ligne horizontale au début puis une courbure vers le haut




# Un R² élevé indique que le modèle explique une grande proportion de la variance de P60
# Explication : La présence de prédicteurs significatifs , et les variables météorologiques et horaires expliquent bien les variations de la production photovoltaïque


# 3 Algorithme de selection automatique 

library(MASS)

lm.outBIC=stepAIC(lm.out,k=log(nrow(data)))
summary(lm.outBIC)
formula(lm.outBIC)
#Le BIC est un critère qui prend en compte à la fois l'ajustement aux données et la complexité du modèle. ainsi,la selection automatique descendante utilisant le critere BIC pénalise plus le modèle et retire la variable PMER au plus de variables retirées dans le modèle de base.
# -> on remarque ainsi que le pourcentage de la variance passe à 84.2%


lm.outint=lm(P60~.*.,data)
summary(lm.outint)
lm.outBICint=stepAIC(lm.outint,k=log(nrow(data)))
summary(lm.outBICint)
formula(lm.outBICint)

#dimensions des modèles 
# modèle de base : q = 15
# modèle de automatique sans interactions : q = 9
# modèle d'interactions automatique : q = 25


# Un modèle plus simple avec interactions lm.outINT
lm.outINT = stepAIC(lm(P60 ~ .^2, data = data), k = log(nrow(data)), scope = list(lower = . ~ 1, upper = . ~ .^2))
summary(lm.outINT)


# 4 Visualisation des prévisions

x11()
plot(data$P60[1:100],type ="l",main="Productible photovoltaique",xlab="Indice",ylab="[P60]")
points(fitted(lm.outBIC),col="red",pch="+",cex=1.2)
points(fitted(lm.outBICint),col="blue",pch="+",cex=1.2)
legend(0,330,lty=1,col=c("black"),legend=c("o3"),bty="n")
legend(0,320,pch="+",col=c("blue","red"),legend=c("lm.outBICint","lm.outBIC"),bty="n")


# Les deux modèles capturent bien la tendance générale des données, mais lm.outBICint offre une meilleure précision dans les cas de variations extrêmes grâce aux interactions incluses.



# 5 Evaluation des modèles





# Fonction de calcul du RMSE
RMSE = function(obs, pr) {
  return(sqrt(mean((pr - obs)^2)))
}

# Fonction de calcul du biais
BIAIS = function(obs, pr) {
  return(mean(pr - obs))
}

# Estimation des modèles complets
lm.out = lm(P60 ~ ., data = data)
lm.outBIC = stepAIC(lm(P60 ~ ., data = data), k = log(nrow(data)), trace = 0)
lm.outBICint = stepAIC(lm(P60 ~ .^2, data = data), k = log(nrow(data)), trace = 0)
lm.outINT = stepAIC(lm(P60 ~ .^2, data = data), direction = "both", k = log(nrow(data)), steps = 1000)

# Nombre d'itérations pour validation croisée
k = 100

# Matrice pour stocker les scores
tab = matrix(nrow = k, ncol = 16)

for (i in 1:k) {
  # Séparation des données en ensembles d'apprentissage et de test
  nappr = ceiling(0.6 * nrow(data))
  ii = sample(1:nrow(data), nappr)
  jj = setdiff(1:nrow(data), ii)
  datatest = data[jj,]
  datapp = data[ii,]
  
  # Estimation des modèles sur les données d'apprentissage
  lm.out.appr = lm(formula(lm.out), data = datapp)
  lm.outBIC.appr = lm(formula(lm.outBIC), data = datapp)
  lm.outBICint.appr = lm(formula(lm.outBICint), data = datapp)
  lm.outINT.appr = lm(formula(lm.outINT), data = datapp)
  
  # Scores sur apprentissage
  tab[i,1] = RMSE(datapp$P60, predict(lm.out.appr))
  tab[i,2] = RMSE(datapp$P60, predict(lm.outBIC.appr))
  tab[i,3] = RMSE(datapp$P60, predict(lm.outBICint.appr))
  tab[i,4] = RMSE(datapp$P60, predict(lm.outINT.appr))
  
  tab[i,5] = BIAIS(datapp$P60, predict(lm.out.appr))
  tab[i,6] = BIAIS(datapp$P60, predict(lm.outBIC.appr))
  tab[i,7] = BIAIS(datapp$P60, predict(lm.outBICint.appr))
  tab[i,8] = BIAIS(datapp$P60, predict(lm.outINT.appr))


  # Scores sur test
  tab[i,9] = RMSE(datatest$P60, predict(lm.out.appr, datatest))
  tab[i,10] = RMSE(datatest$P60, predict(lm.outBIC.appr, datatest))
  tab[i,11] = RMSE(datatest$P60, predict(lm.outBICint.appr, datatest))
  tab[i,12] = RMSE(datatest$P60, predict(lm.outINT.appr, datatest))
  
  tab[i,13] = BIAIS(datatest$P60, predict(lm.out.appr, datatest))
  tab[i,14] = BIAIS(datatest$P60, predict(lm.outBIC.appr, datatest))
  tab[i,15] = BIAIS(datatest$P60, predict(lm.outBICint.appr, datatest))
  tab[i,16] = BIAIS(datatest$P60, predict(lm.outINT.appr, datatest))
}

# Visualisation des scores RMSE
x11()
boxplot(tab[, 1:4], col = "blue", xlab = "Apprentissage", ylab = "RMSE", 
        names = c("lm.out", "lm.outBIC", "lm.outBICint", "lm.outINT"), main = "Scores RMSE sur Apprentissage")
x11()
boxplot(tab[, 9:12], col = "red", xlab = "Test", ylab = "RMSE", 
        names = c("lm.out", "lm.outBIC", "lm.outBICint", "lm.outINT"), main = "Scores RMSE sur Test")



# Le modèle lm.outBICint  POSS7DE RMSE le plus bas sur les données de test, indiquant qu'il fit mieux aux nouvelles données.



# On peut proposer le modèle lm.outBICint.
# Le modèle lm.outBICint présente les RMSE les plus bas sur les données d'apprentissage et de test, ce qui indique une meilleure performance prédictive.

#Robustesse : Le modèle lm.outBICint montre une bonne généralisation aux données de test avec une variance plus faible, ce qui le rend robuste malgré sa complexité accrue.
