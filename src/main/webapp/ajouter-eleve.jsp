<%@ page import="java.util.List" %>
<%@ page import="Metier.Classe" %>
<%@ page import="Metier.Administrateur" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Administrateur admin = (Administrateur) session.getAttribute("adminSession");
    if (admin == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    List<Classe> classes = (List<Classe>) request.getAttribute("classes");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Inscrire Étudiant | FST</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        :root { --fst-navy: #1e3a8a; --fst-orange: #ea580c; --fst-bg: #f8fafc; --border: #e2e8f0; }
        body { font-family: 'Inter', sans-serif; background: var(--fst-bg); margin: 0; color: #1e293b; }

        .navbar {
            background: var(--fst-navy); padding: 0 40px; height: 70px;
            display: flex; align-items: center; justify-content: space-between;
            color: white; border-bottom: 5px solid var(--fst-orange);
        }
        .navbar-brand { font-size: 20px; font-weight: 700; display: flex; align-items: center; gap: 12px; }

        .container { max-width: 800px; margin: 40px auto; padding: 0 20px; }

        .main-card {
            background: white; border-radius: 16px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.05);
            border: 1px solid var(--border); padding: 40px;
        }

        .form-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 25px; }
        .full-width { grid-column: span 2; }

        .field-group { display: flex; flex-direction: column; gap: 8px; }
        .field-group label { font-size: 12px; font-weight: 700; color: #64748b; text-transform: uppercase; }

        .field-group input, .field-group select {
            padding: 14px; border: 2px solid #f1f5f9; border-radius: 10px;
            font-size: 15px; background: #f8fafc; outline: none; transition: 0.3s;
            box-sizing: border-box;
        }
        .field-group input:focus, .field-group select:focus { border-color: var(--fst-navy); background: white; }

        .form-footer {
            margin-top: 40px; padding-top: 25px; border-top: 1px solid var(--border);
            display: flex; justify-content: space-between; align-items: center;
        }

        .btn-save {
            background: var(--fst-orange); color: white; padding: 14px 35px;
            border-radius: 10px; font-weight: 700; border: none; cursor: pointer;
            display: flex; align-items: center; gap: 10px; transition: 0.3s;
        }
        .btn-save:hover { background: #c2410c; transform: translateY(-2px); }

        .link-back { color: #64748b; text-decoration: none; font-weight: 600; display: flex; align-items: center; gap: 8px; }
    </style>
</head>
<body>

<nav class="navbar">
    <div class="navbar-brand">
        <i class="fas fa-university"></i>
        <span>FST | Académique</span>
    </div>
    <div style="font-size: 14px;">
        <i class="fas fa-user-circle"></i> <%= admin.getNom() %>
    </div>
</nav>

<div class="container">
    <div style="display: flex; align-items: center; gap: 15px; margin-bottom: 30px; color: var(--fst-navy);">
        <i class="fas fa-user-plus" style="font-size: 28px; color: var(--fst-orange);"></i>
        <h2 style="margin: 0;">Inscrire un Nouvel Étudiant</h2>
    </div>

    <div class="main-card">
        <form action="ajouterEleve" method="POST">
            <div class="form-grid">
                <div class="field-group full-width">
                    <label>Matricule</label>
                    <input type="text" name="matricule" placeholder="Ex: 2024-001" required>
                </div>

                <div class="field-group">
                    <label>Nom</label>
                    <input type="text" name="nom" placeholder="Nom de famille" required>
                </div>

                <div class="field-group">
                    <label>Prénom</label>
                    <input type="text" name="prenom" placeholder="Prénom" required>
                </div>

                <div class="field-group full-width">
                    <label>Date de Naissance</label>
                    <input type="date" name="dateNaissance" required>
                </div>

                <div class="field-group full-width">
                    <label>Classe / Filière</label>
                    <select name="idClasse" required>
                        <option value="">-- Sélectionner --</option>
                        <% if(classes != null) { for(Classe c : classes) { %>
                        <option value="<%= c.getId() %>"><%= c.getNom() %></option>
                        <% } } %>
                    </select>
                </div>
            </div>

            <div class="form-footer">
                <a href="listeEleves" class="link-back">
                    <i class="fas fa-arrow-left"></i> Retour
                </a>
                <button type="submit" class="btn-save">
                    <i class="fas fa-check"></i> Enregistrer
                </button>
            </div>
        </form>
    </div>
</div>

</body>
</html>