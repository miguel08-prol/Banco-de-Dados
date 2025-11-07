<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Status da Exclusão</title>
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
<?php 
// 1. Conexão com a NOSSA base de dados
$conn = new mysqli("localhost", "root", "senaisp", "livraria");

if ($conn->connect_error) {
    die("Conexão falhou: " . $conn->connect_error);
}

// 2. Verifica se o ID foi passado corretamente
if (!isset($_GET['id_cliente'])) {
    echo "<div class='message-box error'>
            <h2>Erro</h2>
            <p>ID do cliente não fornecido para exclusão.</p>
            <br>
            <a href='lista.php' class='btn'>Voltar para Lista</a>
          </div>";
} else {
    $id = (int)$_GET['id_cliente'];

    // 3. Prepara e executa a exclusão (DELETE)
    // Usando a tabela 'Cliente' e a coluna 'id_cliente'
    $stmt = $conn->prepare("DELETE FROM Cliente WHERE id_cliente = ?");
    $stmt->bind_param("i", $id);

    if ($stmt->execute()) {
        echo "<div class='message-box success'>
                <h2>Sucesso!</h2>
                <p>Cliente excluído com sucesso!</p>
                <br>
                <a href='lista.php' class='btn'>Voltar para Lista</a>
              </div>";
    } else {
        echo "<div class='message-box error'>
                <h2>Erro na Exclusão</h2>
                <p>Ocorreu um erro: " . $stmt->error . "</p>
                <br>
                <a href='lista.php' class='btn'>Tentar Novamente</a>
              </div>";
    }
    $stmt->close();
}
$conn->close();
?>
        </div>
    </div>
    
    <footer>
        <div class="container">
            <p>&copy; 2025 Sistema de Livraria. Todos os direitos reservados.</p>
        </div>
    </footer>
</body>
</html>