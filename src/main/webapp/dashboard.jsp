<%@ page import="Metier.Administrateur" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Administrateur admin = (Administrateur) session.getAttribute("adminSession");
    if (admin == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Espace Administratif | FST</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        :root {
            --fst-navy: #1e3a8a;
            --fst-orange: #ea580c;
            --fst-bg: #f8fafc;
            --text-main: #1e293b;
            --text-light: #64748b;
        }

        body {
            font-family: 'Inter', sans-serif;
            background: var(--fst-bg);
            margin: 0;
            color: var(--text-main);
        }

        .navbar {
            background: var(--fst-navy);
            padding: 0 40px;
            height: 70px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            color: white;
            border-bottom: 4px solid var(--fst-orange);
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }
        .navbar-brand {
            font-size: 20px;
            font-weight: 700;
            display: flex;
            align-items: center;
            gap: 15px;
        }
        .navbar-user {
            display: flex;
            align-items: center;
            gap: 20px;
            font-size: 14px;
            font-weight: 600;
        }
        .btn-logout {
            background: rgba(255,255,255,0.1);
            color: white;
            text-decoration: none;
            padding: 8px 15px;
            border-radius: 6px;
            border: 1px solid rgba(255,255,255,0.2);
            transition: 0.3s;
        }
        .btn-logout:hover {
            background: var(--fst-orange);
            border-color: var(--fst-orange);
        }

        .main-container {
            padding: 60px 20px;
            max-width: 1200px;
            margin: 0 auto;
            text-align: center;
        }
        .welcome-header h2 {
            color: #0f172a;
            font-size: 32px;
            margin-bottom: 10px;
        }
        .welcome-header p {
            color: var(--text-light);
            font-size: 16px;
            margin-bottom: 50px;
        }

        .modules-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 25px;
            justify-items: center;
        }

        .module-card {
            background: white;
            width: 100%;
            max-width: 300px;
            padding: 35px 25px;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.05);
            text-decoration: none;
            color: var(--text-main);
            border: 1px solid #e2e8f0;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        .module-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 4px;
            background: #cbd5e1;
            transition: 0.3s;
        }
        .module-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 15px 30px rgba(0,0,0,0.1);
            border-color: var(--fst-orange);
        }
        .module-card:hover::before {
            background: var(--fst-orange);
        }

        .icon-wrapper {
            width: 70px;
            height: 70px;
            background: #eff6ff;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 20px;
            transition: 0.3s;
        }
        .module-card:hover .icon-wrapper {
            background: #dbeafe;
        }
        .module-card i {
            font-size: 28px;
            color: var(--fst-navy);
        }

        .module-card h3 {
            margin: 0 0 12px 0;
            font-size: 19px;
            color: #0f172a;
        }
        .module-card p {
            margin: 0;
            color: var(--text-light);
            font-size: 14px;
            line-height: 1.6;
        }
    </style>
</head>
<body>

<nav class="navbar">
    <div class="navbar-brand">
        <i class="fas fa-university" style="color: var(--fst-orange); font-size: 26px;"></i>
        <span>FST | Portail Administratif</span>
    </div>
    <div class="navbar-user">
        <span><i class="fas fa-user-circle"></i> <%= admin.getNom() %></span>
        <a href="logout" class="btn-logout"><i class="fas fa-sign-out-alt"></i> Déconnexion</a>
    </div>
</nav>

<div class="main-container">
    <div class="welcome-header">
        <h2>Tableau de Bord Principal</h2>
        <p>Gérez l'ensemble du système académique à partir de ces modules.</p>
    </div>

    <div class="modules-grid">
        <a href="filieres" class="module-card">
            <div class="icon-wrapper"><i class="fas fa-scroll"></i></div>
            <h3>Filières</h3>
            <p>Définir les programmes d'études (ex: Développement, Marketing, etc.).</p>
        </a>

        <a href="classes" class="module-card">
            <div class="icon-wrapper"><i class="fas fa-layer-group"></i></div>
            <h3>Classes</h3>
            <p>Administrer les groupes et les promotions rattachés aux filières.</p>
        </a>

        <a href="listeEleves" class="module-card">
            <div class="icon-wrapper"><i class="fas fa-user-graduate"></i></div>
            <h3>Étudiants</h3>
            <p>Consulter, inscrire ou modifier les dossiers complets des étudiants.</p>
        </a>

        <a href="matieres" class="module-card">
            <div class="icon-wrapper"><i class="fas fa-book"></i></div>
            <h3>Matières</h3>
            <p>Configurer les modules d'enseignement et gérer les coefficients.</p>
        </a>

        <a href="notes" class="module-card">
            <div class="icon-wrapper"><i class="fas fa-star"></i></div>
            <h3>Saisie des Notes</h3>
            <p>Enregistrer les notes et générer les relevés de notes (Bulletins).</p>
        </a>
    </div>
</div>

</body>
</html>