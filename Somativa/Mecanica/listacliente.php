<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lista de Clientes - Auto Tech Solutions</title>
    <link rel="icon" href="icon/logo-sem-fundo.png">
    <link rel="stylesheet" href="mecanica.css">
</head>
<body>
    <header>
        <div class="container">
            <img src="icon/logo-fundo.png" alt="Logo Auto Tech Solutions" class="header-logo">
            <h1>AUTO TECH SOLUTIONS</h1>
        </div>
    </header>

    <nav>
        <div class="container">
            <a href="index.html">🏠 INÍCIO</a>
            <a href="listacliente.php">📋 CLIENTES</a>
        </div>
    </nav>
    
    <div class="container">
        <div class="main-content">
            <section class="list-section">
                <h2>📋 CLIENTES CADASTRADOS</h2>
                
                <div class="search-bar">
                    <form method="GET" action="listacliente.php">
                        <input type="text" name="search" placeholder="🔍 Buscar por nome, CPF ou telefone..." 
                               value="<?php echo isset($_GET['search']) ? htmlspecialchars($_GET['search']) : ''; ?>">
                        <button type="submit">🔍 BUSCAR</button>
                        <?php if (isset($_GET['search'])): ?>
                            <a href="listacliente.php">🔄 LIMPAR</a>
                        <?php endif; ?>
                    </form>
                </div>
                
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>NOME</th>
                            <th>CPF</th>
                            <th>TELEFONE</th>
                            <th>VEÍCULO</th>
                            <th>SERVIÇO</th>
                            <th>PRODUTO</th>
                            <th>OBSERVAÇÃO</th>
                            <th>AÇÕES</th>
                        </tr>
                    </thead>
                    <tbody>
<?php 
$conn = new mysqli("localhost", "root", "senaisp", "Mecanica");

if ($conn->connect_error) {
    die("<tr><td colspan='9' style='color: #dc3545; text-align: center; padding: 2rem;'>❌ Conexão falhou: " . $conn->connect_error . "</td></tr>");
}

$conn->set_charset("utf8mb4");

$sql = "SELECT id_cadastro, nome_cliente, CPF, telefone, marca_veiculo, servico, nome_produto, Observacao FROM Funcionario_Cadastrar";

if (isset($_GET['search']) && !empty(trim($_GET['search']))) {
    $search = $conn->real_escape_string(trim($_GET['search']));
    $sql .= " WHERE nome_cliente LIKE '%$search%' OR CPF LIKE '%$search%' OR telefone LIKE '%$search%'";
}

$sql .= " ORDER BY id_cadastro DESC";

$result = $conn->query($sql);

