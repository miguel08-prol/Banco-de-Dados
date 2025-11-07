<?php 
// Lógica PHP primeiro para buscar os dados
$conn = new mysqli("localhost", "root", "senaisp", "livraria");
$cliente_encontrado = false;
$row = [];

if ($conn->connect_error) {
    die("Conexão falhou: " . $conn->connect_error);
}

if (!isset($_GET['id_cliente'])) {
    $erro = "ID do cliente não fornecido.";
} else {
    $id = (int)$_GET['id_cliente'];
    $result = $conn->query("SELECT id_cliente, nome_cliente, CPF, email FROM Cliente WHERE id_cliente = $id");

    if ($result->num_rows === 0) {
        $erro = "Cliente não encontrado.";
    } else {
        $cliente_encontrado = true;
        $row = $result->fetch_assoc();
    }
}
$conn->close();
?>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Editar Cliente</title>
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
            
            <section class="form-section">
                <h2>Editar Cliente</h2>
                
                <?php if ($cliente_encontrado): ?>
                <form action="atualizar.php" method="POST">
                    <input type="hidden" name="id_cliente" value="<?php echo $row['id_cliente']; ?>">
                    
                    <div class="form-group">
                        <label for="nome">Nome:</label>
                        <input type="text" id="nome" name="nome_cliente" value="<?php echo $row['nome_cliente']; ?>" required>
                    </div>

                    <div class="form-group">
                        <label for="cpf">CPF:</label>
                        <input type="text" id="cpf" name="cpf" value="<?php echo $row['CPF']; ?>" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="email">Email:</label>
                        <input type="email" id="email" name="email" value="<?php echo $row['email']; ?>" required>
                    </div>
                    
                    <button type="submit">Atualizar Cliente</button>
                </form>
                <?php else: ?>
                <div class="message-box error">
                    <h2>Erro</h2>
                    <p><?php echo $erro; ?></p>
                    <br>
                    <a href='lista.php' class='btn'>Voltar para Lista</a>
                </div>
                <?php endif; ?>
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