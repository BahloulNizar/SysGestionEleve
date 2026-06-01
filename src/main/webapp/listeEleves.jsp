<%@ page import="java.util.List" %>
<%@ page import="Metier.Eleve" %>
<%@ page import="Metier.Classe" %>
<%@ page import="Metier.Administrateur" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Administrateur admin = (Administrateur) session.getAttribute("adminSession");
    if (admin == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    List<Eleve> eleves = (List<Eleve>) request.getAttribute("eleves");
    List<Classe> classes = (List<Classe>) request.getAttribute("classes");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Gestion des Étudiants | FST</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet">
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
        .navbar-brand { font-size: 20px; font-weight: 700; display: flex; align-items: center; gap: 12px; }

        .btn-logout {
            background: rgba(255, 255, 255, 0.1); color: white; text-decoration: none;
            padding: 8px 18px; border-radius: 6px; font-size: 14px; font-weight: 600;
            border: 1px solid rgba(255, 255, 255, 0.3); display: flex; align-items: center; gap: 8px;
            transition: 0.3s;
        }
        .btn-logout:hover { background: var(--fst-orange); border-color: var(--fst-orange); }

        .container { max-width: 1200px; margin: 40px auto; padding: 0 20px; }

        .filter-card {
            background: white; padding: 20px; border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.05); border: 1px solid #e2e8f0;
            margin-bottom: 25px;
            display: flex;
            gap: 20px;
            align-items: center;
        }
        .search-input { flex: 2; position: relative; }
        .filter-select { flex: 1; }

        .search-input i { position: absolute; left: 15px; top: 50%; transform: translateY(-50%); color: #94a3b8; }

        .search-input input, .filter-select select {
            width: 100%;
            padding: 12px 15px 12px 45px;
            border: 2px solid #f1f5f9;
            border-radius: 10px;
            outline: none;
            background: #f8fafc;
            transition: 0.3s;
            box-sizing: border-box;
        }
        .filter-select select { padding-left: 15px; cursor: pointer; }

        .header-actions { display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; }
        .btn-add { background: var(--fst-orange); color: white; text-decoration: none; padding: 12px 20px; border-radius: 8px; font-weight: 600; display: flex; align-items: center; gap: 10px; transition: 0.3s; }
        .btn-add:hover { background: #c2410c; }

        .table-container { background: white; border-radius: 12px; box-shadow: 0 4px 15px rgba(0,0,0,0.05); overflow: hidden; border: 1px solid #e2e8f0; }
        table { width: 100%; border-collapse: collapse; }
        th { background: #f1f5f9; padding: 15px; font-size: 12px; text-transform: uppercase; color: #64748b; text-align: left; }
        td { padding: 15px; border-bottom: 1px solid #f1f5f9; font-size: 14px; }

        .btn-action { padding: 8px; border-radius: 6px; transition: 0.3s; margin-left: 5px; text-decoration: none; display: inline-flex; align-items: center; justify-content: center; min-width: 35px; }
        .btn-releve { color: #6366f1; background: #eef2ff; }
        .btn-releve:hover { background: #6366f1; color: white; }
        .btn-pdf-direct { color: #10b981; background: #ecfdf5; }
        .btn-pdf-direct:hover { background: #10b981; color: white; }
        .btn-edit { color: #0ea5e9; background: #f0f9ff; }
        .btn-edit:hover { background: #0ea5e9; color: white; }
        .btn-delete { color: #ef4444; background: #fef2f2; }
        .btn-delete:hover { background: #ef4444; color: white; }

        .back-nav-container { text-align: center; margin-top: 40px; }
        .back-link-animated {
            display: inline-flex; align-items: center; gap: 10px;
            color: #64748b; text-decoration: none; font-size: 15px; font-weight: 600;
            transition: all 0.3s ease; padding: 10px 20px; border-radius: 8px;
        }
        .back-link-animated:hover { color: var(--fst-navy); background: #eff6ff; transform: translateX(-5px); }
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
        <a href="logout" class="btn-logout"><i class="fas fa-sign-out-alt"></i> Déconnexion</a>
    </div>
</nav>

<div class="container">
    <div class="header-actions">
        <h2><i class="fas fa-user-graduate" style="color: var(--fst-navy);"></i> Liste des Étudiants</h2>
        <a href="ajouterEleve" class="btn-add"><i class="fas fa-plus-circle"></i> Nouveau</a>
    </div>

    <div class="filter-card">
        <div class="search-input">
            <i class="fas fa-search"></i>
            <input type="text" id="searchInput" onkeyup="filterTable()" placeholder="Rechercher par nom ou matricule...">
        </div>
        <div class="filter-select">
            <select id="classeFilter" onchange="filterTable()">
                <option value="">Toutes les classes</option>
                <% if(classes != null) { for(Classe c : classes) { %>
                <option value="<%= c.getNom() %>"><%= c.getNom() %></option>
                <% } } %>
            </select>
        </div>
    </div>

    <div class="table-container">
        <table id="elevesTable">
            <thead>
            <tr>
                <th>Matricule</th>
                <th>Nom & Prénom</th>
                <th>Classe</th>
                <th style="text-align: right;">Actions</th>
            </tr>
            </thead>
            <tbody>
            <% if (eleves != null && !eleves.isEmpty()) {
                for (Eleve e : eleves) { %>
            <tr>
                <td><strong><%= e.getMatricule() %></strong></td>
                <td><%= e.getNom().toUpperCase() %> <%= e.getPrenom() %></td>
                <td><span style="color:var(--fst-navy); font-weight:600;"><%= (e.getClasse() != null) ? e.getClasse().getNom() : "N/A" %></span></td>
                <td style="text-align: right;">
                    <a href="releveNotes?id=<%= e.getId() %>" class="btn-action btn-releve" title="Consulter">
                        <i class="fas fa-eye"></i>
                    </a>

                    <a href="releveNotes?id=<%= e.getId() %>&download=true" target="_blank" class="btn-action btn-pdf-direct" title="Télécharger PDF">
                        <i class="fas fa-file-pdf"></i>
                    </a>

                    <a href="modifierEleve?id=<%= e.getId() %>" class="btn-action btn-edit" title="Modifier">
                        <i class="fas fa-edit"></i>
                    </a>
                    <a href="supprimerEleve?id=<%= e.getId() %>" class="btn-action btn-delete" title="Supprimer" onclick="return confirm('Supprimer cet étudiant ?')">
                        <i class="fas fa-trash-alt"></i>
                    </a>
                </td>
            </tr>
            <% } } else { %>
            <tr><td colspan="4" style="text-align:center; padding:40px; color: #94a3b8;">
                <i class="fas fa-folder-open" style="font-size: 30px; display: block; margin-bottom: 10px;"></i>
                Aucun étudiant trouvé dans la base de données.
            </td></tr>
            <% } %>
            </tbody>
        </table>
    </div>

    <div class="back-nav-container">
        <a href="dashboard.jsp" class="back-link-animated">
            <i class="fas fa-arrow-left"></i> <span>Retour au Tableau de Bord</span>
        </a>
    </div>
</div>

<script>
    function filterTable() {
        let input = document.getElementById("searchInput").value.toUpperCase();
        let select = document.getElementById("classeFilter").value.toUpperCase();
        let table = document.getElementById("elevesTable");
        let tr = table.getElementsByTagName("tr");

        for (let i = 1; i < tr.length; i++) {
            let tdMatricule = tr[i].getElementsByTagName("td")[0];
            let tdName = tr[i].getElementsByTagName("td")[1];
            let tdClasse = tr[i].getElementsByTagName("td")[2];

            if (tdName && tdClasse) {
                let txtValueName = tdName.textContent || tdName.innerText;
                let txtValueMatricule = tdMatricule.textContent || tdMatricule.innerText;
                let txtValueClasse = tdClasse.textContent || tdClasse.innerText;

                let matchSearch = (txtValueName.toUpperCase().indexOf(input) > -1) ||
                    (txtValueMatricule.toUpperCase().indexOf(input) > -1);
                let matchFilter = (select === "" || txtValueClasse.toUpperCase() === select);

                tr[i].style.display = (matchSearch && matchFilter) ? "" : "none";
            }
        }
    }
</script>
</body>
</html>