<?php 
include 'conexion.php';
if ((isset($_GET['correo']))&&(isset($_GET['password']))) {
	
	$user=inputSeguro($mysqli,$_GET['correo']);
	$pass=inputSeguro($mysqli,$_GET['password']);
	$consulta="SELECT * FROM usuario WHERE correo='".$user."' AND password= '".$pass."'";
	$stmt = $mysqli->query($consulta);

	if($row=mysqli_fetch_array($stmt)){
		session_start();
		$_SESSION['id']=$row['id_usuario'];
		$_SESSION['nombre']=$row['nombre'];
		$_SESSION['apellido']=$row['apellido'];
		$_SESSION['correo']=$row['correo'];
		$_SESSION['cumple']=$row['fecha_nac'];
		$_SESSION['direccion']=$row['id_direccion'];
		if (isset($_GET['param'])) {
			header('location:../index.html');
		}
	}
	else{
		echo "Datos incorrectos";
	}
	return true;
	$mysqli->close();

}else{
	echo "Error desconocido 02";
}



function inputSeguro($conexion,$post)
{
    $input = htmlentities($post);
    $seguro = mysqli_real_escape_string ($conexion,$input);
    return $seguro;
}

?>