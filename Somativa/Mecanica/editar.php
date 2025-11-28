<?php
$conn = new mysqli("localhost", "root", "senaisp", "Mecanica");

if ($conn->connect_error) {
    die("Conexão falhou: " . $conn->connect_error);
}

if (!isset($_GET['id']) || empty($_GET['id'])) {
    header("Location: listacliente.php?error=ID do cliente não especificado.");
    exit;
}

$id = $conn->real_escape_string($_GET['id']);

$sql = "SELECT * FROM Funcionario_Cadastrar WHERE id_cadastro = '$id'";
$result = $conn->query($sql);

if ($result->num_rows === 0) {
    header("Location: listacliente.php?error=Cliente não encontrado.");
    exit;
}

$cliente = $result->fetch_assoc();

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $nome = trim($conn->real_escape_string($_POST['nome_cliente'] ?? ''));
    $CPF = trim($conn->real_escape_string($_POST['CPF'] ?? ''));
    $telefone = trim($conn->real_escape_string($_POST['telefone'] ?? ''));
    $marca_veiculo = trim($conn->real_escape_string($_POST['marca_veiculo'] ?? ''));
    $servico = trim($conn->real_escape_string($_POST['servico'] ?? ''));
    $nome_produto = trim($conn->real_escape_string($_POST['nome_produto'] ?? ''));
    $observacao = trim($conn->real_escape_string($_POST['observacao'] ?? ''));

    if (empty($nome) || empty($CPF) || empty($telefone) || empty($marca_veiculo) || empty($servico) || empty($nome_produto)) {
        $error = "Todos os campos obrigatórios devem ser preenchidos.";
    } else {
        $update_sql = "UPDATE Funcionario_Cadastrar 
                       SET nome_cliente = '$nome', 
                           CPF = '$CPF', 
                           telefone = '$telefone', 
                           marca_veiculo = '$marca_veiculo', 
                           servico = '$servico', 
                           nome_produto = '$nome_produto', 
                           observacao = '$observacao' 
                       WHERE id_cadastro = '$id'";

        if ($conn->query($update_sql)) {
            header("Location: listacliente.php?success=Cliente atualizado com sucesso!");
            exit;
        } else {
            $error = "Erro ao atualizar: " . $conn->error;
        }
    }
}
?>

<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Editar Cliente - Auto Tech Solutions</title>
    <link rel="stylesheet" href="mecanica.css">
    <link rel="icon" href="icon/logo-sem-fundo.png">
</head>
<body>
    <header>
        <div class="container">
            <img src="icon/logo-fundo.png" alt="Logo Auto Tech Solutions" class="header-logo">
            <h1>Auto Tech Solutions</h1>
        </div>
    </header>
    
    <nav>
        <div class="container">
            <a href="index.html">Página Inicial</a>
            <a href="listacliente.php">Lista de Clientes</a>
        </div>
    </nav>

    <main class="container">
        <div class="main-content">
            <section class="form-section">
                <h2>Editar Cliente</h2>
                
                <?php if (isset($error)): ?>
                    <div class="message-box error">
                        <p><?php echo $error; ?></p>
                    </div>
                <?php endif; ?>

                <form action="editar.php?id=<?php echo $id; ?>" method="POST">
                    <div class="form-row">
                        <div class="form-group">
                            <label for="nome">Nome:</label>
                            <input type="text" id="nome" name="nome_cliente" value="<?php echo htmlspecialchars($cliente['nome_cliente'] ?? ''); ?>" required>
                        </div>

                        <div class="form-group">
                            <label for="cpf">CPF:</label>
                            <input type="text" id="cpf" name="CPF" value="<?php echo htmlspecialchars($cliente['CPF'] ?? ''); ?>" required>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label for="telefone">Telefone:</label>
                            <input type="text" id="telefone" name="telefone" value="<?php echo htmlspecialchars($cliente['telefone'] ?? ''); ?>" required>
                        </div>

                        <div class="form-group">
                            <label for="veiculo">Veículo (marca):</label>
                            <input type="text" id="veiculo" name="marca_veiculo" value="<?php echo htmlspecialchars($cliente['marca_veiculo'] ?? ''); ?>" required>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label for="servico">Serviço:</label>
                            <input type="text" id="servico" name="servico" value="<?php echo htmlspecialchars($cliente['servico'] ?? ''); ?>" required>
                        </div>

                        <div class="form-group">
                            <label for="produto">Produto:</label>
                            <input type="text" id="produto" name="nome_produto" value="<?php echo htmlspecialchars($cliente['nome_produto'] ?? ''); ?>" required>
                        </div>
                    </div>

                    <div class="form-group full-width">
                        <label for="observacao">Observação:</label>
                        <input type="text" id="observacao" name="observacao" value="<?php echo htmlspecialchars($cliente['observacao'] ?? ''); ?>">
                    </div>

                    <div class="form-submit">
                        <button type="submit" class="btn-primary">Atualizar Cliente</button>
                        <a href="listacliente.php" class="btn-secondary">Cancelar</a>
                    </div>
                </form>
            </section>
        </div>
    </main>

    <footer>
        <div class="container">
            <p>&copy; 2025 Auto Tech Solutions. Todos os direitos reservados.</p>
        </div>
    </footer>
</body>
</html>

<?php $conn->close(); ?>