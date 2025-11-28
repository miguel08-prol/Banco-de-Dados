<?php
// Define o tipo de conteúdo como JSON
header('Content-Type: application/json; charset=utf-8');

// Ativa a exibição de erros para debug (remova em produção)
error_reporting(E_ALL);
ini_set('display_errors', 0); // Não mostra erros na tela para não quebrar o JSON
ini_set('log_errors', 1);

$response = array(
    'status' => 'error',
    'message' => 'Ocorreu um erro desconhecido.'
);

try {
    // Conecta ao banco de dados
    $conn = new mysqli("localhost", "root", "senaisp", "Mecanica");

    if ($conn->connect_error) {
        $response['message'] = "Conexão falhou: " . $conn->connect_error;
        echo json_encode($response, JSON_UNESCAPED_UNICODE);
        exit;
    }

    // Define o charset da conexão
    $conn->set_charset("utf8mb4");

    // Verifica se é uma requisição POST
    if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
        $response['message'] = "Método de requisição inválido.";
        echo json_encode($response, JSON_UNESCAPED_UNICODE);
        exit;
    }

    // Lista de campos obrigatórios
    $required_fields = ['nome_cliente', 'CPF', 'telefone', 'marca_veiculo', 'servico', 'nome_produto'];

    // Valida se todos os campos obrigatórios estão presentes
    foreach ($required_fields as $field) {
        if (!isset($_POST[$field]) || empty(trim($_POST[$field]))) {
            $response['message'] = "Todos os campos obrigatórios devem ser preenchidos. Campo faltando: " . $field;
            echo json_encode($response, JSON_UNESCAPED_UNICODE);
            exit;
        }
    }

    // Sanitiza e valida os dados
    $nome = trim($conn->real_escape_string($_POST['nome_cliente']));
    $CPF = trim($conn->real_escape_string($_POST['CPF']));
    $telefone = trim($conn->real_escape_string($_POST['telefone']));
    $marca_veiculo = trim($conn->real_escape_string($_POST['marca_veiculo']));
    $servico = trim($conn->real_escape_string($_POST['servico']));
    $nome_produto = trim($conn->real_escape_string($_POST['nome_produto']));
    $observacao = isset($_POST['observacao']) ? trim($conn->real_escape_string($_POST['observacao'])) : '';

    // Verifica se os campos não estão vazios após sanitização
    if (empty($nome) || empty($CPF) || empty($telefone) || empty($marca_veiculo) || empty($servico) || empty($nome_produto)) {
        $response['message'] = "Todos os campos obrigatórios devem conter informações válidas.";
        echo json_encode($response, JSON_UNESCAPED_UNICODE);
        exit;
    }

    // Prepara a query SQL
    $sql = "INSERT INTO Funcionario_Cadastrar (nome_cliente, CPF, telefone, marca_veiculo, servico, nome_produto, observacao) 
            VALUES ('$nome', '$CPF', '$telefone', '$marca_veiculo', '$servico', '$nome_produto', '$observacao')";

    // Executa a query
    if ($conn->query($sql) === TRUE) {
        $response['status'] = 'success';
        $response['message'] = 'Cliente cadastrado com sucesso!';
        $response['id'] = $conn->insert_id;
    } else {
        $response['message'] = "Erro ao cadastrar: " . $conn->error;
        $response['sql_error'] = $conn->error;
    }

} catch (Exception $e) {
    $response['message'] = "Erro: " . $e->getMessage();
} finally {
    // Fecha a conexão
    if (isset($conn)) {
        $conn->close();
    }
}

// Retorna a resposta em JSON
echo json_encode($response, JSON_UNESCAPED_UNICODE);
exit;
?>