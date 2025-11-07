<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Status da Atualização</title>
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
$conn = new mysqli("localhost", "root", "senaisp", "livraria");

if ($conn->connect_error) {
    die("Conexão falhou: " . $conn->connect_error);
}

if (!isset($_POST['id_cliente'], $_POST['nome_cliente'], $_POST['cpf'], $_POST['email'])) {
    echo "<div class='message-box error'>
            <h2>Erro</h2>
            <p>Dados do formulário não foram enviados corretamente.</p>
            <br>
            <a href='lista.php' class='btn'>Voltar para Lista</a>
          </div>";
} else {
    $id = (int)$_POST['id_cliente'];
    $nome = $conn->real_escape_string($_POST['nome_cliente']);
    $cpf = $conn->real_escape_string($_POST['cpf']);
    $email = $conn->real_escape_string($_POST['email']);

    $sql = "UPDATE Cliente SET 
                nome_cliente = '$nome', 
                CPF = '$cpf', 
                email = '$email' 
            WHERE id_cliente = $id";

    if ($conn->query($sql) === TRUE) {
        echo "<div class='message-box success'>
                <h2>Sucesso!</h2>
                <p>Registro atualizado com sucesso!</p>
                <br>
                <a href='lista.php' class='btn'>Voltar para Lista</a>
              </div>";
    } else {
        echo "<div class='message-box error'>
                <h2>Erro na Atualização</h2>
                <p>Ocorreu um erro: " . $conn->error . "</p>
                <br>
                <a href='editar.php?id_cliente={$id}' class='btn'>Tentar Novamente</a>
              </div>";
    }
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