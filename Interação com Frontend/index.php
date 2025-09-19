<?php 
//Comunicação com banco de dados

$mysqli = mysqli_connect("localhost","root",
"senaisp","codigoseletras");

// Segurança em buscar valores no Banco
$columns = array("titulo","preco","qtd");

//trazer o conteudo do Banco 
$columns = isset($_GET['column']) && in_array($_GET['column'], $columns) 
? $_GET['column'] : $columns[0];

//trazer dados em ordem e decrescente 
$sort_order = isset($_GET['order']) && strtolower($_GET['order']) == 'desc' ? 'DESC' : 'ASC';

//verificar dados no Banco
if ($result = $mysqli->query('select * from Livros order by ' . $columns . '' . $sort_order))
{//Várias para a tabela
$up_or_down = str_replace(array('ASC','DESC'),array('up','down'),$sort_order);
$asc_or_desc = $sort_order == 'ASC' ? 'desc' : 'asc'; 
$add_class = 'class="highligth"';





?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Banco de Dados - Codigo e Letras</title>
</head>
<body>
    <table>
        <tr>
<th><a href="index.php?column=titulo$order=<?php echo $asc_or_desc; ?>">titulo <?php
echo $columns == 'titulo' ? '-' . $up_or_down: ''; ?></a>
</th>

<th><a href="index.php?column=preco$order=<?php echo $asc_or_desc; ?>">Preco <?php
echo $columns == 'preco' ? '-' . $up_or_down: ''; ?></a>
</th>

<th><a href="index.php?column=qtd$order=<?php echo $asc_or_desc; ?>">Qtd <?php
echo $columns == 'qtd' ? '-' . $up_or_down: ''; ?></a>
</th>
        </tr>
        <?php while ($row = $result->fetch_assoc()): ?>
        <tr>
            <td>
        <?php echo $columns == 'titulo' ? $add_class : ''; ?>> <?php echo $row ['Titulo']; ?> 
            </td>

               <td>
        <?php echo $columns == 'preco' ? $add_class : ''; ?>> <?php echo $row ['preco']; ?> 
            </td>

               <td>
        <?php echo $columns == 'qtd' ? $add_class : ''; ?>> <?php echo $row ['qtd']; ?> 
            </td>
            <?php endwhile;?>
        </tr>
    </table>
</body>
</html>

<?php $result->free();

}

?>