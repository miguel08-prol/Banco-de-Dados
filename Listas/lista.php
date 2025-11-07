<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lista de Clientes</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <header>
        <div class="container">
            <h1>Sistema de Livraria</h1>
        </div>
    </header>
    <nav>
        <div class="container">
            <a href="index.html">Página Inicial</a>
            <a href="lista.php">Lista de Clientes</a>
        </div>
    </nav>
    
    <div class="container">
        <div class="main-content">
            <section class="list-section">
                <h2>Clientes Cadastrados</h2>
                
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Nome</th>
                            <th>CPF</th>
                            <th>Email</th>
                            <th>Ações</th>
                        </tr>
                    </thead>
                    <tbody>
<?php 
$conn = new mysqli("localhost", "root", "senaisp", "livraria");

if ($conn->connect_error) {
    die("<tr><td colspan='5'>Conexão falhou: " . $conn->connect_error . "</td></tr>");
}

$result = $conn->query("SELECT id_cliente, nome_cliente, CPF, email FROM Cliente");

if ($result->num_rows > 0) {
    while($row = $result->fetch_assoc()) {
        echo "<tr>
            <td>{$row['id_cliente']}</td>
            <td>{$row['nome_cliente']}</td>
            <td>{$row['CPF']}</td>
            <td>{$row['email']}</td>
            
            <td class='actions-cell'>
                <a href='editar.php?id_cliente={$row['id_cliente']}' class='btn-edit'>Editar</a>
                
                <a href='deletar.php?id_cliente={$row['id_cliente']}' 
                   class='btn-delete' 
                   onclick='return confirm(\"Tem certeza que deseja excluir este cliente?\");'>
                   Deletar
                </a>
            </td>
            </tr>";
    }
} else {
    echo "<tr><td colspan='5'>Nenhum cliente cadastrado.</td></tr>";
}
$conn->close();
?>
                    </tbody>
                </table>
                <a href="index.html" class="btn">Cadastrar Novo Cliente</a>
            </section>
        </div>
    </div>
    
    <footer>
        <div class="container">
            <p>&copy; 2025 Sistema de Livraria. Todos os direitos reservados.</p>
        </div>
    </footer>
</body>
</html>