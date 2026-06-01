<%@ page import="java.util.List" %>
<%@ page import="Metier.Classe" %>
<%@ page import="Metier.Eleve" %>
<%@ page import="Metier.Administrateur" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Administrateur admin = (Administrateur) session.getAttribute("adminSession");
    if (admin == null) { response.sendRedirect("login.jsp"); return; }

    Eleve e = (Eleve) request.getAttribute("eleve");
    List<Classe> classes = (List<Classe>) request.getAttribute("classes");

    if (e == null) {
        response.sendRedirect("listeEleves");
        return;
    }
%>
<html>
<head>
    <title>Modifier Étudiant | FST</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        :root {
            --fst-navy: #1e3a8a;
            --fst-orange: #ea580c;
            --fst-bg: #f8fafc;
            --border-color: #e2e8f0;
        }

        body { font-family: 'Inter', sans-serif; background: var(--fst-bg); margin: 0; color: #1e293b; }

        .navbar {
            background: var(--fst-navy);
            padding: 0 40px;
            height: 70px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            color: white;
            border-bottom: 5px solid var(--fst-orange);
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }
        .navbar-brand { font-size: 20px; font-weight: 700; display: flex; align-items: center; gap: 12px; }

        .container { max-width: 800px; margin: 40px auto; padding: 0 20px; }

        .form-card {
            background: white;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.05);
            border: 1px solid var(--border-color);
            overflow: hidden;
        }

        .card-header {
            background: #f1f5f9;
            padding: 20px 30px;
            border-bottom: 2px solid var(--border-color);
            display: flex;
            align-items: center;
            gap: 15px;
        }
        .card-header h2 { margin: 0; font-size: 18px; color: var(--fst-navy); }
        .card-header i { color: var(--fst-orange); font-size: 22px; }

        .card-body { padding: 30px; }

        .form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 25px;
        }
        .full-width { grid-column: span 2; }

        .form-group { display: flex; flex-direction: column; gap: 8px; }
        .form-group label { font-size: 13px; font-weight: 600; color: #64748b; text-transform: uppercase; }

        .form-group input, .form-group select {
            padding: 12px 15px;
            border: 1px solid var(--border-color);
            border-radius: 8px;
            font-size: 14px;
            transition: 0.3s;
            font-family: inherit;
        }
        .form-group input:focus, .form-group select:focus {
            outline: none;
            border-color: var(--fst-navy);
            box-shadow: 0 0 0 3px rgba(30, 58, 138, 0.1);
        }

        .form-actions {
            margin-top: 30px;
            padding-top: 20px;
            border-top: 1px solid var(--border-color);
            display: flex;
            justify-content: flex-end;
            gap: 15px;
        }

        .btn {
            padding: 12px 25px;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            text-decoration: none;
            font-size: 14px;
            transition: 0.3s;
            display: inline-flex;
            align-items: center;
            gap: 10px;
            border: none;
        }

        .btn-save { background: var(--fst-navy); color: white; }
        .btn-save:hover { background: #152a61; transform: translateY(-2px); }

        .btn-cancel { background: #e2e8f0; color: #475569; }
        .btn-cancel:hover { background: #cbd5e1; }

        .badge-info {
            background: #eff6ff;
            color: var(--fst-navy);
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 25px;
            font-size: 14px;
            border-left: 4px solid var(--fst-navy);
        }
    </style>
</head>
<body>

<nav class="navbar">
    <div class="navbar-brand">
        <i class="fas fa-university" style="color: var(--fst-orange); font-size: 26px;"></i>
        <span>FST | Académique</span>
    </div>
    <div style="display: flex; align-items: center; gap: 20px;">
        <span style="font-size: 14px;"><i class="fas fa-user-circle"></i> <%= admin.getNom() %></span>
    </div>
</nav>

<div class="container">
    <div class="form-card">
        <div class="card-header">
            <i class="fas fa-user-edit"></i>
            <h2>Modification du dossier étudiant</h2>
        </div>

        <div class="card-body">
            <div class="badge-info">
                <i class="fas fa-info-circle"></i> Vous modifiez actuellement le profil de :
                <strong><%= e.getNom().toUpperCase() %> <%= e.getPrenom() %></strong> (ID: #<%= e.getId() %>)
            </div>

            <form action="modifierEleve" method="POST">
                <input type="hidden" name="id" value="<%= e.getId() %>">

                <div class="form-grid">
                    <div class="form-group full-width">
                        <label>Matricule</label>
                        <input type="text" name="matricule" value="<%= e.getMatricule() %>" required>
                    </div>

                    <div class="form-group">
                        <label>Nom</label>
                        <input type="text" name="nom" value="<%= e.getNom() %>" required>
                    </div>

                    <div class="form-group">
                        <label>Prénom</label>
                        <input type="text" name="prenom" value="<%= e.getPrenom() %>" required>
                    </div>

                    <div class="form-group full-width">
                        <label>Date de Naissance</label>
                        <input type="date" name="dateNaissance" value="<%= e.getDateNaissance() %>" required>
                    </div>

                    <div class="form-group full-width">
                        <label>Filière / Classe</label>
                        <select name="idClasse" required>
                            <% if(classes != null) {
                                for(Classe c : classes) { %>
                            <option value="<%= c.getId() %>"
                                    <%= (e.getClasse() != null && c.getId() == e.getClasse().getId()) ? "selected" : "" %>>
                                <%= c.getNom() %>
                            </option>
                            <%  }
                            } %>
                        </select>
                    </div>
                </div>

                <div class="form-actions">
                    <a href="listeEleves" class="btn btn-cancel">Annuler</a>
                    <button type="submit" class="btn btn-save">
                        <i class="fas fa-check-circle"></i> Enregistrer les modifications
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

</body>
</html>