if ($result->num_rows > 0) {
    while($row = $result->fetch_assoc()) {
        echo "<tr>
            <td>#{$row['id_cadastro']}</td>
            <td>{$row['nome_cliente']}</td>
            <td>{$row['CPF']}</td>
            <td>{$row['telefone']}</td>
            <td>{$row['marca_veiculo']}</td>
            <td>{$row['servico']}</td>
            <td>{$row['nome_produto']}</td>
            <td>" . ($row['Observacao'] ? $row['Observacao'] : '-') . "</td>
            <td class='actions-cell'>
                <a href='editar.php?id={$row['id_cadastro']}' class='btn-edit'>✏️ EDITAR</a>
                <button class='btn-delete' onclick='openDeleteModal({$row['id_cadastro']}, \"" . addslashes($row['nome_cliente']) . "\")'>🗑️ EXCLUIR</button>
            </td>
            </tr>";
    }
} else {
    $message = isset($_GET['search']) 
        ? "🔍 Nenhum cliente encontrado com os critérios de busca." 
        : "📋 Nenhum cliente cadastrado ainda. Cadastre o primeiro cliente!";
    echo "<tr><td colspan='9' style='text-align: center; padding: 3rem; font-size: 1.2rem;'>$message</td></tr>";
}
$conn->close();
?>
                    </tbody>
                </table>
                
                <div style="text-align: center; margin-top: 2rem;">
                    <a href="index.html" class="btn-primary" style="display: inline-block; max-width: 400px;">
                        ➕ CADASTRAR NOVO CLIENTE
                    </a>
                </div>
            </section>
        </div>
    </div>
    
    <!-- Modal de Confirmação de Exclusão -->
    <div id="deleteModal" class="modal">
        <div class="modal-content">
            <span class="modal-icon">⚠️</span>
            <h3>CONFIRMAR EXCLUSÃO</h3>
            <p>Tem certeza que deseja excluir o cliente</p>
            <p style="font-size: 1.4rem; color: var(--accent-color); font-weight: bold; margin: 1rem 0;">
                <span id="clientName"></span>
            </p>
            <p style="font-size: 1rem; color: #ff6b6b; margin-top: 1.5rem;">
                ⛔ Esta ação não pode ser desfeita!
            </p>
            <div class="modal-buttons">
                <button onclick="closeDeleteModal()" class="btn-modal-cancel">❌ CANCELAR</button>
                <button id="confirmDelete" class="btn-modal-delete">✅ CONFIRMAR</button>
            </div>
        </div>
    </div>

    <!-- Modal de Sucesso -->
    <div id="successModal" class="modal">
        <div class="modal-content" style="border-color: #28a745;">
            <span class="modal-icon" style="color: #28a745;">✅</span>
            <h3 id="successTitle" style="color: #28a745;">SUCESSO!</h3>
            <p id="successMessage"></p>
            <div class="modal-buttons">
                <button onclick="closeSuccessModal()" class="btn-modal-cancel">🔧 FECHAR</button>
            </div>
        </div>
    </div>

    <!-- Modal de Erro -->
    <div id="errorModal" class="modal">
        <div class="modal-content" style="border-color: #dc3545;">
            <span class="modal-icon" style="color: #dc3545;">❌</span>
            <h3 id="errorTitle" style="color: #dc3545;">ERRO!</h3>
            <p id="errorMessage"></p>
            <div class="modal-buttons">
                <button onclick="closeErrorModal()" class="btn-modal-cancel">🔙 FECHAR</button>
            </div>
        </div>
    </div>

    <footer>
        <div class="container">
            <p>🔧 © 2025 AUTO TECH SOLUTIONS - OFICINA MECÂNICA PROFISSIONAL ⚙️</p>
        </div>
    </footer>

    <script>
        let currentDeleteId = null;

        function openDeleteModal(id, nome) {
            currentDeleteId = id;
            document.getElementById('clientName').textContent = nome;
            document.getElementById('deleteModal').style.display = 'flex';
            document.body.style.overflow = 'hidden';
        }

        function closeDeleteModal() {
            document.getElementById('deleteModal').style.display = 'none';
            document.body.style.overflow = 'auto';
            currentDeleteId = null;
        }

        function showSuccessModal(title, message) {
            document.getElementById('successTitle').textContent = title;
            document.getElementById('successMessage').textContent = message;
            document.getElementById('successModal').style.display = 'flex';
            document.body.style.overflow = 'hidden';
            createConfetti();
        }

        function closeSuccessModal() {
            document.getElementById('successModal').style.display = 'none';
            document.body.style.overflow = 'auto';
        }

        function showErrorModal(title, message) {
            document.getElementById('errorTitle').textContent = title;
            document.getElementById('errorMessage').textContent = message;
            document.getElementById('errorModal').style.display = 'flex';
            document.body.style.overflow = 'hidden';
        }

        function closeErrorModal() {
            document.getElementById('errorModal').style.display = 'none';
            document.body.style.overflow = 'auto';
        }

        document.getElementById('confirmDelete').addEventListener('click', function() {
            if (currentDeleteId) {
                const btn = this;
                btn.textContent = '🔄 EXCLUINDO...';
                btn.disabled = true;
                btn.style.opacity = '0.7';
                
                setTimeout(() => {
                    window.location.href = 'deletar.php?id=' + currentDeleteId;
                }, 800);
            }
        });

        // Fechar modal ao clicar fora
        document.querySelectorAll('.modal').forEach(modal => {
            modal.addEventListener('click', function(e) {
                if (e.target === this) {
                    this.style.display = 'none';
                    document.body.style.overflow = 'auto';
                }
            });
        });

        // Fechar modal com ESC
        document.addEventListener('keydown', function(e) {
            if (e.key === 'Escape') {
                document.querySelectorAll('.modal').forEach(modal => {
                    modal.style.display = 'none';
                });
                document.body.style.overflow = 'auto';
            }
        });

        // Mostrar modais de sucesso/erro
        window.addEventListener('load', function() {
            const urlParams = new URLSearchParams(window.location.search);
            if (urlParams.has('success')) {
                showSuccessModal('✅ OPERAÇÃO CONCLUÍDA!', urlParams.get('success'));
                window.history.replaceState({}, document.title, window.location.pathname);
            }
            if (urlParams.has('error')) {
                showErrorModal('❌ ERRO NA OPERAÇÃO!', urlParams.get('error'));
                window.history.replaceState({}, document.title, window.location.pathname);
            }
        });

        // Confete para sucesso
        function createConfetti() {
            const colors = ['#ff6b00', '#ffa500', '#ffcc00', '#28a745'];
            const emojis = ['🔧', '⚙️', '🔩', '🛠️', '⚡', '✨'];
            
            for (let i = 0; i < 60; i++) {
                setTimeout(() => {
                    const confetti = document.createElement('div');
                    confetti.textContent = Math.random() > 0.5 ? emojis[Math.floor(Math.random() * emojis.length)] : '';
                    confetti.style.position = 'fixed';
                    confetti.style.width = confetti.textContent ? 'auto' : '12px';
                    confetti.style.height = confetti.textContent ? 'auto' : '12px';
                    confetti.style.fontSize = '28px';
                    confetti.style.backgroundColor = confetti.textContent ? 'transparent' : colors[Math.floor(Math.random() * colors.length)];
                    confetti.style.left = Math.random() * 100 + '%';
                    confetti.style.top = '-30px';
                    confetti.style.borderRadius = '50%';
                    confetti.style.pointerEvents = 'none';
                    confetti.style.zIndex = '99999';
                    confetti.style.animation = `confettiFall ${2 + Math.random() * 2}s linear forwards`;
                    confetti.style.filter = 'drop-shadow(0 0 5px currentColor)';
                    
                    document.body.appendChild(confetti);
                    
                    setTimeout(() => confetti.remove(), 5000);
                }, i * 20);
            }
        }

        // Adiciona CSS da animação
        const style = document.createElement('style');
        style.textContent = `
            @keyframes confettiFall {
                to {
                    transform: translateY(100vh) rotate(720deg);
                    opacity: 0;
                }
            }
        `;
        document.head.appendChild(style);
    </script>
</body>
</html>