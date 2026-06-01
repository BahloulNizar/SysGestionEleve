<%@ page import="Metier.Matiere" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  Matiere m = (Matiere) request.getAttribute("matiere");
%>
<html>
<head>
  <title>Modifier Matière | FST</title>
  <style>
    body { font-family: 'Inter', sans-serif; background: #f8fafc; display: flex; justify-content: center; align-items: center; height: 100vh; margin: 0; }
    .card { background: white; padding: 30px; border-radius: 12px; box-shadow: 0 10px 25px rgba(0,0,0,0.1); width: 400px; border: 1px solid #e2e8f0; }
    h2 { color: #1e3a8a; margin-top: 0; }
    input { width: 100%; padding: 12px; margin: 10px 0; border: 2px solid #f1f5f9; border-radius: 8px; box-sizing: border-box; }
    .btn { background: #1e3a8a; color: white; border: none; width: 100%; padding: 12px; border-radius: 8px; cursor: pointer; font-weight: 600; }
  </style>
</head>
<body>
<div class="card">
  <h2>Modifier Matière</h2>
  <form action="modifierMatiere" method="post">
    <input type="hidden" name="id" value="<%= m.getId() %>">
    <label>Libellé</label>
    <input type="text" name="nom" value="<%= m.getLibelle() %>" required>
    <label>Coefficient</label>
    <input type="number" step="0.5" name="coefficient" value="<%= m.getCoefficient() %>" required>
    <button type="submit" class="btn">Enregistrer</button>
  </form>
</div>
</body>
</html>