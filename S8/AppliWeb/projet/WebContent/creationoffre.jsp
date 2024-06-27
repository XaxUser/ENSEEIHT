<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Création d'une offre d'emploi</title>
    <!-- Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <style>
        /* Styles spécifiques */
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(45deg, #f0e6eb, #f5f5dc); /* Dégradé de rose clair à beige */
            margin: 0;
            padding: 0;
            color: #333; /* Couleur de texte par défaut */
        }
        
        .container {
            padding: 20px;
        }
        .form-group {
            margin-bottom: 20px;
        }
        .form-control {
            background-color: #fff; /* Fond blanc */
            border-radius: 5px; /* Bordures arrondies */
            border: none;
            box-shadow: 0px 5px 20px rgba(0, 0, 0, 0.1);
        }
        .btn-primary {
            background-color: #8b4513; /* Marron clair */
            border: none;
            border-radius: 5px;
            font-weight: bold;
            transition: background-color 0.3s, transform 0.3s;
        }
        .btn-primary:hover {
            background-color: #6b4226; /* Marron plus foncé */
            transform: scale(1.05);
        }
        .logo-container {
            position: absolute;
            top: 20px;
            left: 20px;
        }
        .logo-container img {
            height: 180px; /* Taille du logo */
        }
    </style>
</head>
<body>
    <div class="logo-container">
        <img src="logo.png" alt="Logo du site">
    </div>
    <div class="logout-container">
        <form action="LogOutServlet" method="post">
            <button type="submit" class="btn btn-logout">Déconnexion</button>
        </form>
    </div>
    <div class="container">
        <h1>Création d'une offre d'emploi</h1>
        <form action="" method="post">
            <div class="form-group">
                <label for="titre">Titre de l'offre</label>
                <input type="text" class="form-control" id="titre" name="titre" required>
            </div>
            <div class="form-group">
                <label for="domaine">Domaine</label>
                <input type="text" class="form-control" id="domaine" name="domaine" required>
            </div>
            <div class="form-group">
                <label for="lieu">Lieu</label>
                <input type="text" class="form-control" id="lieu" name="lieu" required>
            </div>
            <div class="form-group">
                <label for="duree">Durée</label>
                <input type="text" class="form-control" id="duree" name="duree" required>
            </div>
            <div class="form-group">
                <label for="poste">Poste</label>
                <input type="text" class="form-control" id="poste" name="poste" required>
            </div>
            <div class="form-group">
                <label for="descriptif">Descriptif</label>
                <textarea class="form-control" id="descriptif" name="descriptif" rows="4" required></textarea>
            </div>
            <div class="form-group">
                <label for="remuneration">Rémunération</label>
                <input type="text" class="form-control" id="remuneration" name="remuneration">
            </div>
            <button type="submit" class="btn btn-primary">Créer l'offre</button>
        </form>
    </div>

    <!-- Bootstrap JS and dependencies -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
