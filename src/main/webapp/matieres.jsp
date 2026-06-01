<%@ page import="java.util.List" %>
<%@ page import="Metier.Matiere" %>
<%@ page import="Metier.Administrateur" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  Administrateur admin = (Administrateur) session.getAttribute("adminSession");
  if (admin == null) { response.sendRedirect("login.jsp"); return; }

  List<Matiere> matieres = (List<Matiere>) request.getAttribute("matieres");
%>
<html>
<head>
  <meta charset="UTF-8">
  <title>Configuration des Matières | FST</title>
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

    .container { max-width: 1000px; margin: 40px auto; padding: 0 20px; }

    .form-card {
      background: white; padding: 25px; border-radius: 12px;
      box-shadow: 0 4px 15px rgba(0,0,0,0.05); border: 1px solid #e2e8f0;
      margin-bottom: 30px;
    }
    .form-group { display: flex; gap: 15px; align-items: flex-end; }
    .input-box { flex: 1; }
    .input-box label { display: block; font-size: 13px; font-weight: 600; margin-bottom: 8px; color: #64748b; }
    .input-box input {
      width: 100%; padding: 12px; border: 2px solid #f1f5f9;
      border-radius: 8px; outline: none; transition: 0.3s; box-sizing: border-box;
    }
    .input-box input:focus { border-color: var(--fst-navy); }

    .btn-save {
      background: var(--fst-navy); color: white; border: none;
      padding: 12px 25px; border-radius: 8px; cursor: pointer;
      font-weight: 600; transition: 0.3s; height: 48px; display: flex; align-items: center; gap: 8px;
    }
    .btn-save:hover { background: #111827; transform: translateY(-2px); }

    .table-container { background: white; border-radius: 12px; box-shadow: 0 4px 15px rgba(0,0,0,0.05); overflow: hidden; border: 1px solid #e2e8f0; }
    table { width: 100%; border-collapse: collapse; }
    th { background: #f1f5f9; padding: 15px; text-align: left; font-size: 12px; text-transform: uppercase; color: #64748b; }
    td { padding: 15px; border-bottom: 1px solid #f1f5f9; font-size: 14px; }

    .badge-coeff { background: #eff6ff; color: var(--fst-navy); padding: 4px 10px; border-radius: 6px; font-weight: 700; }

    .btn-edit-matiere {
      color: #64748b; padding: 8px; border-radius: 6px; transition: 0.3s; text-decoration: none; display: inline-flex; align-items: center;
    }
    .btn-edit-matiere:hover { color: var(--fst-navy); background: #f1f5f9; }

    .btn-delete-matiere {
      color: #ef4444; padding: 8px; border-radius: 6px; transition: 0.3s; text-decoration: none; display: inline-flex; align-items: center; margin-left: 8px;
    }
    .btn-delete-matiere:hover { color: #b91c1c; background: #fee2e2; }

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
  <div class="header-actions" style="margin-bottom: 20px;">
    <h2><i class="fas fa-layer-group" style="color: var(--fst-orange);"></i> Configuration des Matières</h2>
  </div>

  <div class="form-card">
    <form action="matieres" method="post" class="form-group">
      <div class="input-box">
        <label>Nom de la Matière</label>
        <input type="text" name="nom" placeholder="Ex: Mathématiques" required>
      </div>
      <div class="input-box" style="flex: 0.3;">
        <label>Coefficient</label>
        <input type="number" step="0.5" name="coefficient" placeholder="Ex: 2" required>
      </div>
      <button type="submit" class="btn-save">
        <i class="fas fa-plus"></i> Ajouter
      </button>
    </form>
  </div>

  <div class="table-container">
    <table>
      <thead>
      <tr>
        <th>ID</th>
        <th>Libellé de la Matière</th>
        <th>Coefficient</th>
        <th style="text-align: right;">Actions</th>
      </tr>
      </thead>
      <tbody>
      <% if (matieres != null && !matieres.isEmpty()) {
        for (Matiere m : matieres) { %>
      <tr>
        <td>#<%= m.getId() %></td>
        <td><strong><%= m.getLibelle() %></strong></td>
        <td><span class="badge-coeff"><%= m.getCoefficient() %></span></td>
        <td style="text-align: right;">
          <a href="modifierMatiere?id=<%= m.getId() %>" class="btn-edit-matiere" title="Modifier">
            <i class="fas fa-edit"></i>
          </a>

          <a href="supprimerMatiere?id=<%= m.getId() %>" class="btn-delete-matiere" title="Supprimer"
             onclick="return confirm('Voulez-vous vraiment supprimer la matière [<%= m.getLibelle().replace("'", "\\'") %>] ?');">
            <i class="fas fa-trash-alt"></i>
          </a>
        </td>
      </tr>
      <% } } else { %>
      <tr>
        <td colspan="4" style="text-align: center; padding: 30px; color: #94a3b8;">
          <i class="fas fa-folder-open" style="font-size: 24px; display: block; margin-bottom: 10px;"></i>
          Aucune matière configurée.
        </td>
      </tr>
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

</body>
</html>