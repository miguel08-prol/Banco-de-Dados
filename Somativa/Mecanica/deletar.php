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

$check_sql = "SELECT * FROM Funcionario_Cadastrar WHERE id_cadastro = '$id'";
$check_result = $conn->query($check_sql);

if ($check_result->num_rows === 0) {
    header("Location: listacliente.php?error=Cliente não encontrado.");
    exit;
}

$sql = "DELETE FROM Funcionario_Cadastrar WHERE id_cadastro = '$id'";

if ($conn->query($sql)) {
    header("Location: listacliente.php?success=Cliente excluído com sucesso!");
} else {
    header("Location: listacliente.php?error=Erro ao excluir cliente: " . $conn->error);
}

$conn->close();
?>