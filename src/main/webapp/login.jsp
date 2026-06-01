<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Authentification | FST</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        * { box-sizing: border-box; font-family: 'Inter', sans-serif; }
        body { margin: 0; height: 100vh; display: flex; align-items: center; justify-content: center; background: #f0f2f5; }

        .login-wrapper { display: flex; background: #ffffff; border-radius: 12px; box-shadow: 0 10px 40px rgba(0,0,0,0.08); overflow: hidden; width: 100%; max-width: 900px; min-height: 500px; }

        .login-brand { background: linear-gradient(135deg, #1e3a8a 0%, #172554 100%); width: 45%; padding: 50px 40px; color: white; display: flex; flex-direction: column; justify-content: center; align-items: center; text-align: center; position: relative; }
        .login-brand::after { content: ''; position: absolute; bottom: 0; left: 0; width: 100%; height: 6px; background: #ea580c; }
        .brand-icon { font-size: 60px; color: #ea580c; margin-bottom: 20px; }
        .login-brand h1 { font-size: 34px; margin: 0 0 10px 0; font-weight: 700; letter-spacing: 2px; }
        .login-brand p { font-size: 14px; opacity: 0.9; line-height: 1.6; }

        .login-form-container { width: 55%; padding: 50px 60px; display: flex; flex-direction: column; justify-content: center; }
        .login-form-container h2 { color: #0f172a; font-size: 24px; margin-bottom: 30px; font-weight: 600; }

        .error-message { background: #fef2f2; border-left: 4px solid #ef4444; color: #b91c1c; padding: 12px 15px; font-size: 13px; margin-bottom: 20px; border-radius: 4px; }

        .form-group { margin-bottom: 20px; }
        .form-group label { display: block; font-size: 13px; font-weight: 600; color: #475569; margin-bottom: 8px; }
        .input-icon-wrapper { position: relative; }
        .input-icon-wrapper i { position: absolute; left: 15px; top: 50%; transform: translateY(-50%); color: #94a3b8; }
        .input-icon-wrapper input { width: 100%; padding: 12px 15px 12px 45px; border: 1px solid #cbd5e1; border-radius: 8px; font-size: 14px; outline: none; transition: 0.3s; }
        .input-icon-wrapper input:focus { border-color: #1e3a8a; box-shadow: 0 0 0 3px rgba(30, 58, 138, 0.1); }

        .btn-submit { width: 100%; padding: 14px; background: #ea580c; color: white; border: none; border-radius: 8px; font-weight: 600; font-size: 15px; cursor: pointer; transition: 0.3s; margin-top: 10px; }
        .btn-submit:hover { background: #c2410c; }

        .univ-logo { position: absolute; top: 25px; left: 25px; font-size: 11px; font-weight: 700; color: rgba(255,255,255,0.7); text-transform: uppercase; letter-spacing: 1.5px; }

        @media (max-width: 768px) { .login-wrapper { flex-direction: column; max-width: 400px; } .login-brand { width: 100%; padding: 40px 20px; } .login-form-container { width: 100%; padding: 40px 20px; } }
    </style>
</head>
<body>

<div class="login-wrapper">
    <div class="login-brand">
        <div class="univ-logo">Université Publique</div>
        <i class="fas fa-university brand-icon"></i>
        <h1>FST</h1>
        <p>Faculté des Sciences et Techniques<br><br>Système Global de Gestion Académique</p>
    </div>

    <div class="login-form-container">
        <h2>Accès Sécurisé</h2>

        <% if(request.getAttribute("erreur") != null) { %>
        <div class="error-message">
            <i class="fas fa-exclamation-triangle"></i> Identifiants incorrects. Veuillez réessayer.
        </div>
        <% } %>

        <form action="login" method="POST">
            <div class="form-group">
                <label>Identifiant Académique (Email)</label>
                <div class="input-icon-wrapper">
                    <i class="fas fa-envelope"></i>
                    <input type="email" name="email" placeholder="admin@fst.ac.ma" required>
                </div>
            </div>

            <div class="form-group">
                <label>Mot de Passe</label>
                <div class="input-icon-wrapper">
                    <i class="fas fa-lock"></i>
                    <input type="password" name="password" placeholder="••••••••••••" required>
                </div>
            </div>

            <button type="submit" class="btn-submit">Se Connecter</button>
        </form>
    </div>
</div>

</body>
</html>