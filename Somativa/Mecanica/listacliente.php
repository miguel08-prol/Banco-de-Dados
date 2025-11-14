<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lista de Clientes</title>
    <link rel="icon" href="icon/logo-sem-fundo.png">
    <link rel="stylesheet" href="mecanica.css"> 
</head>
<body>
    <header>
        <div class="container">
            <h1>Auto Tech Solutions</h1>
        </div>
    </header>
    <nav>
        <div class="container">
            <a href="index.html">Página Inicial</a>
            <a href="listacliente.php">Lista de Clientes</a>
        </div>
    </nav>
    
    <div class="container">
        <div class="main-content">
            <section class="list-section" style="width: 100%; overflow-x: auto;">
                <h2>Clientes Cadastrados</h2>
                
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Nome</th>
                            <th>CPF</th>
                            <th>Telefone</th>
                            <th>Veiculo(marca)</th>
                            <th>Serviço</th>
                            <th>Produto</th>
                            <th>Observacão</th>
                            <th>Ações</th>
                        </tr>
                    </thead>
                    <tbody>
<?php 
$conn = new mysqli("localhost", "root", "senaisp", "Mecanica");

if ($conn->connect_error) {
    die("<tr><td colspan='9'>Conexão falhou: " . $conn->connect_error . "</td></tr>");
}

// Este SQL só funciona se você SIMPLIFICAR a tabela
$sql = "SELECT id_cadastro, nome_cliente, CPF, telefone, marca_veiculo, servico, nome_produto, Observacao FROM Funcionario_Cadastrar";
$result = $conn->query($sql);

if ($result->num_rows > 0) {
    while($row = $result->fetch_assoc()) {
        echo "<tr>
            
            <td>{$row['id_cadastro']}</td>
            <td>{$row['nome_cliente']}</td>
            <td>{$row['CPF']}</td>
            <td>{$row['telefone']}</td>
            <td>{$row['marca_veiculo']}</td>
            <td>{$row['servico']}</td>
            <td>{$row['nome_produto']}</td>
            <td>{$row['Observacao']}</td>
            
            <td class='actions-cell'>
                <a href='editar.php?id={$row['id_cadastro']}' class='btn-edit' style='background: #28a745; padding: 5px; color: white; text-decoration: none; border-radius: 4px;'>Editar</a>
                
                <a href='deletar.php?id={$row['id_cadastro']}' 
                   class='btn-delete' style='background: #dc3545; padding: 5px; color: white; text-decoration: none; border-radius: 4px;'
                   onclick='return confirm(\"Tem certeza que deseja excluir este cliente?\");'>
                   Deletar
                </a>
            </td>
            </tr>";
    }
} else {
    echo "<tr><td colspan='9'>Nenhum cliente cadastrado.</td></tr>";
}
$conn->close();
?>
                    </tbody>
                </table>
                <br>
                <a href="index.html" class="btn" style="background: var(--primary-color); color: white; padding: 10px 15px; text-decoration: none; border-radius: 5px;">Cadastrar Novo Cliente</a>
            </section>
        </div>
    </div>
    
    <footer>
        <div class="container">
            <p>&copy; 2025 Auto Tech Solutions. Todos os direitos reservados.</p>
        </div>
    </footer>
</body>
</html>