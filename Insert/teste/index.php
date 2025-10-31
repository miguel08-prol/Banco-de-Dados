<?php
// --- CONFIGURAÇÕES DO BANCO DE DADOS ---
$db_host = 'localhost';
$db_user = 'root';
$db_pass = 'senaisp';
$db_name = 'Livraria';

// --- INICIALIZAÇÃO DE VARIÁVEIS ---
$search_results = []; // Array para guardar os resultados da busca
$show_results = false;  // Flag para saber se devemos mostrar a seção de resultados
$termo_buscado = '';    // O que o usuário digitou na busca

// --- LÓGICA DE INSERÇÃO (QUANDO O FORMULÁRIO DE CADASTRO É ENVIADO) ---
if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['nome_cliente'])) {
    
    // 1. Obter dados do POST
    $nome_cliente = $_POST['nome_cliente'];
    $email = $_POST['email'];
    $cpf = $_POST['cpf_cliente'];

    // 2. Conectar e Inserir
    $conn = new mysqli($db_host, $db_user, $db_pass, $db_name);
    if ($conn->connect_error) {
        die("Falha na conexao (INSERT): " . $conn->connect_error);
    }

    // 3. Preparar e Executar
    $stmt = $conn->prepare("INSERT INTO Cliente (nome_cliente, email, CPF) VALUES (?, ?, ?)");
    $stmt->bind_param("sss", $nome_cliente, $email, $cpf);
    
    if ($stmt->execute()) {
        // Sucesso! Redireciona para a própria página para "limpar" o POST
        // Adicionamos um ?status=success para mostrar uma mensagem
        header("Location: index.php?status=success");
        exit;
    } else {
        echo "Erro ao inserir registro: " . $stmt->error;
    }
    
    $stmt->close();
    $conn->close();
}

// --- LÓGICA DE BUSCA (QUANDO O FORMULÁRIO DE BUSCA É ENVIADO) ---
if ($_SERVER['REQUEST_METHOD'] == 'GET' && isset($_GET['nome_busca'])) {
    
    $show_results = true; // Ativa a exibição dos resultados no HTML
    $termo_buscado = $_GET['nome_busca'];

    // 1. Conectar e Buscar
    $conn = new mysqli($db_host, $db_user, $db_pass, $db_name);
    if ($conn->connect_error) {
        die("Falha na conexao (SELECT): " . $conn->connect_error);
    }

    // 2. Preparar a consulta (LIKE)
    $termo_like = "%" . $termo_buscado . "%";
    $stmt = $conn->prepare("SELECT nome_cliente, email, CPF FROM Cliente WHERE nome_cliente LIKE ?");
    $stmt->bind_param("s", $termo_like);
    
    // 3. Executar e Salvar resultados no array
    $stmt->execute();
    $result = $stmt->get_result();
    
    if ($result->num_rows > 0) {
        while ($row = $result->fetch_assoc()) {
            $search_results[] = $row; // Adiciona a linha ao array de resultados
        }
    }
    
    $stmt->close();
    $conn->close();
}

// --- FIM DA LÓGICA PHP. DAQUI PARA BAIXO É SÓ O HTML ---
?>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Teste BD Completo</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; line-height: 1.6; }
        form { border: 1px solid #ccc; padding: 15px; margin-bottom: 20px; }
        hr { margin: 30px 0; }
        table { width: 100%; border-collapse: collapse; margin-top: 10px; }
        th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }
        th { background-color: #f2f2f2; }
    </style>
</head>
<body>

    <?php if (isset($_GET['status']) && $_GET['status'] == 'success'): ?>
        <p style="color: green; font-weight: bold;">Cliente cadastrado com sucesso!</p>
    <?php endif; ?>


    <h2>Cadastrar Novo Cliente</h2>
    <form action="index.php" method="POST">
        <label>Nome:</label>
        <input type="text" name="nome_cliente" required><br><br>

        <label>CPF:</label>
        <input type="text" name="cpf_cliente" required><br><br>

        <label>Email:</label>
        <input type="email" name="email" required><br><br>

        <button type="submit">Enviar Cadastro</button>
    </form>

    <hr>

    <h2>Buscar Cliente por Nome</h2>
    <form action="index.php" method="GET">
        <label>Nome:</label>
        <input type="text" name="nome_busca" value="<?php echo htmlspecialchars($termo_buscado); ?>" required>
        <button type="submit">Buscar</button>
    </form>

    <?php if ($show_results): ?>
        <h2>Resultados para "<?php echo htmlspecialchars($termo_buscado); ?>"</h2>

        <?php if (count($search_results) > 0): ?>
            <table>
                <tr>
                    <th>Nome</th>
                    <th>Email</th>
                    <th>CPF</th>
                </tr>
                <?php foreach ($search_results as $cliente): ?>
                    <tr>
                        <td><?php echo htmlspecialchars($cliente['nome_cliente']); ?></td>
                        <td><?php echo htmlspecialchars($cliente['email']); ?></td>
                        <td><?php echo htmlspecialchars($cliente['CPF']); ?></td>
                    </tr>
                <?php endforeach; ?>
            </table>
        <?php else: ?>
            <p>Nenhum cliente encontrado com esse nome.</p>
        <?php endif; ?>

    <?php endif; ?>

</body>
</html>