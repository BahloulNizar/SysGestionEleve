<%@ page import="java.util.List" %>
<%@ page import="Metier.Filiere" %>
<%@ page import="Metier.Administrateur" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  Administrateur admin = (Administrateur) session.getAttribute("adminSession");
  if (admin == null) {
    response.sendRedirect("login.jsp");
    return;
  }
  List<Filiere> filieres = (List<Filiere>) request.getAttribute("filieres");
%>
<html>
<head>
  <title>Gestion des Filières | FST</title>
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;700&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
  <style>
    :root { --fst-navy: #1e3a8a; --fst-orange: #ea580c; --fst-bg: #f8fafc; }
    body { font-family: 'Inter', sans-serif; background: var(--fst-bg); margin: 0; color: #1e293b; }

    .navbar {
      background: var(--fst-navy); padding: 0 40px; height: 70px;
      display: flex; align-items: center; justify-content: space-between;
      color: white; border-bottom: 5px solid var(--fst-orange);
    }

    .btn-logout {
      background: rgba(255, 255, 255, 0.1); color: white; text-decoration: none;
      padding: 8px 18px; border-radius: 6px; font-size: 14px; border: 1px solid rgba(255, 255, 255, 0.3);
      display: flex; align-items: center; gap: 8px; transition: 0.3s;
    }
    .btn-logout:hover { background: var(--fst-orange); border-color: var(--fst-orange); }

    .container { padding: 40px; max-width: 1000px; margin: 0 auto; }

    .add-card {
      background: white; padding: 25px; border-radius: 12px;
      box-shadow: 0 4px 15px rgba(0,0,0,0.05); border: 1px solid #e2e8f0; margin-bottom: 30px;
    }

    .inline-form { display: flex; gap: 15px; }
    .input-group { flex-grow: 1; position: relative; }
    .input-group i { position: absolute; left: 15px; top: 50%; transform: translateY(-50%); color: #94a3b8; }
    .input-group input {
      width: 100%; padding: 12px 15px 12px 45px; border: 2px solid #f1f5f9;
      border-radius: 10px; outline: none; background: #f8fafc; transition: 0.3s;
    }
    .input-group input:focus { border-color: var(--fst-navy); background: white; }

    .btn-submit {
      background: var(--fst-orange); color: white; border: none;
      padding: 12px 25px; border-radius: 10px; font-weight: 700; cursor: pointer; transition: 0.3s;
    }
    .btn-submit:hover { background: #c2410c; transform: translateY(-2px); }

    .table-container { background: white; border-radius: 12px; overflow: hidden; border: 1px solid #e2e8f0; box-shadow: 0 4px 15px rgba(0,0,0,0.05); }
    table { width: 100%; border-collapse: collapse; }
    th { background: #f1f5f9; padding: 15px 20px; text-align: left; font-size: 12px; color: #64748b; text-transform: uppercase; }
    td { padding: 15px 20px; border-bottom: 1px solid #f1f5f9; font-size: 14px; }
    tr:hover { background: #f8fafc; }

    .btn-delete { color: #ef4444; text-decoration: none; font-weight: 600; transition: 0.3s; }
    .btn-delete:hover { color: #b91c1c; }

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
  <div style="font-weight: 700; font-size: 20px; display: flex; align-items: center; gap: 10px;">
    <i class="fas fa-university" style="color: var(--fst-orange); font-size: 26px;"></i>
    FST | Configuration
  </div>
  <div style="display: flex; align-items: center; gap: 20px;">
    <span><i class="fas fa-user-circle"></i> <%= admin.getNom() %></span>
    <a href="logout" class="btn-logout"><i class="fas fa-sign-out-alt"></i> Déconnexion</a>
  </div>
</nav>

<div class="container">
  <h2 style="display: flex; align-items: center; gap: 15px;">
    <i class="fas fa-scroll" style="color: var(--fst-navy);"></i>
    Gestion des Filières
  </h2>

  <div class="add-card">
    <form action="ajouterFiliere" method="POST" class="inline-form">
      <div class="input-group">
        <i class="fas fa-tag"></i>
        <input type="text" name="code" placeholder="Code (ex: DD, GE...)" required>
      </div>
      <div class="input-group">
        <i class="fas fa-graduation-cap"></i>
        <input type="text" name="nom" placeholder="Nom de la Filière" required>
      </div>
      <button type="submit" class="btn-submit">Ajouter</button>
    </form>
  </div>

  <div class="table-container">
    <table>
      <thead>
      <tr>
        <th>CODE</th>
        <th>NOM DE LA FILIÈRE</th>
        <th style="text-align: right;">ACTIONS</th>
      </tr>
      </thead>
      <tbody>
      <% if(filieres != null && !filieres.isEmpty()) { for(Filiere f : filieres) { %>
      <tr>
        <td><strong style="color: var(--fst-navy);"><%= f.getCode() %></strong></td>
        <td><%= f.getNom() %></td>
        <td style="text-align: right;">
          <a href="supprimerFiliere?id=<%= f.getId() %>" class="btn-delete" onclick="return confirm('Supprimer cette filière ?')">
            <i class="fas fa-trash-alt"></i> Supprimer
          </a>
        </td>
      </tr>
      <% } } else { %>
      <tr>
        <td colspan="3" style="text-align: center; padding: 40px; color: #94a3b8;">
          Aucune filière trouvée.
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