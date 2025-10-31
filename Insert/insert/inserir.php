<?php

// 1. Obter os dados do POST

$nome_cliente = $_POST['nome_cliente'];

$email = $_POST['email'];

$cpf = $_POST['cpf_cliente']; // Obtém o CPF do formulário



// 2. Conectar ao banco de dados

$conn = new mysqli('localhost', 'root', 'senaisp', 'Livraria');

 

// 3. Verificar a conexão

if($conn->connect_error){

    // Se a conexão falhar, pare tudo e mostre o erro.

    die("Falha na conexao: " . $conn->connect_error);

}



/* 4. Preparar a consulta (PREVENÇÃO DE SQL INJECTION)

 * Usamos '?' como placeholders seguros para os seus dados.

 */

$stmt = $conn->prepare("INSERT INTO Cliente (nome_cliente, email, CPF) VALUES (?, ?, ?)");



/* 5. Vincular os dados com segurança

 * "sss" significa que você está enviando três variáveis do tipo "string".

 */

$stmt->bind_param("sss", $nome_cliente, $email, $cpf);



// 6. Executar e verificar

if($stmt->execute() === TRUE){

    // SUCESSO: O registro foi criado.

    // Fechamos tudo e redirecionamos.

    $stmt->close();

    $conn->close();

    header("Location: index.html"); // Redireciona de volta

    exit; // Para o script

} else {

    // FALHA: O registro falhou.

    // Mostra o erro para o usuário e para a execução.

    echo "Erro ao inserir registro: " . $stmt->error;

    $stmt->close();

    $conn->close();

    exit; // Para o script

}

?>