<?php
// 1. Definir o cabeçalho como JSON
header('Content-Type: application/json');

// 2. Criar um array para a resposta
$response = array(
    'status' => 'error', // 'error' por defeito
    'message' => 'Ocorreu um erro desconhecido.'
);

// 3. Conexão (como já tinhas)
$conn = new mysqli("localhost", "root", "senaisp", "Mecanica");

if ($conn->connect_error) {
    $response['message'] = "Conexão falhou: " . $conn->connect_error;
    echo json_encode($response);
    exit; // Termina o script
}

// 4. Validação dos campos
if (!isset($_POST['nome_cliente'], $_POST['CPF'], $_POST['telefone'], $_POST['marca_veiculo'], $_POST['servico'], $_POST['nome_produto'])) {
    $response['message'] = "Todos os campos obrigatórios devem ser preenchidos.";
    echo json_encode($response);
    exit;
}

// 5. Preparar dados (como já tinhas)
$nome = $conn->real_escape_string($_POST['nome_cliente']);
$CPF = $conn->real_escape_string($_POST['CPF']);
$telefone = $conn->real_escape_string($_POST['telefone']);
$marca_veiculo = $conn->real_escape_string($_POST['marca_veiculo']);
$servico = $conn->real_escape_string($_POST['servico']);
$nome_produto = $conn->real_escape_string($_POST['nome_produto']);
$observacao = $conn->real_escape_string($_POST['observacao']); // Este pode ser opcional

// 6. SQL (ASSUMINDO QUE JÁ CORRIGISTE O TEU BANCO DE DADOS COMO FALÁMOS ANTES)
$sql = "INSERT INTO Funcionario_Cadastrar (nome_cliente, CPF, telefone, marca_veiculo, servico, nome_produto, observacao) 
        VALUES ('$nome', '$CPF', '$telefone', '$marca_veiculo', '$servico', '$nome_produto', '$observacao')";

// 7. Executar e definir a resposta JSON
if ($conn->query($sql) === TRUE) {
    $response['status'] = 'success';
    $response['message'] = 'Cliente cadastrado com sucesso!';
} else {
    // Se der erro de SQL, informa o erro
    $response['message'] = "Erro ao cadastrar: " . $conn->error;
}

// 8. Fechar conexão e enviar a resposta
$conn->close();
echo json_encode($response);
exit;
?>