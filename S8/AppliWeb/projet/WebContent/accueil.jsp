<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Accueil</title>
    <link href="https://fonts.googleapis.com/css2?family=Bodoni+Moda:wght@400;600&family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: url('fond.png') no-repeat center center fixed;
            background-size: cover;
            margin: 0;
            padding: 0;
            color: #333; /* Couleur de texte par défaut */
        }
        .logo-container {
            position: absolute;
            top: 20px;
            left: 20px;
            display: flex;
            align-items: center;
        }
        .logo-container img {
            height: 500px; /* Taille du logo */
        }
        .site-name {
            font-family: 'Bodoni Moda', serif; /* Police Bodoni */
            font-size: 1.5em; /* Taille du texte du nom du site */
            font-weight: 600;
        }
        .connexion {
            position: absolute;
            top: 20px;
            right: 20px;
            background-color: #8b4513; /* Marron clair */
            color: #fff;
            padding: 8px 15px; /* Ajuster le padding */
            text-decoration: none;
            border-radius: 20px;
            font-weight: bold;
            transition: background-color 0.3s, color 0.3s;
        }
        .connexion:hover {
            background-color: #6b4226; /* Marron plus foncé */
        }
        .container {
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            text-align: center;
            background: linear-gradient(45deg, #f0e6eb, #f5f5dc); /* Dégradé de rose clair à beige */
            padding: 40px;
            border-radius: 20px; /* Bordures non pointues */
            width: 600px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
            margin: auto; /* Centrer horizontalement */
            font-size: 1.5em; /* Taille de la police */
            overflow: hidden; /* Empêcher le débordement du texte */
            margin-top: 100px; /* Espacement du haut */
        }
        .container h1 {
            font-size: 2em; /* Taille du titre */
            margin-bottom: 10px; /* Espacement inférieur */
            color: #4e2f1e; /* Marron foncé */
        }
        .container p {
            font-size: 1.2em; /* Taille du paragraphe */
            margin-bottom: 30px; /* Espacement inférieur */
            color: #4e2f1e; /* Marron foncé */
        }
        .btn {
            background-color: #8b4513; /* Marron clair */
            color: white;
            padding: 15px 30px;
            text-decoration: none;
            border-radius: 5px;
            transition: background-color 0.3s, transform 0.3s;
            display: inline-block;
            margin: 10px;
            font-size: 1.1em; /* Taille du texte du bouton */
            font-weight: 600;
        }
        .btn:hover {
            background-color: #6b4226; /* Marron plus foncé */
            transform: scale(1.05);
        }
    </style>
</head>
<body>
    <div class="logo-container">
        <img src="logo.png" alt="Logo du site">
    </div>
    <div class="container">
        <h1>Bienvenue sur SkillSpire7</h1>
        <p>Découvrez des opportunités de stage incroyables et lancez votre carrière avec nous !</p>
        <form id="userForm" method="post" action="UserServlet">
            <div>
                <input type="radio" id="etudiant" name="userType" value="etudiant" required>
                <label for="etudiant">Étudiant</label>
            </div>
            <div>
                <input type="radio" id="entreprise" name="userType" value="entreprise" required>
                <label for="entreprise">Entreprise</label>
            </div>
            <button type="submit" name="action" value="inscription" class="btn">Inscription</button>
            <button type="submit" name="action" value="connexion" class="btn">Connexion</button>
        </form>
        <a href="OffresServlet" class="btn">Voir les offres</a>
    </div>
</body>


</html>
