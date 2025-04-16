<?php
session_start();
$host = 'localhost:3308'; // Servidor MySQL
$dbname = 'binted_db'; // Nombre de la base de datos
$user = 'root'; // Usuario de MySQL (cambia si tienes otro)
$pass = ''; // Contraseña de MySQL (pon la tuya si tienes una)

$conn = new mysqli($host, $user, $pass, $dbname);

// Verificamos la conexión con la base de datos
if ($conn->connect_error) {
    die("Conexión fallida: " . $conn->connect_error);
}

// Recibir los datos del formulario
$username = $_POST['username'];
$password = $_POST['password'];

// Buscar el usuario en la base de datos
$sql = "SELECT * FROM users WHERE username = ?";
$stmt = $conn->prepare($sql);
$stmt->bind_param("s", $username);
$stmt->execute();
$result = $stmt->get_result();

if ($result->num_rows > 0) {
    $user = $result->fetch_assoc();
    if (password_verify($password, $user['password'])) { // Compara la contraseña ingresada con la guardada
        $_SESSION['username'] = $user['username'];
        $_SESSION['role'] = $user['role'];
        echo json_encode(["status" => "success", "role" => $user['role']]);
    } else {
        echo json_encode(["status" => "error", "message" => "Contraseña incorrecta"]);
    }
} else {
    echo json_encode(["status" => "error", "message" => "Usuario no encontrado"]);
}

$conn->close();
?>
