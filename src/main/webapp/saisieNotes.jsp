<%@ page import="java.util.List" %>
<%@ page import="Metier.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  Administrateur admin = (Administrateur) session.getAttribute("adminSession");
  if (admin == null) {
    response.sendRedirect("login.jsp");
    return;
  }

  List<Eleve> eleves = (List<Eleve>) request.getAttribute("eleves");
  List<Matiere> matieres = (List<Matiere>) request.getAttribute("matieres");
  List<Note> notes = (List<Note>) request.getAttribute("notes");
%>
<html>
<head>
  <title>Saisie des Notes | FST</title>
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

    .container { max-width: 1100px; margin: 40px auto; padding: 0 20px; }
    .header { margin-bottom: 30px; border-left: 5px solid var(--fst-orange); padding-left: 15px; }

    .card { background: white; padding: 30px; border-radius: 12px; box-shadow: 0 4px 15px rgba(0,0,0,0.05); border: 1px solid #e2e8f0; margin-bottom: 30px; }
    .form-grid { display: grid; grid-template-columns: 1fr 1fr 120px auto; gap: 20px; align-items: flex-end; }

    label { display: block; font-size: 13px; font-weight: 600; margin-bottom: 8px; color: #64748b; }
    select, input { width: 100%; padding: 12px; border: 2px solid #f1f5f9; border-radius: 8px; outline: none; transition: 0.3s; font-size: 14px; }
    select:focus, input:focus { border-color: var(--fst-navy); }

    .btn-submit { background: var(--fst-navy); color: white; border: none; padding: 12px 30px; border-radius: 8px; cursor: pointer; font-weight: 600; transition: 0.3s; height: 48px; }
    .btn-submit:hover { background: #111827; transform: translateY(-2px); }

    .table-container { background: white; border-radius: 12px; box-shadow: 0 4px 15px rgba(0,0,0,0.05); overflow: hidden; border: 1px solid #e2e8f0; }
    table { width: 100%; border-collapse: collapse; }
    th { background: #f8fafc; padding: 15px; text-align: left; font-size: 12px; text-transform: uppercase; color: #64748b; border-bottom: 2px solid #f1f5f9; }
    td { padding: 15px; border-bottom: 1px solid #f1f5f9; font-size: 14px; }

    .badge-note { background: #eff6ff; color: var(--fst-navy); padding: 5px 12px; border-radius: 6px; font-weight: 700; border: 1px solid #dbeafe; }
    .date-text { color: #94a3b8; font-size: 12px; }

    .back-nav-container { text-align: center; margin-top: 40px; }
    .back-link { color: #64748b; text-decoration: none; font-weight: 600; display: inline-flex; align-items: center; gap: 8px; }
    .back-link:hover { color: var(--fst-navy); }
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
  <div class="header">
    <h2 style="margin:0;">Saisie des Notes</h2>
    <p style="margin:5px 0 0; color:#64748b;">Gérez les évaluations des étudiants par matière.</p>
  </div>

  <div class="card">
    <form action="notes" method="post" class="form-grid">
      <div>
        <label><i class="fas fa-user-graduate"></i> Étudiant</label>
        <select name="eleveId" required>
          <option value="">Sélectionner un élève</option>
          <% if(eleves != null) { for(Eleve e : eleves) { %>
          <option value="<%= e.getId() %>"><%= e.getNom().toUpperCase() %> <%= e.getPrenom() %></option>
          <% } } %>
        </select>
      </div>

      <div>
        <label><i class="fas fa-book"></i> Matière</label>
        <select name="matiereId" required>
          <option value="">Sélectionner la matière</option>
          <% if(matieres != null) { for(Matiere m : matieres) { %>
          <option value="<%= m.getId() %>"><%= m.getLibelle() %></option>
          <% } } %>
        </select>
      </div>

      <div>
        <label><i class="fas fa-pen"></i> Note</label>
        <input type="number" name="valeur" step="0.25" min="0" max="20" placeholder="00.00" required>
      </div>

      <button type="submit" class="btn-submit"><i class="fas fa-plus"></i> Enregistrer</button>
    </form>
  </div>

  <div class="table-container">
    <table>
      <thead>
      <tr>
        <th>Étudiant</th>
        <th>Matière</th>
        <th>Note</th>
        <th>Date</th>
        <th style="text-align:right;">Actions</th>
      </tr>
      </thead>
      <tbody>
      <% if(notes != null && !notes.isEmpty()) {
        for(Note n : notes) { %>
      <tr>
        <td><strong><%= n.getEleve().getNom() %> <%= n.getEleve().getPrenom() %></strong></td>
        <td><%= n.getMatiere().getLibelle() %></td>
        <td><span class="badge-note"><%= n.getValeur() %> / 20</span></td>
        <td class="date-text"><%= n.getDateSaisie() %></td>
        <td style="text-align:right;">
          <a href="supprimerNote?id=<%= n.getId() %>"
             onclick="return confirm('Supprimer cette note ?')"
             style="color: #ef4444; font-size: 18px; text-decoration: none;">
            <i class="fas fa-trash-alt"></i>
          </a>
        </td>
      </tr>
      <% } } else { %>
      <tr>
        <td colspan="5" style="text-align:center; padding:40px; color:#94a3b8;">Aucune note trouvée.</td>
      </tr>
      <% } %>
      </tbody>
    </table>
  </div>

  <div class="back-nav-container">
    <a href="dashboard.jsp" class="back-link">
      <i class="fas fa-arrow-left"></i> Retour au Tableau de Bord
    </a>
  </div>
</div>

</body>
</html>