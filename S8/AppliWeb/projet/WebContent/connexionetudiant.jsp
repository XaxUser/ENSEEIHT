<%@ include file="head.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<head>
    <!-- Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .error-message {
            color: red;
            margin-top: 10px;
        }
    </style>
</head>
<body style="background: url('fond.png') no-repeat center center fixed; background-size: cover;">
<div class="logo-container">
    <img src="logo.png" alt="Logo du site" style="height: 200px;"> <!-- Ajustement de la taille du logo -->
</div>
<div class="container" style="max-width: 1000px;"> <!-- Augmentation de la largeur maximale -->
    <div class="row justify-content-center">
        <div class="col-md-8"> <!-- Augmentation de la largeur du formulaire -->
            <div class="card mt-5" style="background: linear-gradient(45deg, #f0e6eb, #f5f5dc);">
                <div class="card-header text-center" style="background-color: #f5f5dc;">
                    <h3>Connexion</h3>
                </div>
                <div class="card-body">
                    <form action="ConnexionEtudiantServlet" method="post">
                        <div class="form-group">
                            <label for="username">Nom d'utilisateur</label>
                            <input type="text" class="form-control" id="username" name="username" required>
                        </div>
<div class="form-group">
    <label for="password">Mot de passe</label>
    <div class="input-group">
        <input type="password" class="form-control" id="password" name="password" required>
        <div class="input-group-append">
            <span class="input-group-text" id="togglePassword">
                <i class="fas fa-eye"></i>
            </span>
        </div>
    </div>
</div>

                        <button type="submit" class="btn btn-primary btn-block" style="background-color: #8b4513;">Se connecter</button>
                    </form>
                    <c:if test="${not empty errorMessage}">
                        <div class="error-message">${errorMessage}</div>
                    </c:if>
                </div>
                <div class="card-footer text-center">
                    <a href="InscriptionEtudiantServlet" style="color: #8b4513;">Créer un compte</a>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap JS and dependencies -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script>
    document.addEventListener('DOMContentLoaded', (event) => {
        const togglePassword = document.querySelector('#togglePassword');
        const password = document.querySelector('#password');

        togglePassword.addEventListener('click', function (e) {
            const type = password.getAttribute('type') === 'password' ? 'text' : 'password';
            password.setAttribute('type', type);
            this.querySelector('i').classList.toggle('fa-eye-slash');
        });
    });
</script>

</body>
</html>
