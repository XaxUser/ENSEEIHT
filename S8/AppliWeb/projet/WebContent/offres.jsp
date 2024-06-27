<%@ page import="pack.entities.Offre" %>
<%@ page import="java.util.Collection" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Liste des offres</title>
    <!-- Liens CSS -->
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
            padding: 20px;
        }
        .offre-list {
            list-style-type: none;
            padding: 0;
        }
        .offre-item {
            margin-bottom: 20px;
            background-color: #fff; /* Fond blanc */
            border-radius: 10px; /* Bordures arrondies */
            box-shadow: 0px 5px 20px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
        }
        .offre-item:hover {
            transform: translateY(-5px);
            box-shadow: 0px 10px 30px rgba(0, 0, 0, 0.1);
        }
        .offre-title {
            font-size: 1.5rem;
            font-weight: bold;
            margin-bottom: 10px;
        }
        .offre-details {
            margin-bottom: 10px;
        }
        .offre-description {
            color: #666;
            font-size: 1.2rem;
        }
        .btn-postuler {
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
    <!-- Logo -->
    <div class="logo-container">
        <img src="logo.png" alt="Logo du site">
    </div>
    <!-- Liste des offres -->
    <div class="container">
        <h1>Liste des offres</h1>
        <ul class="offre-list">
            <% 
                Collection<Offre> offres = (Collection<Offre>) request.getAttribute("offres");
                if (offres != null) {
                    for (Offre offre : offres) {
            %>
                <li class="offre-item">
                    <div class="offre-details">
                        <h2 class="offre-title"><%= offre.getTitre() %></h2>
                        <p class="offre-description">Lieu: <%= offre.getLieu() %></p>
                        <p class="offre-description">Durée: <%= offre.getDuree() %></p>
                        <p class="offre-description">Descriptif: <%= offre.getDescriptif() %></p>
                        <p class="offre-description">Rémunération: <%= offre.getRemuneration() %></p>
                    </div>
                    <!-- Formulaire de postulation -->
                    <form action="PostulerOffreServlet" method="post">
                        <input type="hidden" name="offreId" value="<%= offre.getId() %>">
                    </form>
                </li>
            <% 
                    }
                } else {
            %>
                <p>Aucune offre disponible.</p>
            <% 
                }
            %>
        </ul>
    </div>

    <!-- Liens JS -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
