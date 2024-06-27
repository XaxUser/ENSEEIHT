<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Inscription Entreprise</title>
    <!-- Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
</head>
<body style="background: url('fond.png') no-repeat center center fixed; background-size: cover;">
<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-8"> <!-- Augmentation de la largeur du formulaire -->
            <div class="card mt-5" style="background: linear-gradient(45deg, #f0e6eb, #f5f5dc);">
                <div class="card-header text-center" style="background-color: #f5f5dc;">
                    <h3>Inscription Entreprise</h3>
                </div>
                <div class="card-body">
                    <form action="InscriptionEntrepriseServlet" method="post">
                        <div class="form-group">
                            <label for="nom">Nom de l'entreprise</label>
                            <input type="text" class="form-control" id="nom" name="nom" required>
                        </div>
                        <div class="form-group">
                            <label for="secteurActivite">Secteur d'activité</label>
                            <input type="text" class="form-control" id="secteurActivite" name="secteurActivite" required>
                        </div>
                        <div class="form-group">
                            <label for="email">Adresse e-mail</label>
                            <input type="email" class="form-control" id="email" name="email" required>
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
                        <div class="form-group">
                            <label for="phone">Numéro de téléphone</label>
                            <input type="text" class="form-control" id="phone" name="phone">
                        </div>
                        <div class="form-group">
                            <label for="adresse">Adresse</label>
                            <input type="text" class="form-control" id="adresse" name="adresse">
                        </div>
                        <button type="submit" class="btn btn-primary btn-block" style="background-color: #8b4513;">S'inscrire</button>
                    </form>
                </div>
                <div class="card-footer text-center">
                    <a href="ConnexionEntrepriseServlet" style="color: #8b4513;">Déjà un compte ? Connexion</a>
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
