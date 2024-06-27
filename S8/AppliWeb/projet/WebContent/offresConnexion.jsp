<%@ page import="pack.entities.Offre" %>
<%@ page import="java.util.Collection" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Liste des offres</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
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
            height: 200px; /* Taille du logo */
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
            width: 800px;
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
        .card {
            margin-bottom: 20px;
            border: none;
            box-shadow: 0px 5px 20px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
            width: 100%;
            background-color: #fff; /* Fond blanc */
            border-radius: 10px; /* Bordures arrondies */
            padding: 20px; /* Espacement intérieur */
        }
        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0px 10px 30px rgba(0, 0, 0, 0.1);
        }
        .card-title {
            color: #333;
            font-size: 1.5rem;
            font-weight: bold;
            margin-bottom: 10px;
        }
        .card-text {
            color: #666;
            font-size: 1.2rem;
            margin-bottom: 5px;
        }
        .btn-postuler {
            margin-top: 10px;
            background-color: #8b4513; /* Marron clair */
            color: #fff; /* Texte blanc */
            padding: 10px 20px; /* Espacement du bouton */
            border: none;
            border-radius: 5px;
            font-size: 1em; /* Taille de la police */
            font-weight: bold;
            transition: background-color 0.3s, transform 0.3s;
        }
        .btn-postuler:hover {
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
        <h1>Liste des offres</h1>
        <% 
            Collection<Offre> offres = (Collection<Offre>) request.getAttribute("offres");
            if (offres != null) {
                for (Offre offre : offres) {
        %>
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title"><%= offre.getTitre() %></h5>
                    <p class="card-text">Lieu: <%= offre.getLieu() %></p>
                    <p class="card-text">Durée: <%= offre.getDuree() %></p>
                    <p class="card-text">Descriptif: <%= offre.getDescriptif() %></p>
                    <p class="card-text">Rémunération: <%= offre.getRemuneration() %></p>
                    <!-- Formulaire de postulation -->
                    <form action="PostulerOffreServlet" method="post">
                        <input type="hidden" name="offreId" value="<%= offre.getId() %>">
                        <button type="submit" class="btn btn-postuler">Postuler</button>
                    </form>
                </div>
            </div>
        <% 
                }
            } else {
        %>
            <p>Aucune offre disponible.</p>
        <% 
            }
        %>
    </div>

    <!-- Bootstrap JS and dependencies -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
