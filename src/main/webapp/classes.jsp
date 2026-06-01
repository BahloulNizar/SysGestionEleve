<%@ page import="java.util.List" %>
<%@ page import="Metier.Classe" %>
<%@ page import="Metier.Filiere" %>
<%@ page import="Metier.Administrateur" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Administrateur admin = (Administrateur) session.getAttribute("adminSession");
    if (admin == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    List<Classe> classes = (List<Classe>) request.getAttribute("classes");
    List<Filiere> filieres = (List<Filiere>) request.getAttribute("filieres");
%>
<html>
<head>
    <title>Administration des Classes | FST</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        :root { --fst-navy: #1e3a8a; --fst-orange: #ea580c; --fst-bg: #f8fafc; }
        body { font-family: 'Inter', sans-serif; background: var(--fst-bg); margin: 0; color: #1e293b; }

        .navbar {
            background: var(--fst-navy); padding: 0 40px; height: 70px;
            display: flex; align-items: center; justify-content: space-between;
            color: white; border-bottom: 5px solid var(--fst-orange);
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }
        .navbar-brand { font-size: 20px; font-weight: 700; display: flex; align-items: center; gap: 15px; }

        .btn-logout {
            background: rgba(255, 255, 255, 0.1); color: white; text-decoration: none;
            padding: 8px 18px; border-radius: 6px; font-size: 14px; font-weight: 600;
            border: 1px solid rgba(255, 255, 255, 0.3); display: flex; align-items: center; gap: 8px;
            transition: 0.3s;
        }
        .btn-logout:hover { background: var(--fst-orange); border-color: var(--fst-orange); }

        .container { padding: 40px; max-width: 1100px; margin: 0 auto; }
        .page-header { margin-bottom: 30px; }
        .page-header h2 { font-size: 24px; font-weight: 700; color: #0f172a; display: flex; align-items: center; gap: 12px; }

        .add-class-card {
            background: white; padding: 25px; border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.05); border: 1px solid #e2e8f0; margin-bottom: 30px;
        }
        .inline-form { display: flex; gap: 15px; align-items: center; }

        .input-group { flex-grow: 1; position: relative; }
        .input-group i { position: absolute; left: 15px; top: 50%; transform: translateY(-50%); color: #94a3b8; z-index: 5; }
        .input-group input, .input-group select {
            width: 100%; padding: 14px 15px 14px 45px; border: 2px solid #f1f5f9;
            border-radius: 10px; outline: none; font-size: 14px; background: #f8fafc; transition: 0.3s;
        }
        .input-group input:focus, .input-group select:focus { border-color: var(--fst-navy); background: white; }

        .btn-submit {
            background: var(--fst-orange); color: white; border: none;
            padding: 14px 25px; border-radius: 10px; font-weight: 700; cursor: pointer;
            display: flex; align-items: center; gap: 8px; transition: 0.3s;
        }
        .btn-submit:hover { background: #c2410c; transform: translateY(-2px); }

        .table-container { background: white; border-radius: 12px; box-shadow: 0 4px 20px rgba(0,0,0,0.05); overflow: hidden; border: 1px solid #e2e8f0; }
        table { width: 100%; border-collapse: collapse; text-align: left; }
        th { padding: 18px 20px; font-size: 12px; text-transform: uppercase; color: #64748b; background: #f1f5f9; }
        td { padding: 16px 20px; font-size: 14px; border-bottom: 1px solid #f1f5f9; }
        tr:hover { background: #f8fafc; }

        .badge-filiere { background: #eff6ff; color: #1e3a8a; padding: 6px 12px; border-radius: 20px; font-weight: 600; font-size: 12px; border: 1px solid #dbeafe; }
        .btn-delete { color: #ef4444; background: #fef2f2; padding: 10px; border-radius: 8px; text-decoration: none; transition: 0.3s; }
        .btn-delete:hover { background: #ef4444; color: white; }

        .back-nav-container { text-align: center; margin-top: 40px; }

        .back-link-animated {
            display: inline-flex; align-items: center; gap: 10px;
            color: #64748b; text-decoration: none; font-size: 15px; font-weight: 600;
            transition: all 0.3s ease; padding: 10px 20px; border-radius: 8px;
        }

        .back-link-animated:hover {
            color: var(--fst-navy); background: #eff6ff;
            transform: translateX(-5px);
        }

        .back-link-animated i { transition: transform 0.3s ease; }
        .back-link-animated:hover i { transform: scale(1.2); }
    </style>
</head>
<body>

<nav class="navbar">
    <div class="navbar-brand">
        <i class="fas fa-university" style="color: var(--fst-orange); font-size: 26px;"></i>
        <span>FST | Configuration</span>
    </div>
    <div style="display: flex; align-items: center; gap: 20px;">
        <span style="font-size: 14px;"><i class="fas fa-user-circle"></i> <%= admin.getNom() %></span>
        <a href="logout" class="btn-logout"><i class="fas fa-sign-out-alt"></i> Déconnexion</a>
    </div>
</nav>

<div class="container">
    <div class="page-header">
        <h2><i class="fas fa-layer-group" style="color: var(--fst-navy);"></i> Gestion des Classes par Filière</h2>
    </div>

    <div class="add-class-card">
        <form action="ajouterClasse" method="POST" class="inline-form">
            <div class="input-group">
                <i class="fas fa-scroll"></i>
                <select name="idFiliere" required>
                    <option value="" disabled selected>Choisir une Filière...</option>
                    <% if(filieres != null) { for(Filiere f : filieres) { %>
                    <option value="<%= f.getId() %>"><%= f.getNom() %> (<%= f.getCode() %>)</option>
                    <% } } %>
                </select>
            </div>
            <div class="input-group">
                <i class="fas fa-users"></i>
                <input type="text" name="nom" placeholder="Nom du Groupe (ex: Groupe A, 2BAC...)" required>
            </div>
            <button type="submit" class="btn-submit"><i class="fas fa-plus"></i> Ajouter</button>
        </form>
    </div>

    <div class="table-container">
        <table>
            <thead>
            <tr>
                <th width="80">ID</th>
                <th>Nom de la Classe</th>
                <th>Filière Associée</th>
                <th width="150" style="text-align: right;">Actions</th>
            </tr>
            </thead>
            <tbody>
            <% if(classes != null && !classes.isEmpty()) {
                for(Classe c : classes) { %>
            <tr>
                <td><span style="color: #94a3b8; font-weight: 600;">#<%= c.getId() %></span></td>
                <td><strong><%= c.getNom() %></strong></td>
                <td>
                    <span class="badge-filiere">
                        <i class="fas fa-graduation-cap" style="margin-right: 5px; font-size: 10px;"></i>
                        <%= (c.getFiliere() != null) ? c.getFiliere().getNom() : "Non assignée" %>
                    </span>
                </td>
                <td style="text-align: right; padding-right: 20px;">
                    <a href="supprimerClasse?id=<%= c.getId() %>" class="btn-delete" title="Supprimer" onclick="return confirm('Supprimer cette classe ?');">
                        <i class="fas fa-trash-alt"></i>
                    </a>
                </td>
            </tr>
            <% } } else { %>
            <tr>
                <td colspan="4" style="text-align:center; padding: 60px; color: #94a3b8;">
                    <i class="fas fa-folder-open" style="font-size: 30px; display: block; margin-bottom: 10px; opacity: 0.5;"></i>
                    Aucune classe trouvée.
                </td>
            </tr>
            <% } %>
            </tbody>
        </table>
    </div>

    <div class="back-nav-container">
        <a href="dashboard.jsp" class="back-link-animated">
            <i class="fas fa-arrow-left"></i>
            <span>Retour au Tableau de Bord</span>
        </a>
    </div>
</div>

</body>
</html>